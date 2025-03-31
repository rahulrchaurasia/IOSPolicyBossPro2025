//
//  DeviceHelper.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 09/10/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//


import UIKit
import KeychainAccess

struct DeviceHelper {
    private static let deviceIdKey = "policybossproDeviceID" // Key to store deviceId in UserDefaults
    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.policyboss.policybosspro")
    
    //Mark: -->Static property to get or generate the deviceId
//    static let deviceId: String = {
//        let defaults = UserDefaults.standard
//        
//        // Check if a deviceId already exists in UserDefaults
//        if let savedDeviceId = defaults.string(forKey: deviceIdKey) {
//            return savedDeviceId
//        }
//        
//        // Attempt to get identifierForVendor
//        if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
//            // Save the identifierForVendor in UserDefaults for future use
//            defaults.set(vendorId, forKey: deviceIdKey)
//            return vendorId
//        }
//        
//        // Generate a new UUID if identifierForVendor is unavailable
//        let newDeviceId = UUID().uuidString
//        defaults.set(newDeviceId, forKey: deviceIdKey)
//        return newDeviceId
//    }()
    
    //Mark: --> Fixed deviceId using keyChain
    static var deviceId: String {
            // Check if deviceId exists in Keychain
            if let savedDeviceId = try? keychain.get(deviceIdKey) {
                return savedDeviceId
            }
            
            // Try to use identifierForVendor (IDFV)
            if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
                try? keychain.set(vendorId, key: deviceIdKey)
                return vendorId
            }
            
            // Generate new UUID if IDFV is unavailable
            let newDeviceId = UUID().uuidString
            try? keychain.set(newDeviceId, key: deviceIdKey)
            return newDeviceId
        }
}
