//
//  ScannerVerifiedReq.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 18/05/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//


struct ScannerVerifiedReq: Codable {
    
    let status: String
    
    let ss_id: String
    
    let token_id: String
    
    let update_by: String
    
    let secret_key: String
    
    let client_key: String
}


struct ScannerPreReq: Codable {
    
    let status: String
    
    let token_id: String
    
    let update_by: String
    
    let secret_key: String
    
    let client_key: String
}
