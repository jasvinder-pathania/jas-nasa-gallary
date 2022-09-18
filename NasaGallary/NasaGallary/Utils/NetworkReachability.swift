//
//  NetworkReachability.swift
//  NasaGallary
//
//  Created by Jasvinder Singh on 18/09/22.
//

import Foundation
import SystemConfiguration

class NetworkReachability: ObservableObject {
    @Published private(set) var reachable: Bool = false
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "try.internet.jas")
    
    init() {
            self.reachable = checkConnection()
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }
    
    func checkConnection() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

            return isNetworkReachable(with: flags)
    }
    
}
