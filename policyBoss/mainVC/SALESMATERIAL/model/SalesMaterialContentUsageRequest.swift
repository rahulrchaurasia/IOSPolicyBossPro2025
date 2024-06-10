//
//  SalesMaterialContentUsageRequest.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 14/03/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation



// MARK: Request - SalesMaterialContentUsageRequest
struct SalesMaterialContentUsageRequest: Codable {
    let app_version, product_id, device_code, fbaid: String
    let ssid, type_of_content, content_url, language: String
    let content_source,product_name: String

    
}


// MARK: Response - SalesMaterialContentUsageResponse
struct SalesMaterialContentUsageResponse: Codable {
    let Status, Msg: String

   
}
