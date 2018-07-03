//
//  MovieBusinessTests.swift
//  ClaroChallengeTests
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class MovieBusinessTests: XCTestCase {

    let bundle = Bundle(for: MovieBusinessTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpcomingMoviesSuccess() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "movie_list", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect success request")
        business.upcomingMovies() { (result) in
            do {
                if let movieList = try result() {
                    XCTAssertEqual(movieList.totalResults!, 19759)
                    XCTAssertEqual(movieList.totalPages!, 988)
                    XCTAssertEqual(movieList.page!, 1)
                    XCTAssert((movieList.results?.count ?? 0) > 0)
                } else {
                    XCTFail("Did not expect a nil object")
                }
            } catch {
                XCTFail("Fails on parsing model")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testPopularMoviesSuccess() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "movie_list", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect success request")
        business.popularMovies() { (result) in
            do {
                if let movieList = try result() {
                    XCTAssertEqual(movieList.totalResults!, 19759)
                    XCTAssertEqual(movieList.totalPages!, 988)
                    XCTAssertEqual(movieList.page!, 1)
                    XCTAssert((movieList.results?.count ?? 0) > 0)
                } else {
                    XCTFail("Did not expect a nil object")
                }
            } catch {
                XCTFail("Fails on parsing model")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testMovieSuccess() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "movie", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect success request")
        business.movie(identifier: 120) { (result) in
            do {
                if let movie = try result() {
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
                } else {
                    XCTFail("Did not expect a nil object")
                }
            } catch {
                XCTFail("Fails on parsing model")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreditsSuccess() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "credits", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect success request")
        business.credits(identifier: 120) { (result) in
            do {
                if let credits = try result() {
                    XCTAssert((credits.crewList?.count ?? 0) > 0)
                    XCTAssert((credits.castList?.count ?? 0) > 0)
                } else {
                    XCTFail("Did not expect a nil object")
                }
            } catch {
                XCTFail("Fails on parsing model")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testUpcomingMoviesFailure() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "", error: BusinessError.offlineMode, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect offline failure")
        business.upcomingMovies() { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testPopularMoviesFailure() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "", error: BusinessError.offlineMode, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect offline failure")
        business.popularMovies() { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testMovieFailure() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "", error: BusinessError.offlineMode, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect offline failure")
        business.movie(identifier: 120) { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreditsFailure() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "", error: BusinessError.offlineMode, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect offline failure")
        business.credits(identifier: 120) { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testUpcomingMoviesFailureParse() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "fail", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect parse failure")
        business.upcomingMovies() { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testPopularMoviesFailureParse() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "fail", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect parse failure")
        business.popularMovies() { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch {  }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testMovieFailureParse() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "fail", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect parse failure")
        business.movie(identifier: 120) { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreditsFailureParse() {
        let business = MovieBusiness(withProvider: MovieProviderMock(file: "fail", error: nil, bundle: bundle))
        
        let expectation = self.expectation(description: "Expect parse failure")
        business.credits(identifier: 120) { (result) in
            do {
                XCTAssertThrowsError(try result())
            } catch { }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
}
