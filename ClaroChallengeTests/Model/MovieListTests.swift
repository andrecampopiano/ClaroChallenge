//
//  MovieListTests.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class MovieListTests: XCTestCase {
    
    var mock: BaseMock?
    let bundle = Bundle(for: MovieListTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "movie_list", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movies = try JSONDecoder().decode(MovieList.self, from: jsonData)
            
            XCTAssertEqual(movies.totalResults!, 19759)
            XCTAssertEqual(movies.totalPages!, 988)
            XCTAssertEqual(movies.page!, 1)
            XCTAssert((movies.results?.count ?? 0) > 0)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movies = try JSONDecoder().decode(MovieList.self, from: jsonData)
            
            XCTAssertNil(movies.totalResults)
            XCTAssertNil(movies.totalPages)
            XCTAssertNil(movies.page)
            XCTAssertNil(movies.results)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(MovieList.self, from: jsonData))
        } catch { }
    }
}
