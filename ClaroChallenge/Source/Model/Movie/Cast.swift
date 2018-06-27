//
//  Cast.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct Cast: Codable {
    
    var character: String?
    var name: String?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case character
        case name
        case profilePath = "profile_path"
    }
}
