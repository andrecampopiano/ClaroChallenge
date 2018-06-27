//
//  Crew.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct Crew: Codable {
    
    var job: String?
    var name: String?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case job
        case name
        case profilePath = "profile_path"
    }
}
