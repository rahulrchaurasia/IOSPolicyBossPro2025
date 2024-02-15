//
//  UserNewSignUpResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 11/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

// MARK: - UserNewSignUpResponse
struct UserNewSignUpResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [UserNewSignUpMasterData]

   
}

// MARK: - MasterDatum
struct UserNewSignUpMasterData: Codable {
    let enable_pro_signupurl, enable_elite_signupurl: String
    let enable_pro_pospurl: String
    let enable_pro_Addsubuser_url, enable_otp_only: String

    
}
