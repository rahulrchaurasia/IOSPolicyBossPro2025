//
//  HealthAssureConfigure.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 05/07/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation


struct HealthAssureConfigureResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    var MasterData: [HealthAssureMasterData]? 

    
}

// MARK: - MasterDatum
struct HealthAssureMasterData: Codable {
    let id: Int
    var firstName, lastName, mobile, emailID: String?
    var gender: String?
    var age: Int?
    var flatDetails, streeDetails, landmark, city: String?
    var pinCode: Int?
    var pickUptime, createdDate, pickUpDate: String?
    var   caseID: String?
    var packcode: String
    var provider: String?
    var statID: String?
    var packName: String?
    var fbaID: Int?
    var modiDate: String?
    var offPrice, mrp: Int?
    var dccode: String?
    var fasting, homevisit, status: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case mobile = "Mobile"
        case emailID = "EmailID"
        case gender = "Gender"
        case age = "Age"
        case flatDetails = "FlatDetails"
        case streeDetails = "StreeDetails"
        case landmark = "Landmark"
        case city = "City"
        case pinCode = "PinCode"
        case pickUptime = "PickUptime"
        case createdDate = "CreatedDate"
        case pickUpDate = "PickUpDate"
        case caseID = "CaseId"
        case packcode, provider
        case statID = "StatID"
        case packName = "PackName"
        case fbaID = "FBAId"
        case modiDate = "ModiDate"
        case offPrice = "OffPrice"
        case mrp = "MRP"
        case dccode = "Dccode"
        case fasting, homevisit
        case status = "Status"
    }
}
