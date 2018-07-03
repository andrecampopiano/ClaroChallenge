//
//  TrailerListTests.swift
//  ClaroChallengeTests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class TrailerListTests: XCTestCase {
    
    var mock: BaseMock?
    let bundle = Bundle(for: TrailerListTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "trailer_list", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let trailers = try JSONDecoder().decode(TrailerList.self, from: jsonData)
            XCTAssert((trailers.results?.count ?? 0) > 0)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let trailers = try JSONDecoder().decode(TrailerList.self, from: jsonData)
            XCTAssertNil(trailers.results)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(TrailerList.self, from: jsonData))
        } catch { }
    }
    
}
