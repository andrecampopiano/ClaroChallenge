//
//  TrailerTests.swift
//  ClaroChallengeTests
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class TrailerTests: XCTestCase {
    
    var mock: BaseMock?
    let bundle = Bundle(for: MovieTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
    mock = BaseMock(file: "trailer", error: nil, bundle: bundle)
    do {
    let jsonData = try mock!.json()
    let trailer = try JSONDecoder().decode(Trailer.self, from: jsonData)
    
    XCTAssertEqual(trailer.identifier!, "5a10650592514138f60303df")
    XCTAssertEqual(trailer.key!, "ZJDMWVZta3M")
    
    } catch {
    XCTFail("Parse should not fail")
    }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let trailer = try JSONDecoder().decode(Trailer.self, from: jsonData)
            
            XCTAssertNotNil(trailer)
            XCTAssertNil(trailer.identifier)
            XCTAssertNil(trailer.key)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Trailer.self, from: jsonData))
        } catch { }
    }
    
    
}
