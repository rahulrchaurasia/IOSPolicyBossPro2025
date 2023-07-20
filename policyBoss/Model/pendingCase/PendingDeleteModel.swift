//
//  PendingDeleteModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

//PendingDeleteModel

struct PendingDeleteModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: PendingDeleteMasterData
    
   
}

// MARK: - MasterDatum
struct PendingDeleteMasterData: Codable {
    let SavedStatus: Int
    let Message: String
    
   
}
