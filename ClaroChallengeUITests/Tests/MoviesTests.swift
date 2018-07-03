//
//  MoviesTests.swift
//  ClaroChallengeUITests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest

class MoviesTests: BaseTests {
        
    override func setUp() {
        super.setUp()
        MoviesScreen.waitScreen(testCase: self)
    }
    
    /// Test collection view load itens
    func testTableLoad() {
        let cell = MoviesScreen.upcomingCell()
        waitElementExists(element: cell)
        XCTAssertTrue(cell.exists, "Cell does not existis.")
    }
    
    /// Test movie type selection
    func testMovieTypeChanges() {
        let popular = MoviesScreen.popularSegment()
        waitElementExists(element: popular)
        popular.tap()
        
        var cell = MoviesScreen.popularCell()
        var title = app.staticTexts["Popular Movies"]
        waitElementExists(element: cell)
        waitElementExists(element: title)
        
        XCTAssertTrue(cell.exists, "Cell does not exists.")
        XCTAssertTrue(title.exists, "Title does not exists")
        
        let upcoming = MoviesScreen.upcomingSegment()
        waitElementExists(element: upcoming)
        upcoming.tap()
        
        cell = MoviesScreen.upcomingCell()
        title = app.staticTexts["Upcoming Movies"]
        waitElementExists(element: cell)
        waitElementExists(element: title)
        
        XCTAssertTrue(title.exists, "Title does not exists.")
        XCTAssertTrue(cell.exists, "Cell does not exists.")
        
    }
    
    // Test user flow to Details view
    func testGoToDetails() {
        let cell = MoviesScreen.upcomingCell()
        waitElementExists(element: cell)
        cell.tap()
        DetailsScreen.waitScreen(testCase: self)
    }
    
    /// Test Details view with elements
    func testDetails() {
        let cell = MoviesScreen.upcomingCell()
        waitElementExists(element: cell)
        cell.tap()
        DetailsScreen.waitScreen(testCase: self)
        let title = DetailsScreen.titleElement()
        let description = DetailsScreen.descriptionElement()
        let banner = DetailsScreen.bannerElement()
        let poster = DetailsScreen.posterElement()
        let credits = DetailsScreen.creditsElement()
        let trailers = DetailsScreen.trailerElement()
        let anthonyGonzalezElement = credits.cells.otherElements.containing(.staticText, identifier: "Anthony Gonzalez").element
        
        waitElementExists(element: title)
        waitElementExists(element: description)
        waitElementExists(element: banner)
        waitElementExists(element: poster)
        waitElementExists(element: credits)
        waitElementExists(element: trailers)
        waitElementExists(element: anthonyGonzalezElement)
        
        XCTAssert(title.exists)
        XCTAssert(description.exists)
        XCTAssert(banner.exists)
        XCTAssert(poster.exists)
        XCTAssert(credits.exists)
        XCTAssert(trailers.exists)
        XCTAssert(anthonyGonzalezElement.exists)
        
        XCTAssertEqual(title.label, "Coco")
        XCTAssertEqual(description.label, "Despite his family’s baffling generations-old ban on music, Miguel dreams of becoming an accomplished musician like his idol, Ernesto de la Cruz. Desperate to prove his talent, Miguel finds himself in the stunning and colorful Land of the Dead following a mysterious chain of events. Along the way, he meets charming trickster Hector, and together, they set off on an extraordinary journey to unlock the real story behind Miguel's family history.")
        
    }
    
    /// Test Details back gesture
    func testDetailsBackGesture() {
        let cell = MoviesScreen.upcomingCell()
        waitElementExists(element: cell)
        cell.tap()
        DetailsScreen.waitScreen(testCase: self)
        let title = DetailsScreen.titleElement()
        title.swipeDown()
        MoviesScreen.waitScreen(testCase: self)
    }
    
}
