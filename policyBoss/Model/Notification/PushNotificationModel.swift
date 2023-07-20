//
//  PushNotificationModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 11/04/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

struct PushNotificationModel : Codable {
    
    var ssid : String?
    var notifyFlag: String?
    var img_url: String?
    var body: String?
    var title: String?
    var web_url: String?
    var web_title: String?
    var message_id: String?
    
    
    init(ssid: String? = nil,notifyFlag: String? = nil, img_url: String? = nil, body: String? = nil, title: String? = nil, web_url: String? = nil, web_title: String? = nil, message_id: String? = nil) {
        
        self.ssid = ssid ?? ""
        self.notifyFlag = notifyFlag ?? ""
        self.img_url = img_url ?? ""
        self.body = body ?? ""
        self.title = title ?? ""
        self.web_url = web_url ?? ""
        self.web_title = web_title ?? ""
        self.message_id = message_id ?? ""
    }
}
