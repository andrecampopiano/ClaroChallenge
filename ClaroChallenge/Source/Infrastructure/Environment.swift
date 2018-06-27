//
//  Environment.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

enum Environment {
    case debug
    case mock
    case release
    
    static func current() -> Environment {
        #if MOCK
            return Environment.mock
        #elseif DEBUG
            return Environment.debug
        #else
            return Environment.release
        #endif
    }
}
