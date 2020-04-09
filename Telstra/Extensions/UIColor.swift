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
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(red: (1 - red), green: (1 - green), blue: (1 - blue), alpha: alpha)
    }
}
