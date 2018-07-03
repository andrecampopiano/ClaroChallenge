//
//  MovieProviderMock.swift
//  ClaroChallengeTests
//
//  Created by Andre Luis Campopiano on 02/07/18.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import XCTest
@testable import ClaroChallenge

class MovieProviderMock: BaseMock, MovieApiProtocol {
    
    func upcomingMovies(withParameters parameters: NetworkParameters,
                        _ completion: @escaping MovieCallback) {
        completion { try loadResponse() }
    }
    
    func popularMovies(withParameters parameters: NetworkParameters,
                       _ completion: @escaping MovieCallback) {
        completion { try loadResponse() }
    }
    
    func movie(withParameters parameters: NetworkParameters, movieId: String,
               _ completion: @escaping MovieCallback) {
        completion { try loadResponse() }
    }
    
    func credits(withParameters parameters: NetworkParameters, movieId: String,
                 _ completion: @escaping MovieCallback) {
        completion { try loadResponse() }
    }
    
    func trailer(withParameters parameters: NetworkParameters, movieId: String,
                 _ completion: @escaping MovieCallback) {
        completion { try loadResponse() }
    }
}
