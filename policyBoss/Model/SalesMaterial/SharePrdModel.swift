//
//  SharePrdModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

// MARK: - SharePrdModel
struct SharePrdModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: MasterData
    
    //    enum CodingKeys: String, CodingKey {
    //        case message = "Message"
    //        case status = "Status"
    //        case statusNo = "StatusNo"
    //        case masterData = "MasterData"
    //    }
}

// MARK: - MasterData
struct MasterData: Codable {
    let url, msg: String
}
