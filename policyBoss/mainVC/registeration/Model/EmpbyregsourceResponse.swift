//
//  EmpbyregsourceResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 01/08/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation


struct EmpbyregsourceResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [MasterDataEmpRegSource]

  
}

// MARK: - MasterDatum
struct MasterDataEmpRegSource: Codable {
    let Uid: Int
    let EmployeeName: String

   
}
