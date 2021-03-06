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
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            
            label.textColor = UIColor.systemGray6.inverted
        }
        else {
            
            label.textColor = .black
        }
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .circularBook(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
        
            label.textColor = UIColor.systemGray3.inverted
        }
        else {
            
            label.textColor = .darkGray
        }
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()

    private var imageHeightAnchor: NSLayoutConstraint?

    private var titleLabelTopAnchor: NSLayoutConstraint?

    private var descriptionLabelTopAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
        
        if #available(iOS 13.0, *) {
            
            self.backgroundColor = .systemGray6
            
            self.borderColor = UIColor.systemGray.withAlphaComponent(0.5)
        }
        else {
            
            self.backgroundColor = .white
            
            self.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        
        self.cornerRadius = 10.0
        
        self.borderWidth = 1.0
        
        self.clipsToBounds = true
        
        self.layoutItems()
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(content: Content?, image: UIImage?, onImageDownloaded: ImageDownloadedCallback? = nil) -> UICollectionViewCell {
        
        self.imageView.image = nil
        
        self.titleLabel.text = content?.title
        
        self.descriptionLabel.text = content?.description
        
        if let image = image {
            
            self.imageView.image = image
        }
        else {

            self.imageView.setImage(content?.imageHref) { image in
                
                onImageDownloaded?(image)
            }
        }
        
        self.imageView.contentMode = .scaleAspectFit
        
        let imageHeight = image?.size.height ?? 0.0
        
        let scaledHeight = min(200.0, imageHeight)
        
        let titleTopAnchor: CGFloat = imageHeight > 0 ? 8.0 : 0.0
        
        self.imageHeightAnchor?.constant = scaledHeight
        
        self.titleLabelTopAnchor?.constant = titleTopAnchor
        
        self.descriptionLabelTopAnchor?.constant = content?.description != nil ? 8.0 : 0.0
        
        self.layoutIfNeeded()
        
        self.accessibilityIdentifier = content?.title
        
        return self
    }
    
    class func size(
        givenWidth: CGFloat,
        imageSize: CGSize?,
        content: Content?,
        columns: CGFloat = 1) -> CGSize {
        
        var width = givenWidth / columns
        
        width -= 40.0
        
        let imageHeight = imageSize?.height ?? 0.0
        
        let scaledHeight = min(200.0, imageHeight)
        
        let descriptionAnchor: CGFloat = content?.description != nil ? 8.0 : 0.0
        
        var height: CGFloat = 20.0 + 8.0 + descriptionAnchor + scaledHeight + 20.0
        
        if let rect = content?.title?.boundingRect(
            with: CGSize(
                width: width - (40.0),
                height: CGFloat.greatestFiniteMagnitude),
            options: [
                .usesLineFragmentOrigin,
                .usesFontLeading,
                .truncatesLastVisibleLine
            ],
            font: .circularBold(ofSize: 20.0)
        ) {
            
            height += rect.height
        }
        
        if let rect = content?.description?.boundingRect(
            with: CGSize(
                width: width - (40.0),
                height: CGFloat.greatestFiniteMagnitude),
            options: [
                .usesLineFragmentOrigin,
                .usesFontLeading,
                .truncatesLastVisibleLine
            ],
            font: .circularBook(ofSize: 14.0)
        ) {
            
            height += rect.height
        }
        
        return CGSize(width: width, height: height)
    }
    
    private func layoutItems() {
        
        self.imageHeightAnchor = self.imageView.heightAnchor.constraint(equalToConstant: 0)
        
        self.titleLabelTopAnchor = self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0)
        
        self.descriptionLabelTopAnchor = self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 0)
        
        self.imageHeightAnchor?.isActive = true
        
        self.titleLabelTopAnchor?.isActive = true
        
        self.descriptionLabelTopAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.imageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
}
