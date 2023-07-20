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


