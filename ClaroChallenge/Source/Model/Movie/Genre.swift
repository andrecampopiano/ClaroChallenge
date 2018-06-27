//
//  Genre.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    var identifier: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
