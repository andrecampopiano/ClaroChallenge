//
//  MovieTests.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class MovieTests: XCTestCase {

    var mock: BaseMock?
    let bundle = Bundle(for: MovieTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "movie", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movie = try JSONDecoder().decode(Movie.self, from: jsonData)
            
            XCTAssertEqual(movie.identifier!, 120)
            XCTAssertEqual(movie.voteAverage!, 8.1)
            XCTAssertEqual(movie.title!, "The Lord of the Rings: The Fellowship of the Ring")
            XCTAssertEqual(movie.originalTitle!, "The Lord of the Rings: The Fellowship of the Ring")
            XCTAssertEqual(movie.popularity!, 46.9)
            XCTAssertEqual(movie.posterPath!, "/bxVxZb5O9OxCO0oRUNdCnpy9NST.jpg")
            XCTAssertEqual(movie.backdropPath!, "/pIUvQ9Ed35wlWhY2oU6OmwEsmzG.jpg")
            XCTAssertEqual(movie.overview!, "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator.")
            XCTAssertEqual(movie.releaseDate!, "2001-12-18")
            XCTAssert((movie.genres?.count ?? 0) > 0)
            XCTAssertEqual(movie.runtime!, 0178)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movie = try JSONDecoder().decode(Movie.self, from: jsonData)
            
            XCTAssertNotNil(movie)
            XCTAssertNil(movie.identifier)
            XCTAssertNil(movie.voteAverage)
            XCTAssertNil(movie.title)
            XCTAssertNil(movie.originalTitle)
            XCTAssertNil(movie.popularity)
            XCTAssertNil(movie.posterPath)
            XCTAssertNil(movie.backdropPath)
            XCTAssertNil(movie.overview)
            XCTAssertNil(movie.releaseDate)
            XCTAssertNil(movie.genres)
            XCTAssertNil(movie.runtime)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Movie.self, from: jsonData))
        } catch { }
    }
}
