//
//  WebEngageAnalytics.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 28/07/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation
import WebEngage

final class WebEngageAnaytics {
    static let shared = WebEngageAnaytics()

    private let analytics: WEGAnalytics

    
    private init() {
        analytics = WebEngage.sharedInstance().analytics
    }

    func trackEvent(_ eventName: String, _ attributes: [String: Any]? = nil) {
        
        // Use the analytics instance to track events
        if let attributes = attributes {

            analytics.trackEvent(withName: eventName, andValue: attributes)
        }else{
            
            analytics.trackEvent(withName: eventName)
        }
      
     
    }
    
    func navigatingToScreen( _ eventName : String){
        
        analytics.navigatingToScreen(withName: eventName)
    }

    
}
