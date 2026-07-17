//
//  DeviceDetailsRequest.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

import Foundation

struct DeviceDetailsRequest: Codable {
    let ss_id: String
    let device_id: String
    let device_name: String
    let os_detail: String
    let action_type: String
    let device_info: String
    let App_Version: String

    
}
