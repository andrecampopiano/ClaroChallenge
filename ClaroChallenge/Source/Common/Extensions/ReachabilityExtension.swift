//
//  ReachabilityExtension.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Reachability

extension Reachability {
    // MARK: - Private Computed Properties
    private static let defaultHost = "www.google.com"
    private static var reachability = Reachability(hostname: defaultHost)
    
    // MARK: - Public Functions
    
    /// True value if there is a stable network connection
    static var isConnected: Bool {
        guard let reachability = Reachability.reachability else { return false }
        
        return reachability.connection != .none
    }
    
    /// Current network status based on enum NetworkStatus
    static var status: Connection {
        guard let reachability = Reachability.reachability else { return .none }
        
        return reachability.connection
    }
}
