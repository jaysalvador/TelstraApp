//
//  Content.swift
//  TelstraAPI
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Content: Codable {
    
    public var title: String?
    public var description: String?
    public var imageHref: String?
    
}

extension Content: Equatable {
    
    // add equatable to compare Currency objects
    
    public static func == (lhs: Content, rhs: Content) -> Bool {
        
        return lhs.title == rhs.title
    }
}
