//
//  LocalizableStrings.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

enum LocalizableStrings: String {
    // Strings
    case mainTitle
    case upcomingMovies
    case popularMovies
    case notSupportLanguage
    
    // Error Handling
    case friendlyErrorTitle
    case friendlyError
    case errorParseData
    case offlineMode
    case httpError
    case invalidURL
    case genericError
    
    /// This method localizes the raw value of the object
    ///
    /// - Returns: Return the localized string for that key
    func localize() -> String {
        return self.rawValue.localize()
    }
}
