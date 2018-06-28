//
//  TrailerList.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct TrailerList: Codable {
    var id: Int?
    var results: [Trailer]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}
