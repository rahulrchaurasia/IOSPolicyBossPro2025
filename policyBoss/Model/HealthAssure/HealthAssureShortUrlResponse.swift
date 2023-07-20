//
//  HealthAssureShortUrlResponse.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 08/07/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//



import Foundation

struct HealthAssureShortLinkResponse: Codable {
    let Message, Status: String
    let StatusNo: Int
    let MasterData: [HealthAssureShortLinkData]?

}

// MARK: - MasterDatum
struct HealthAssureShortLinkData: Codable {
    let SavedStatus: Int
    let ShortURL: String
    let LongURL: String

  
}
