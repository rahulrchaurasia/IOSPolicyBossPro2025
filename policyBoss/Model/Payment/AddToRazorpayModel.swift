//
//  AddToRazorpayModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 12/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

struct AddToRazorpayModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [AddToRazorpayMasterData]
    
  
}

// MARK: - MasterDatum
struct AddToRazorpayMasterData: Codable {
    let savedStatus: Int
    let fName, state: String
    let custID: Int
    let pancard, invNo, payDate: String
    let fbaid: Int
    let address, email, respmsg, amt: String
    
    enum CodingKeys: String, CodingKey {
        case savedStatus = "SavedStatus"
        case fName = "FName"
        case state = "State"
        case custID = "CustId"
        case pancard = "Pancard"
        case invNo = "InvNo"
        case payDate = "PayDate"
        case fbaid = "FBAID"
        case address
        case email = "Email"
        case respmsg, amt
    }
}

