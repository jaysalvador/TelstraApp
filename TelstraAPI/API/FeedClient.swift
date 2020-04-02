//
//  FeedClient.swift
//  TelstraAPI
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public protocol FeedClientProtocol {
    
    func getFeed(onCompletion: HttpCompletionClosure<Feed>?)
}

public class FeedClient: HttpClient, FeedClientProtocol {
    
    func getFeed(onCompletion: HttpCompletionClosure<Feed>?) {
        
        self.request(
            Feed.self,
            endpoint: "/2iodh4vg0eortkl/facts.json",
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}
