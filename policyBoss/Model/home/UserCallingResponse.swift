//
//  UserCallingResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 25/04/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

struct UserCallingResponse: Codable {
    let StatusNo: Int
    let Status: String
    let Message: String
    let MasterData: [UserCallingData]
}

struct UserCallingData: Codable {
    let Designation: String
    let EmployeeName: String
    let EmailId: String
    let MobileNo: String
}
