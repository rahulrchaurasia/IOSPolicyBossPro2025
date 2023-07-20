//
//  TransactionHistoryResponse.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 07/11/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation


// MARK: - TransationHistoryResponse

struct TransationHistoryResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [TransationHistoryData]?

   
}

// MARK: - MasterDatum
struct TransationHistoryData: Codable {
    var EntryNo, InsCompany, ProductName, ODPremium: String?
    var Premium, AddOnPremium, EntryDate: String?
    var QT_No, Total_OD: String?
    var POSP_ID, CSNo, InceptionDate: String?

    init() {
          
        self.EntryNo = EntryNo ?? ""
        self.InsCompany = InsCompany ?? ""
        self.ProductName = ProductName ?? ""
        self.ODPremium = ODPremium ?? ""
        
        self.Premium = Premium ?? ""
        QT_No = QT_No ?? ""
        Total_OD = Total_OD ?? ""
        QT_No = QT_No ?? ""
        Total_OD = Total_OD ?? ""
        QT_No = QT_No ?? ""
        }
    
}
