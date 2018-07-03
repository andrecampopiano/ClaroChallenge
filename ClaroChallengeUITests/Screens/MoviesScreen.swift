//
//  MoviesScreen.swift
//  ClaroChallengeUITests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest

class MoviesScreen: BaseScreen {
    
    static let screenIdentifier = "moviesScreen"
    static let movieLoadTest = "Coco"
    static let movieLoadTextPopular = "The Maze Runner"
    
    /// Wait to screen to be shown
    ///
    /// - Parameter testCase: test case use to assert the screen presentation
    static func waitScreen(testCase: XCTestCase) {
        let screen = XCUIApplication().collectionViews[screenIdentifier]
        testCase.waitElementExists(element: screen)
    }
    
    static func upcomingCell() -> XCUIElement {
        let collection = XCUIApplication().collectionViews[MoviesScreen.screenIdentifier]
        let cell = collection.cells.element(boundBy: 0).staticTexts[MoviesScreen.movieLoadTest]
        return cell
    }
        
    ///Single tap on popular
    static func popularSegment() -> XCUIElement {
        let element = XCUIApplication().navigationBars.buttons.element(boundBy: 1)
        return element
    }
    
    /// Single tap on upcoming
    static func upcomingSegment() -> XCUIElement {
        let element = XCUIApplication().navigationBars.buttons.element(boundBy: 0)
        return element
    }
    
    /// Popular cell from collection view
    ///
    /// - Returns: element representing popular cell
    static func popularCell() -> XCUIElement {
        let collection = XCUIApplication().collectionViews[MoviesScreen.screenIdentifier]
        let cell = collection.cells.element(boundBy: 0).staticTexts[MoviesScreen.movieLoadTextPopular]
        return cell
    }
}
