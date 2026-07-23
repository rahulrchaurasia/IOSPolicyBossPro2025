//
//  SharePrdModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 13/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

// MARK: - SharePrdModel
struct SharePrdModel: Codable {
       let msg: String?
        let status: String?

        enum CodingKeys: String, CodingKey {
            case msg = "Msg"
            case status = "Status"
        }
}


