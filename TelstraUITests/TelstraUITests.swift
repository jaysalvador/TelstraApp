//
//  TelstraUITests.swift
//  TelstraUITests
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest

class TelstraUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        
        self.app = XCUIApplication()
        
    }

    override func tearDown() {

    }

    func testSwiping() {
        
        self.app.launch()
        
        let identifierToFind = "Language"
        
        var identifier: String? = ""
        
        let firstCell = self.app.collectionViews.cells.firstMatch
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        
        start.press(forDuration: 0, thenDragTo: finish)
                
        let cell = self.app.collectionViews.cells[identifierToFind]
        
        // Swipe down until it is visible
        while !cell.exists {
            
            let currentIdentifier = self.app.collectionViews.cells.allElementsBoundByIndex.last?.identifier
                        
            if identifier != currentIdentifier {

                identifier = currentIdentifier
                
                self.app.swipeUp()
            }
            else {
                
                // end of swiping
                
                XCTAssert(false, "Unable to find Element \(identifierToFind)")
                
                break
            }
        }
        
        self.app.swipeUp()
        
    }
}
