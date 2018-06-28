//
//  ApiProvider.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct ApiProvider {
    
    // MARK: - Properties
    
    /// API version
    static let apiVersion = "3"
    
    /// Auth header Key
    static let apiSecret = "7523fe2b6e8e8c50c89ad56d031619cb"
    
    /// Language Device
    static let language = Locale.preferredLanguages.first
    
    /// Shared Networking Provider used to access API Services
    static var sharedProvider: NetworkProvider {
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        guard let baseURL = URL(string: ApiProvider.baseUrl) else { fatalError("Base URL should not be empty") }
        
        return NetworkProvider(session: urlSession, baseURL: baseURL)
    }
    
    /// API Base URL
    ///
    /// - Returns: return baseURL
    private static var baseUrl: String {
        return "https://api.themoviedb.org/" + apiVersion
    }
    
    /// poster base URL
    static var posterBaseUrl: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    /// poster base URL
    static var bannerBaseUrl: String {
        return "https://image.tmdb.org/t/p/original"
    }
    
    /// profile base URL
    static var profileBaseUrl: String {
        return "https://image.tmdb.org/t/p/w185"
    }
}
