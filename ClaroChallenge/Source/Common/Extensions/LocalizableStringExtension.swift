//
//  LocalizableStringExtension.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Get localized string without comment
     
     - returns: localized string
     */
    func localize(isAccessibilty: Bool = false) -> String {
        return NSLocalizedString(self,
                                 tableName: isAccessibilty ? "LocalizableAccessibility" : "Localizable",
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
    
}
