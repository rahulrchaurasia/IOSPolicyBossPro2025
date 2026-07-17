//
//  DeviceDetailsResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation


struct DeviceDetailsResponse: Codable {
    let Status: String
    let Msg: String
    //let Data: DeviceData?
}

struct DeviceData: Codable {
    let _id: String?
    let Request_Core: [String: String]?
    let Ip_Address: String?
    let Modified_On: String?
    let Created_On: String?
    let Log_Type: String?
    let OS_Detail: String?
    let App_Version: String?
    let Device_Name: String?
    let Device_Identifier: String?
    let SS_ID: Int?
    let Device_Detail_Id: Int?
    let __v: Int?
}
