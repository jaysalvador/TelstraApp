//
//  UIColor.swift
//  Telstra
//
//  Created by Jay Salvador on 7/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIColor {
    
    var inverted: UIColor {
        
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a)
    }
}
