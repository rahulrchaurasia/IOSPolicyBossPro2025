//
//  IFSCCodeModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 25/07/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import Foundation
import UIKit



// MARK: - IFSCCodeModel
struct IFSCCodeModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [IFSCCodeMasterData]
    
   
}

// MARK: - MasterDatum
struct IFSCCodeMasterData : Codable {
    let IFSCCode, MICRCode, BankBran: String
    let BankCity: Int
    let CityName, BankName: String
    
   
}

