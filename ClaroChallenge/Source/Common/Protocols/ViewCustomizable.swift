//
//  ViewCustomizable.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation

/// Protocol to specifiy when a controller has a mainView with a custom class
/// use with typealias = <CustomView>
protocol ViewCustomizable: class {
    associatedtype CustomView
    
    var customView: CustomView { get }
}
