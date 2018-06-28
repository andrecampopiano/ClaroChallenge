//
//  TrailerListRequest.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct TrailerListRequest: Codable {
    
    let apiKey = ApiProvider.apiSecret
    let language = ApiProvider.language
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language
    }
    
}
