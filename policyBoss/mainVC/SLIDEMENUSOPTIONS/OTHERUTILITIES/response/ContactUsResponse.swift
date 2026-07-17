//
//  ContactUsResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 05/11/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation


// MARK: - ContactUsResponse
struct ContactUsResponse: Codable {
    let Message: String
    let Status: String
    let StatusNo: Int
    let MasterData: [ContactUsData]
}

// MARK: - ContactUsData
struct ContactUsData: Codable {
    let Id: Int
    let Header: String
    let DisplayTitle: String
    let Email: String
    let Website: String
    let PhoneNo: String
}
