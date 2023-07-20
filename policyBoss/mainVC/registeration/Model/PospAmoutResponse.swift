//
//  PospAmoutResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 20/06/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import Foundation

struct PospAmountModel: Codable {
   
  
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [MasterDataPospAmnt]

    
}

// MARK: - MasterDatum
struct MasterDataPospAmnt: Codable {
    let id: Int
    let posp_name, posp_amount, posp_header_desc, posp_sub_header_desc: String
    let posp_desc: String
    var isCheck : Bool?

   

    
    
}
