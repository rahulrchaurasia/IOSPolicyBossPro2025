//
//   Connectivity.swift
//  MagicFinmart
//
//  Created by iOS Developer on 17/04/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
    
    static let message = "No Internet Access Available"
}


//Only For IPAddress
class NetworkManager {
    static let shared = NetworkManager()

    private init() {} // Private to prevent multiple instances

    func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) { // IPv4
                    if let name = interface?.ifa_name, String(cString: name) == "en0" { // Wi-Fi interface
                        var addr = interface?.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(&addr!, socklen_t(interface!.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                        break
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
}

//to call
//if let ip = NetworkManager.shared.getIPAddress() {
//    print("Device IP Address: \(ip)")
//} else {
//    print("IP Address not found")
//}
