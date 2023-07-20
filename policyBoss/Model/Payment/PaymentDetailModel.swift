//
//  PaymentDetailModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 06/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

struct PaymentDetailModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: PaymentDetailMasterData!
    
//    enum CodingKeys: String, CodingKey {
//        case message = "Message"
//        case status = "Status"
//        case statusNo = "StatusNo"
//        case masterData = "MasterData"
//    }
}

// MARK: - MasterData
struct PaymentDetailMasterData: Codable {
    let CustID, Name, Email, Mobile: String
    let image: String
    let dispmsg: String
    let Status: Int
    let productname, displayamounts, amount: String
    

}
