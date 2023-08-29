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
import WEPersonalization

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
        WEPersonalization.shared.initialise()
        
        /**************** End Here ********************************/
        
        //Note :  Used For Keyboard Handling When its hiding the textfield
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        /***************************************************/
        //Mark : FIreBase Notification Handling
        /***************************************************/
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
           
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        /********************* End **********************/
        
        //---Statusbar Customization
        //005
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//        statusBar.backgroundColor = UIColor(red: 1/255, green: 88/255, blue: 155/255, alpha: 1.0)
        
        //---
        
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
            
            
            
            
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
//            mainTabBarController.modalTransitionStyle = .coverVertical
//            mainTabBarController.modalPresentationStyle = .fullScreen
//
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = mainTabBarController
//            appDelegate.window?.makeKeyAndVisible()
        }
        
       
        return true
        
    }
    
    /***********************************************************/
    //Mark : Deeplink
    
    //Mark: For Handling Dynamic Link
    func handleIncomingDynamicLink(_ dynamicLink : DynamicLink){
        
        guard let url = dynamicLink.url else{
            
            print("deeplink:- Link has no URL")
            return
        }
        print("deeplink:- Your Incoming Link parameter is \(url.absoluteString)")
        //secod let ie queryItems not execute if first let is true
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {return}
        
        let dict  : NSMutableDictionary = [:]
        
       
        for queryItem in queryItems {
            print("deeplink:- Parameter is \(queryItem.name) has a value of \(queryItem.value ?? "") ")
            
            dict.setValue(queryItem.value, forKey: queryItem.name)
            
           // dict[queryItem.value ?? "", default: queryItem.name]
        }
        
        
        //post Dictionary of Deeplink Notification
        NotificationCenter.default.post(name: .NotifyDeepLink, object: dict)
        
    }
    
    //Mark: Dynamic Link come here
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        
        if let incommingURL = userActivity.webpageURL{
            
            print("deeplink:- Incoming URL is \(incommingURL)")
            
            let linkhandled = DynamicLinks.dynamicLinks()
              .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
                
                  guard error == nil else {
                      
                      print("deeplink:- Found an error \(String(describing: error?.localizedDescription))")
                      return
                  }
                  
                  if let dynamiclink = dynamiclink{
                      
                      self.handleIncomingDynamicLink(dynamiclink)
                      
                      
                  }
                  
              }
            
            if linkhandled{
                return true
            }else{
                
                return false
            }
            
        }
     

      return false
    }
    

    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        
        print("DEEPLINK",url)
      return application(app, open: url,
                         sourceApplication: options[UIApplication.OpenURLOptionsKey
                           .sourceApplication] as? String,
                         annotation: "")
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                     annotation: Any) -> Bool {
      if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
          
          print("deeplink:- open url receive a URL through custom scheme!! \(url.absoluteString)")
          self.handleIncomingDynamicLink(dynamicLink)
         
        return true
      }else{
          
          print("DEEPLINK",url)
          // May be handel google and facebook signIn here
          return false
      }
    
    }
    
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//        //com.demo.food
//        print("DEEPLINK",url)
//        return true
//    }
    
    
    

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
            
            
               
           
        }
        
        
    }
   
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    
    //Mark:- Foreground Notification : Required When app is already Present
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        _ = notification.request.content.userInfo
        
    
        // Print full message.
        //print("NOTIFICATION INFO1 ",userInfo)
        
        // Change this to your preferred presentation option
        return [[.alert, .sound]]
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
        
    
        
//        if let aps = userInfo["aps"] as? [String: AnyObject] {
//            if let badgeNumber = aps["badge"] as? Int {
//                UIApplication.shared.applicationIconBadgeNumber = badgeNumber
//            }
//        }
    }
    
    
}


