//
//  DataHelper.swift
//  TelstraTests
//
//  Created by Jay Salvador on 7/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import TelstraAPI

typealias HelperCompletionClosure = ((Result<Feed, Error>) -> Void)

class DataHelper {
    
    class func getMockData(completion: HelperCompletionClosure?) {

        let dataPath = Bundle(for: DataHelper.self).path(forResource: "data", ofType: "json") ?? ""
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: dataPath))
            
            let decoder = JSONDecoder()
                        
            let decoded = try decoder.decode(Feed.self, from: data)
            
            completion?(.success(decoded))
        }
        catch {

            completion?(.failure(error))
        }
    }
}
