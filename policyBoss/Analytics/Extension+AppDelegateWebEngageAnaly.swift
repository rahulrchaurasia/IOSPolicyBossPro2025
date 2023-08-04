//
//  Extension+AppDelegateWebEngageAnaly.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 02/08/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation
import WebEngage

extension AppDelegate : WEGInAppNotificationProtocol {
    
    func notificationPrepared(_ inAppNotificationData: [String: Any]!, shouldStop stopRendering: UnsafeMutablePointer<ObjCBool>!) -> [AnyHashable: Any]! {
        debugPrint("Notification is prepared")
        return inAppNotificationData
    }
    
    func notificationDismissed(_ inAppNotificationData: [String : Any]!) {
        debugPrint("Notification Dismissed")
    }
    
    func notificationShown(_ inAppNotificationData: [String : Any]!) {
        debugPrint("Notification shown")
    }
}
