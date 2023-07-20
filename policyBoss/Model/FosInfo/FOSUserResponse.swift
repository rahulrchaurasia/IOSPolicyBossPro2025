//
//  FOSUserResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 14/07/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import Foundation

// MARK: - FOSUserResponse
struct FOSUserResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: MasterDataFosUser

  
}

// MARK: - MasterData
struct MasterDataFosUser: Codable {
    let hidesubuser, hideloan: String
}
