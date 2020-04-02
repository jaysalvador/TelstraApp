//
//  String.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension String {

    /// measuring String bounds in a rectangle
    func boundingRect(with size: CGSize, options: NSStringDrawingOptions, font: UIFont) -> CGRect {
        
        return self.boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
    }
    
    func boundingRect(with size: CGSize, options: NSStringDrawingOptions, attributes: [NSAttributedString.Key: Any]?, context: NSStringDrawingContext?) -> CGRect {
        
        let _string = self as NSString
        
        return _string.boundingRect(with: size, options: options, attributes: attributes, context: context)
    }
}
