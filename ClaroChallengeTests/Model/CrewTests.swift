//
//  CrewTests.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class CrewTests: XCTestCase {

    var mock: BaseMock?
    let bundle = Bundle(for: CrewTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "crew", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let crew = try JSONDecoder().decode(Crew.self, from: jsonData)
            
            XCTAssertEqual(crew.job!, "Set Costumer")
            XCTAssertEqual(crew.name!, "Emily Thomson")
            XCTAssertNil(crew.profilePath)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let crew = try JSONDecoder().decode(Crew.self, from: jsonData)
            
            XCTAssertNotNil(crew)
            XCTAssertNil(crew.job)
            XCTAssertNil(crew.name)
            XCTAssertNil(crew.profilePath)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Crew.self, from: jsonData))
        } catch { }
    }
}
