//
//  DetailsScreen.swift
//  ClaroChallengeUITests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest

class DetailsScreen: BaseScreen {
    
    static let screenIdentifier = "detailsScreen"
    static let titleLabel = "titleLabel"
    static let descriptionLabel = "descriptionLabel"
    static let bannerImage = "bannerImage"
    static let posterImage = "posterImage"
    static let creditsCollection = "CreditsCollection"
    static let trailerCollection = "TrailerCollection"
    
    static let screen = XCUIApplication().otherElements[screenIdentifier]
    
    /// Wait to screen to be shown
    ///
    /// - Parameter testCase: test case use to assert the screen presentation
    static func waitScreen(testCase: XCTestCase) {
        testCase.waitElementExists(element: screen)
    }
    
    /// Title Element
    ///
    /// - Returns: element representing movie title
    static func titleElement() -> XCUIElement {
        let element = screen.staticTexts[titleLabel]
        return element
    }
    
    /// Desciption Element
    ///
    /// - Returns: element representing movie Desciption
    static func descriptionElement() -> XCUIElement {
        let element = screen.staticTexts[descriptionLabel]
        return element
    }
    
    /// Banner Element
    ///
    /// - Returns: element representing movie Banner
    static func bannerElement() -> XCUIElement {
        let element = screen.images[bannerImage]
        return element
    }
    
    /// Poster Element
    ///
    /// - Returns: element representing movie Poster
    static func posterElement() -> XCUIElement {
        let element = screen.images[posterImage]
        return element
    }
    
    static func creditsElement() -> XCUIElement {
        let element = screen.collectionViews[creditsCollection]
        return element
    }
    
    static func trailerElement() -> XCUIElement {
        let element = screen.collectionViews[trailerCollection]
        return element
    }
}
