//
//  DeviceDetailModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 21/02/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation


struct DeviceDetailModel: Codable {
    let status, msg: String

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case msg = "Msg"
    }
}

