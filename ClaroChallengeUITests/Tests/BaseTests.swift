//
//  BaseTests.swift
//  ClaroChallengeUITests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest

class BaseTests: XCTestCase {
    
    // MARK: - Constants
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = true
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
