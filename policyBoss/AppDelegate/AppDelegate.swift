//
//  AppDelegate.swift
//  MagicFinmart
//
//  Created by Ashwini on 10/12/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import WebEngage


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        /************************************************/
        //WebEngage for Analytics
        /************************************************/
        
        // Here we are are initializing the WebEngage SDK.
        WebEngage.sharedInstance().application(application,didFinishLaunchingWithOptions: launchOptions, notificationDelegate: self)
        
        // Set the sessionTimeOut to 25 minutes
        WebEngage.sharedInstance()?.sessionTimeOut = 25
        
        // Here we are initializing the WebEngage Personalization.
       // WEPersonalization.shared.initialise()
        
        /**************** End Here ********************************/
        
        //Note :  Used For Keyboard Handling When its hiding the textfield
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        /***************************************************/
        //Mark : FIreBase Notification Handling
        /***************************************************/
        
        FirebaseApp.configure()
        
        // ---------------------------------------------------------
        //  Subscribe to the "all_users" topic for broadcasts
        // ---------------------------------------------------------
        Messaging.messaging().subscribe(toTopic: "all_users") { error in
            if let error = error {
                print("FCM Topic Subscription Failed: \(error.localizedDescription)")
            } else {
                print("FCM Topic Subscription Successful for 'all_users'")
            }
        }
        // For iOS  display notification (sent via APNS)
        // Assign Notification Center Delegate
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        
        // Request Authorization (Guaranteed available on iOS 14.0+)
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
                    if let error = error {
                        print("Notification authorization error: \(error.localizedDescription)")
                    }
                }
        
        
        application.registerForRemoteNotifications()
       
        
        /********************* End **********************/
        
        
        
        // ---------------------------------------------------------
        // 4. Handle User Session State Route Redirection
        // ---------------------------------------------------------
        let IsFirstLogin = UserDefaults.standard.string(forKey: "IsFirstLogin")
        if(IsFirstLogin == "1")
        {
            //            let KYDrawer : KYDrawerController = UIStoryboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
            //            self.present(KYDrawer, animated: true, completion: nil)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeController =  mainStoryboard.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
            appDelegate?.window?.rootViewController = homeController
            window?.makeKeyAndVisible()
            
    
        }
        
        
        return true
        
    }
    
    
    //**********************************************************************
    // MARK: Parse Universal Link
    //**********************************************************************

    /// Parses incoming standard web URLs containing deep link parameters, caches them for session recovery (e.g. post-logout), and broadcasts live updates.
    private func handleUniversalLink(_ url: URL) {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
            }

            var deepLinkData = [String: Any]()

            components.queryItems?.forEach {
                deepLinkData[$0.name] = $0.value
                print("Parameter : \($0.name) = \($0.value ?? "")")
            }

            deepLinkData["url"] = url.absoluteString
            print("DeepLink Dictionary = \(deepLinkData)")

            // Store persistently for Cold Starts / Post-Login Flows
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: deepLinkData, requiringSecureCoding: false) {
                UserDefaults.standard.set(data, forKey: Constant.deeplink)
            }

            // Notify active running view controllers instantly
            NotificationCenter.default.post(
                name: .NotifyDeepLink,
                object: deepLinkData
            )
        }
   
    

   
    //**********************************************************************
    // MARK: Universal Link Handling (Apple App Site Association)
    //**********************************************************************
    //That is the only method needed for Universal Links.
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {

        guard let url = userActivity.webpageURL else {
            return false
        }

        print("DeepLink Incoming URL : \(url.absoluteString)")

        handleUniversalLink(url)

        return true
    }

    
   
    
    
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        // Google Sign-In / Facebook / Payment SDK handling
        
        // Handle third-party callbacks (Google Sign-In, Facebook, Payment SDKs) here if required
      

        return false
    }
    
    
    //Mark : depricated Used for Firebase
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
//                     annotation: Any) -> Bool {
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
//            
//            print("deeplink:- open url receive a URL through custom scheme!! \(url.absoluteString)")
//            self.handleIncomingDynamicLink(dynamicLink)
//            
//            return true
//        }else{
//            
//            print("DEEPLINK",url)
//            // May be handel google and facebook signIn here
//            return false
//        }
//        
//    }
    
    //Mark: Depricated For Handling Dynamic Link for Firebase
