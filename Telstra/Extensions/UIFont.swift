//
//  UIFont.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func circularBlack(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "CircularStd-Black", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    class func circularBold(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "CircularStd-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    class func circularBook(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "CircularStd-Book", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    class func circularMedium(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "CircularStd-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
}
