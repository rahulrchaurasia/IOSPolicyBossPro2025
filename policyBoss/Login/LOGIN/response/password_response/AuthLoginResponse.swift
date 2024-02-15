//
//  AuthLoginResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 13/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

struct AuthLoginResponse: Codable {
    let Status: String
    let Msg: MsgAuthLogin
    let SS_ID: Int?

    
}

// MARK: - Msg
struct MsgAuthLogin: Codable {
    let userName: String
    let fbaID: Int
    let fbaStatus, fullname, pospStatus, emailID: String
    let mobiNumb1, suppAgentID, empCode, roleID: Int
    let source, clientID, isFirstLogin, lIveURL: Int
    let lastloginDate: Int
    let validfrom, userType: String
    let rewardPoint: Int
    let strPassword: String
    let isDemo: Int
    let fsm: String
    let isMagiSale, leadID: Int
    let subFbaID, isEmployee, result, message: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case fbaID = "FBAId"
        case fbaStatus = "FBAStatus"
        case fullname = "Fullname"
        case pospStatus = "POSPStatus"
        case emailID = "EmailID"
        case mobiNumb1 = "MobiNumb1"
        case suppAgentID = "SuppAgentId"
        case empCode = "EmpCode"
        case roleID = "RoleId"
        case source = "Source"
        case clientID = "client_id"
        case isFirstLogin = "IsFirstLogin"
        case lIveURL = "LIveURL"
        case lastloginDate = "LastloginDate"
        case validfrom = "Validfrom"
        case userType = "UserType"
        case rewardPoint = "RewardPoint"
        case strPassword
        case isDemo = "IsDemo"
        case fsm = "FSM"
        case isMagiSale = "IsMagiSale"
        case leadID = "LeadId"
        case subFbaID = "Sub_Fba_Id"
        case isEmployee = "Is_Employee"
        case result = "Result"
        case message = "Message"
        case status = "Status"
    }
}
