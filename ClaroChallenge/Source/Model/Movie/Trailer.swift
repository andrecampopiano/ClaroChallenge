//
//  Trailer.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct Trailer: Codable {
    var identifier: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case key
        case name
        case site
        case size
        case type
    }
}
