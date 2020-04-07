//
//  ViewController.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import TelstraAPI
import collection_view_layouts

enum ViewSection: Equatable {
    
    case section
}

enum ViewItem: Equatable {
    
    case item(Content)
    
    static func == (lhs: ViewItem, rhs: ViewItem) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.item(let lhsContent), .item(let rhsContent)):
            
            return lhsContent == rhsContent
        }
    }
}

class ViewController: JCollectionViewController<ViewSection, ViewItem>, LayoutDelegate {
    
    private var viewModel: ViewModelProtocol?
    
    private lazy var layout: PinterestLayout = {
        
        let layout = PinterestLayout()
        
        layout.delegate = self
        
        layout.cellsPadding = ItemsPadding(horizontal: 20, vertical: 20)
        
        layout.contentPadding = ItemsPadding(horizontal: 20, vertical: 20)
        
        layout.columnsCount = Int(self.columns)
        
        return layout
    }()
    
    private lazy var _collectionView: UICollectionView? = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.setCollectionViewLayout(self.layout, animated: true)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        if #available(iOS 13.0, *) {
            
            collectionView.backgroundColor = .systemGray6
        }
        else {
            
            collectionView.backgroundColor = .white
        }
        
        collectionView.clipsToBounds = false
        
        return collectionView
    }()
    
    private var refreshControl = UIRefreshControl()
    
    private var columns: CGFloat {
        
        if let width = self.view?.frame.width {
            
            return width >= 1024.0 ? 3 : (width > 414.0 ? 2 : 1)
        }
        return 1
    }
    
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
        
        if #available(iOS 13.0, *) {
            
            self.view.backgroundColor = .systemGray6
        }
        else {
            
            self.view.backgroundColor = .white
        }
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
    
    /// Pull-to-refresh
    private func setupPullToRefresh() {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        
        self.refreshControl.addTarget(self, action: #selector(onRefresh), for: UIControl.Event.valueChanged)
        
        self.collectionView?.refreshControl = self.refreshControl
    }
    
    /// setup the ViewModel callbacks and their behaviours
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            DispatchQueue.main.async {

                self?.title = self?.viewModel?.title
                
                self?.updateSectionsAndItems()
                
                self?.refreshControl.endRefreshing()
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
        
        self.setupPullToRefresh()
        
        self.viewModel?.getContents()
        
        if let collectionView = self.collectionView {
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        self.layout.columnsCount = Int(self.columns)
        
        self.layout.invalidateLayout()
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: ViewSection, item: ViewItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .item(let content) = item, let id = content.id {
            
            if let cell = self.collectionView?.dequeueReusable(cell: ItemCell.self, for: indexPath) {
                
                return cell.prepare(
                    content: content,
                    image: self.viewModel?.images[id]
                ) { [weak self] image in
                    
                    guard image != nil else {
                            
                        return
                    }

                    self?.viewModel?.images[id] = image
                    
                    DispatchQueue.main.async {
                        
                        self?.reload(atSection: section, item: item)
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: ViewSection, item: ViewItem, indexPath: IndexPath) -> CGSize? {
        
        if case .item(let content) = item {
            
            var imageSize: CGSize?
            
            if let id = content.id,
                let image = self.viewModel?.images[id] {
                
                imageSize = image.size
            }
            
            return ItemCell.size(
                givenWidth: collectionView.frame.width,
                imageSize: imageSize,
                content: content,
                columns: self.columns)
        }
        
        return .zero
    }
    
    // MARK: - Actions
    
    @objc
    func onRefresh() {
        
        self.viewModel?.contents?.removeAll()
        
        self.updateSectionsAndItems(forced: true)
        
        self.viewModel?.getContents()
    }
    
    // MARK: - LayoutDelegate
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        
        if let collectionView = self.collectionView,
            let (section, item) = self.sectionAndItem(atIndexPath: indexPath),
            let size = self.collectionView(
                collectionView,
                layout: self.layout,
                sizeForSection: section,
                item: item,
                indexPath: indexPath
            ) {
            
            return size
        }
        
        return .zero
    }
    
    override func orientationChanged() {
        
        super.orientationChanged()
    }
}

