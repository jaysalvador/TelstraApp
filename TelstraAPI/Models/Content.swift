//
//  Content.swift
//  TelstraAPI
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Content: Codable {
    
    public var id: String?
    public var title: String?
    public var description: String?
    public var imageHref: String?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        
        case title
        case description
        case imageHref
    }

    // decoder override to handle dates and numbers
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID().uuidString
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageHref = try container.decodeIfPresent(String.self, forKey: .imageHref)
    }
}

extension Content: Equatable {
    
    // add equatable to compare Currency objects
    
    public static func == (lhs: Content, rhs: Content) -> Bool {
        
        return lhs.id == rhs.id
    }
}

extension Content {
    
    public var isNil: Bool {
        
        return self.title == nil && self.description == nil && self.imageHref == nil
    }
}
