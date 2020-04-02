//
//  ItemCell.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import TelstraAPI

class ItemCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .circularBold(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .circularBook(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(content: Content?) -> UICollectionViewCell {
        
        self.titleLabel.text = content?.title
        
        self.descriptionLabel.text = content?.description
        
        self.imageView.setImage(content?.imageHref)
        
        self.layoutItems()
        
        self.layoutIfNeeded()
        
        return self
    }
    
    class func size(givenWidth width: CGFloat, content: Content?) -> CGSize {
        
        let _width = width > 414.0 ? width / 2 : width
        
        return CGSize(width: _width, height: 350.0)
    }
    
    private func layoutItems() {
        
        self.backgroundColor = .white
        self.shadowColor = UIColor.black.withAlphaComponent(0.1)
        self.shadowRadius = 10.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.cornerRadius = 10.0

        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

