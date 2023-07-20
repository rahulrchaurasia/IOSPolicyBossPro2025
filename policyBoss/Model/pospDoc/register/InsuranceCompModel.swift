//
//  InsuranceCompModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 05/06/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

struct InsuranceCompModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    var MasterData: InsuranceCompMasterData
    
    
}

// MARK: - MasterData
struct InsuranceCompMasterData: Codable {
    var lifeinsurance, generalinsurance, healthinsurance: [Insurance]
}

// MARK: - Insurance
struct Insurance: Codable {
    let InsuID: Int
    let InsuName, InsuShorName: String
    let Health: Int?
    var selected: Bool?
    var ischeck: Int? = 0
  
}
