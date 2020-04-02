//
//  Feed.swift
//  TelstraAPI
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Feed: Codable {
    
    public var title: String?
    public var rows: [Content]?
}
