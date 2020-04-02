//
//  DispatchQueue.swift
//  TelstraAPI
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// Accessible variable for the Background Queue
    public class var background: DispatchQueue {
        
        return DispatchQueue.global(qos: .background)
    }
}
