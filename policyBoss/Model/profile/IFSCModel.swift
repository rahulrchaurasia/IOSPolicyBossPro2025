//
//  IFSCModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 21/02/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

struct IFSCModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [IFSCMasterDATA?]

    
}

// MARK: - MasterDatum
struct IFSCMasterDATA: Codable {
    let ifscCode, micrCode, bankBran, bankCity: String?
    let cityName, bankName: String?

    enum CodingKeys: String, CodingKey {
        case ifscCode = "IFSCCode"
        case micrCode = "MICRCode"
        case bankBran = "BankBran"
        case bankCity = "BankCity"
        case cityName = "CityName"
        case bankName = "BankName"
    }
}
