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
    //let Msg: MsgAuthLogin?
    let SS_ID: Int?

    
    
}

// MARK: - Msg
struct MsgAuthLogin: Codable {
    
    var Message: String?
    //var ErrorResponse : String?
}
