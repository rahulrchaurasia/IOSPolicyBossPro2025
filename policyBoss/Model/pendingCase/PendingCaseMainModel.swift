//
//  PendingCaseMainModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 12/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit


// MARK: - PendingCaseMainModel
struct PendingCaseMainModel: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: PendingCaseMainMasterData
    
   
}

// MARK: - MasterData
struct PendingCaseMainMasterData: Codable {
    let Insurance, Loan: [InsuranceLoanPendingCase]
    
    
}

// MARK: - Insurance
struct InsuranceLoanPendingCase: Codable {
    let Id: Int
    let CustomerName, Category, qatype, ApplnStatus: String
    let mobile, quotetype, ApplicationNo, created_date: String
    let BankImage: String?
    let cdate: String
    let pendingdays: Int
    
  
}
