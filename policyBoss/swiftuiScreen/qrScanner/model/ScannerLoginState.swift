//
//  ScannerLoginState.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 19/05/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//


import Foundation

enum ScannerLoginState: Equatable {

    case idle
    case loading
    case success(String)
    case error(String)

    var isLoading: Bool {

        if case .loading = self {
            return true
        }

        return false
    }
    
    // ✅ Prevent duplicate handling
       var isTerminal: Bool {

           switch self {

           case .success, .error:
               return true

           default:
               return false
           }
       }
}
