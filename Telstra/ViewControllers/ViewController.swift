//
//  ViewController.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import TelstraAPI
import UICollectionViewLeftAlignedLayout

enum ViewSection: Equatable {
    
    case section
}

enum ViewItem: Equatable {
    
    case item(Content)
}

class ViewController: JCollectionViewController<ViewSection, ViewItem> {
    
    private var viewModel: ViewModelProtocol?
    
    private lazy var flowLayout: UICollectionViewLeftAlignedLayout = {
        
        let layout = UICollectionViewLeftAlignedLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return layout
    }()
    
    private lazy var _collectionView: UICollectionView? = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.setCollectionViewLayout(self.flowLayout, animated: true)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        
        collectionView.clipsToBounds = false
        
        return collectionView
    }()
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    /// Convenience init that declares a default viewmodel
    convenience override init() {
        
        self.init(viewModel: ViewModel())
    }
    
    /// Creates a new `CurrencyViewController` with a custom ViewModel that adheres to `CurrencyViewModelProtocol`
    /// - Parameter _viewModel: a ViewModel that applies `CurrencyViewModelProtocol`
    init(viewModel _viewModel: ViewModelProtocol?) {
        
        super.init()
        
        self.viewModel = _viewModel
        
        self.setupViewModel()
    }
    
    /// generates the items based on the data given by the `ViewModel` that will be rendered on the `CollectionView`
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [ViewItem]()
        
        self.viewModel?.contents?.forEach {
            
            items.append(.item($0))
        }
        
        return [(.section, items)]
    }
    
    // MARK: - Setup
    
    /// setup the ViewModel callbacks and their behaviours
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            DispatchQueue.main.async {

                self?.title = self?.viewModel?.title
                
                self?.updateSectionsAndItems()
            }
        }
    }
    
    override func setupCollectionView() {
        
        self.collectionView = self._collectionView
        
        if let collectionView = self.collectionView {
            
            self.view.addSubview(collectionView)
            
            super.setupCollectionView()
            
            collectionView.register(cell: ItemCell.self)
        }
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.viewModel?.getContents()
    }
    
    override func viewWillLayoutSubviews() {
        
        if let collectionView = self.collectionView {
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: ViewSection, item: ViewItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .item(let content) = item {
            
            if let cell = self.collectionView?.dequeueReusable(cell: ItemCell.self, for: indexPath) {
                
                return cell.prepare(content: content)
            }
        }
        return nil
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: ViewSection, item: ViewItem, indexPath: IndexPath) -> CGSize? {
        
        if case .item(let content) = item {
            
            return ItemCell.size(givenWidth: collectionView.frame.width, content: content)
        }
        
        return .zero
    }
}

