//
//  UIImageView.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ stringUrl: String?, clearCache: Bool? = false) {
        
        self.image = nil
        
        guard let stringUrl = stringUrl else {
            
            return
        }
        
        guard let url = URL(string: stringUrl) else {
            
            return
        }
        
        self.setImage(url, clearCache: clearCache)
    }
    
    func setImage(_ url: URL?, clearCache: Bool? = false, indicatorType: IndicatorType? = .activity) {
        
        self.image = nil
        
        guard let url = url else {
            
            return
        }
        
        if clearCache == true {
        
            let cache = ImageCache.default
        
            cache.removeImage(forKey: url.absoluteString)
        }
        
        self.kf.indicatorType = indicatorType ?? .none
        
        self.kf.setImage(
            with: ImageResource(downloadURL: url, cacheKey: url.absoluteString),
            placeholder: nil,
            options: nil,
            progressBlock: nil) { [weak self] _ in
                
                self?.contentMode = .scaleAspectFill
                self?.setNeedsLayout()
        }
    }
}
