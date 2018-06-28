//
//  MovieApiProtocol.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

typealias  MovieCallback = (() throws -> Data?) -> Void

/// Protocol used for Mock proposes
protocol MovieApiProtocol {
    
    /// Fetch Upcoming Movies
    ///
    /// - Parameters:
    ///   - parameters: api parameters
    ///   - completion: completion callback
    func upcomingMovies(withParameters parameters: NetworkParameters,
                        _ completion: @escaping MovieCallback)
    
    /// Fetch Popular Movies
    ///
    /// - Parameters:
    ///   - parameters: api parameters
    ///   - completion: completion callback
    func popularMovies(withParameters parameters: NetworkParameters,
                       _ completion: @escaping MovieCallback)
    
    /// Fetch Movie Details
    ///
    /// - Parameters:
    ///   - parameters: api parameters
    ///   - movieId: movie identifier
    ///   - completion: completion callback
    func movie(withParameters parameters: NetworkParameters,
               movieId: String,
               _ completion: @escaping MovieCallback)
    
    /// Fetch Movie Details
    ///
    /// - Parameters:
    ///   - parameters: api parameters
    ///   - movieId: movie identifier
    ///   - completion: completion callback
    func credits(withParameters parameters: NetworkParameters,
                 movieId: String,
                 _ completion: @escaping MovieCallback)
    
    /// Fetch Trailers
    ///
    /// - Parameters:
    ///   - parameters: api parameters
    ///   - movieId: movie identifier
    ///   - completion: completion callback
    func trailer(withParameters parameters: NetworkParameters,
                 movieId: String,
                 _ completion: @escaping MovieCallback)
}