//    func handleIncomingDynamicLink(_ dynamicLink : DynamicLink){
//
//
//
//        guard let url = dynamicLink.url else{
//
//            print("deeplink:- Link has no URL")
//            return
//        }
//        print("deeplink:- Your Incoming Link parameter is \(url.absoluteString)")
//        //secod let ie queryItems not execute if first let is true
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//              let queryItems = components.queryItems else {return}
//
//
//
//
//        var deepLinkData: [String: Any] = [:]
//
//        for queryItem in queryItems {
//
//            deepLinkData[queryItem.name] = queryItem.value
//
//            print("deeplink:- Parameter is \(queryItem.name) has a value of \(queryItem.value ?? "") ")
//        }
//
//        deepLinkData["url"] = url.absoluteString
//        print("deeplink:- Parameter is URL has a value of \(url.absoluteString) ")
//
//
//
//        // Convert the dictionary to Data
//        if let data = try? NSKeyedArchiver.archivedData(withRootObject: deepLinkData, requiringSecureCoding: false) {
//            UserDefaults.standard.set(data, forKey: Constant.deeplink)
//        }
//
//        //post Dictionary of Deeplink Notification
//        NotificationCenter.default.post(name: .NotifyDeepLink, object: deepLinkData)
//
//    }
//
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//
//
//        if let incommingURL = userActivity.webpageURL{
//
//            print("deeplink:- Incoming URL is \(incommingURL)")
//
//            let linkhandled = DynamicLinks.dynamicLinks()
//                .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
//
//                    guard error == nil else {
//
//                        print("deeplink:- Found an error \(String(describing: error?.localizedDescription))")
//                        return
//                    }
//
//                    if let dynamiclink = dynamiclink{
//
//                        self.handleIncomingDynamicLink(dynamiclink)
//
//
//                    }
//
//                }
//
//            if linkhandled{
//                return true
//            }else{
//
//                return false
//            }
//
//        }
//
//
//        return false
//    }
//
    
    
   
    
    
    
    //Mark : Deeplink end
    /***********************************************************/
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
}
extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        messaging.token { token, _ in
            
            guard let token = token else{
                return
            }
            print("Token:  \(token)")
            
            UserDefaults.standard.set(String(describing: token), forKey: Constant.token)
            
           // WebEngage.sharedInstance()?.setRegistrationID(token)
            // ---------------------------------------------------------
             // NEW CODE: Ensure topic subscription upon token generation
            // ---------------------------------------------------------
            Messaging.messaging().subscribe(toTopic: "all_users") { error in
                if let error = error {
                    print("Failed to subscribe to topic on token refresh: \(error)")
                } else {
                    print("Successfully re-subscribed to 'all_users' topic!")
                }
            }
            
        }
        
        
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    
    //Mark:- Foreground Notification : Required When app is already Present
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
            
            // Return modern presentation options (Replacing deprecated .alert)
            return [.banner, .sound, .list]
        }
    
    
    //********** on Notification {Background & Foreground} ***************
    //Mark:- When Click on Notification {Background & Foreground}
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        
        //post Dictionary of Push Notification
        NotificationCenter.default.post(name: .NotifyPushDetails, object: userInfo)
        
        
    }
    
    //added
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        var count = (UserDefaults.standard.integer(forKey: Constant.NotificationCount))
        
        count = count + 1
        
        debugPrint("FCM Badge Count \(count)")
        UserDefaults.standard.set(count, forKey: Constant.NotificationCount)
        
        UIApplication.shared.applicationIconBadgeNumber =  count
        
        // This tells iOS that your background task finished successfully.
            // WITHOUT THIS, YOUR APP WILL BE PENALIZED BY THE SYSTEM.
            completionHandler(.newData)
        
        //        if let aps = userInfo["aps"] as? [String: AnyObject] {
        //            if let badgeNumber = aps["badge"] as? Int {
        //                UIApplication.shared.applicationIconBadgeNumber = badgeNumber
        //            }
        //        }
    }
    
    
}


