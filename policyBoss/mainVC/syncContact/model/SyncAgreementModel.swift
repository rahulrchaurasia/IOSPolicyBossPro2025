//
//  SyncAgreementModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/04/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation



// MARK: - SyncContact Agreement Request

struct SyncContactAgreementRequest: Encodable {
    let fba_id: Int
    let is_call, is_sms, online_agreement: String
    let ss_id: Int

    
}
//********** End *********************************************


//************* Start Agreement response *************************************
// MARK: - SyncContactAgreementResponse
struct SyncContactAgreementResponse: Codable {
    let Status: String
    let Msg: [SyncAgreementMsg]

    
}

// MARK: - Msg
struct SyncAgreementMsg: Codable {
    let _id: String
    let Sync_Contact_Agreement_Id: Int
    let Modified_On, Created_On, online_agreement, is_call: String
    let is_sms: String
    let fba_id, ss_id: Int

}
//********** End *********************************************


// MARK: - SyncContactAgreementSaveResponse
struct SyncContactAgreementSaveResponse: Codable {
    let Status: String
    let data: SyncContactAgreementSaveData

    
}

// MARK: - DataClass
struct SyncContactAgreementSaveData: Codable {
    let fbaID: Int
    let isCall, isSMS, onlineAgreement: String
    let ssID: Int

    enum CodingKeys: String, CodingKey {
        case fbaID = "fba_id"
        case isCall = "is_call"
        case isSMS = "is_sms"
        case onlineAgreement = "online_agreement"
        case ssID = "ss_id"
    }
}
