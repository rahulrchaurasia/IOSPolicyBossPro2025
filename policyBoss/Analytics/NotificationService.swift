//
//  NotificationService.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 02/08/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation
import UserNotifications
import WebEngageBannerPush

class NotificationService: WEXPushNotificationService {
    let service = WEXPushNotificationService()
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
//        if let apsPayload = request.content.userInfo["aps"] as?[String:Any]{
//            if let  category = apsPayload["category"] as? String{
//                if category == "1234"{ // CHOOSE THEIR CUSTOM CATEGORY NAME
//                    if let userInfo = request.content.userInfo as? [String:Any]{
//                        self.registerCTA(category: category,
//                                         userInfo: userInfo,
//                                         dismissActiontitle: "Dismiss")
//                    }
//                }
//            }
//        }

        service.didReceive(request, withContentHandler: contentHandler)
    }
    
    
    // This will register default CTA's received from WebEngage dashboard
    /// NOTE: This list wont have dismiss type of button You need to manually add them as required
    /// - Parameters:
    ///   - category: custom Catgory name where you want to register CTA
    ///   - userInfo: Notification payload userInfo
    ///   - dismissActiontitle : If you want to have dismiss button then pass title for dismiss
    func registerCTA(category:String,
                     userInfo:[String:Any],
                     dismissActiontitle:String?){
        var actions:[UNNotificationAction] = []
        if let expandableDetails = userInfo["expandableDetails"] as? [String:Any]{
            for i in 1...3{
                if let ctaDetails = expandableDetails["cta\(i)"] as? [String:Any]{
                    if let templateId = ctaDetails["templateId"] as? String,
                       let actionText = ctaDetails["actionText"] as? String{
                        let actionObject = UNNotificationAction(identifier: templateId,
                              title: actionText,
                              options: UNNotificationActionOptions(rawValue: 0))
                        actions.append(actionObject)
                    }
                }
            }
        }
        
        // add dimiss button if required
        if let dismissTitle = dismissActiontitle{
            let actionObject = UNNotificationAction(identifier: "dismiss" // This identifier can be anything
                                                    , title: dismissTitle,
                                                    options: UNNotificationActionOptions(rawValue: 0))
            actions.append(actionObject)
        }
        
        // Define the notification type
        let customCategory =
              UNNotificationCategory(identifier:category,
              actions: actions,
              intentIdentifiers: [],
              hiddenPreviewsBodyPlaceholder: "",
              options: .customDismissAction)
        // Register the notification type.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([customCategory])
    }

}
