//
//  TelstraTests.swift
//  TelstraTests
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest
@testable import Telstra
@testable import TelstraAPI

class TelstraTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func testData() {
        
        let feed = getMockFeed()
        
        let contents = feed?.rows
        
        XCTAssertTrue(contents?[7].isNil == true, "Content must be nil with no title, description, image")
        
        XCTAssertEqual(contents?[0].title, "Beavers", "Title must be beavers")
        
        XCTAssertNotNil(contents?[0].id, "Id was not generated")
        
        XCTAssertEqual(contents?[0], contents?[0], "Equality test failed")
        
        XCTAssertNotEqual(contents?[0], contents?[1], "Equality test: Content 0 and 1 must not be equal")
    }
    
    func testViewItemEnum() {
        
        let feed = getMockFeed()
        
        let contents = feed?.rows
        
        var items = [ViewItem]()
        
        contents?.forEach {
            
            items.append(.item($0))
        }
        
        XCTAssertEqual(items[0], items[0], "Equality test failed")
        
        XCTAssertNotEqual(items[0], items[1], "Equality test: Item 0 and 1 must not be equal")
        
        
        if case .item(let content) = items[0], let firstContent = contents?.first {

            XCTAssertEqual(content.title, "Beavers", "Title must be beavers")
            
            XCTAssertEqual(items[0], ViewItem.item(firstContent), "Equality test failed")
        }
        else {
            
            XCTAssert(false, "Item was not set properly")
        }
    }

    private func getMockFeed() -> Feed? {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var feed: Feed?
                
        DataHelper.getMockData { (response) in
            
            switch response {
                
            case .success(let _feed):
                
                feed = _feed
                
            case .failure:
                
                feed = nil
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return feed
    }
}
