//
//  MovieListRequest.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit

struct MovieListRequest: Codable {
    
    let apiKey = ApiProvider.apiSecret
    let language = ApiProvider.language
    var page: Int?
    
    init(withPage page: Int = 1) {
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language
        case page
    }
    
}
