//
//  CastTests.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class CastTests: XCTestCase {
    
    var mock: BaseMock?
    let bundle = Bundle(for: CastTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCastParse() {
        mock = BaseMock(file: "cast", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let cast = try JSONDecoder().decode(Cast.self, from: jsonData)
            
            XCTAssertEqual(cast.character!, "Michael MacCauley")
            XCTAssertEqual(cast.name!, "Liam Neeson")
            XCTAssertEqual(cast.profilePath!, "/9mdAohLsDu36WaXV2N3SQ388bvz.jpg")
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testCastParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let cast = try JSONDecoder().decode(Cast.self, from: jsonData)
            
            XCTAssertNotNil(cast)
            XCTAssertNil(cast.character)
            XCTAssertNil(cast.name)
            XCTAssertNil(cast.profilePath)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testCastParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonData))
        } catch { }
    }
}
