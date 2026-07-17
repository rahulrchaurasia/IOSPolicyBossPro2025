//
//  ContactUsRequest.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 05/11/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

struct ContactUsRequest : Codable {
    
    let app_version: String
       let device_code: String
       let fbaid: String
       let ssid: String
}
