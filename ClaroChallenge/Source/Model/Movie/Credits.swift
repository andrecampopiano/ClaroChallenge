//
//  Credits.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

struct Credits: Codable {
    
    var identifier: Int?
    var castList: [Cast]?
    var crewList: [Crew]?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case castList = "cast"
        case crewList = "crew"
    }
}
