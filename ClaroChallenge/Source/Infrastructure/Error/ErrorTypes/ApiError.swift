//
//  ApiError.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

enum ApiError: Error {
    case parse(String)
    case httpError(Int)
    case invalidURL
}
