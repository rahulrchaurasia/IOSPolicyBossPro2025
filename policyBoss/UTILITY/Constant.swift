//
//  Constant.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 15/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation
import UIKit


/********    Color Code   ******/
let customGrayColor95 = UIColor(red: 248/255, green: 109/255, blue: 26/255, alpha: 1.0)
let customOrangeColor = UIColor(red: 248/255, green: 151/255, blue: 26/255, alpha: 1.0) //F8971A
let customBluecolor =  UIColor(red: 28/255, green: 164/255, blue: 255/255, alpha: 1.0) //1CA4FF
let customBlackTransparent =  UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7706815567))
let customPrimaryColor =  UIColor(cgColor: #colorLiteral(red: 0.6908986568, green: 0.3392218351, blue: 0.9942491651, alpha: 0.8238832439))

let customTabColor =  UIColor(cgColor: #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))

let serverError  = "Server time out.Please try again"
let serverUnavailbleError  = "Server are not available.Please try again"

/********   key   ******/

struct getMessage {
  
    static let  logoutMessage = "Do you wannt to Logout ?"
}



struct storyBoardName  {
    
    static let  Main   = "Main"
    static let  Home = "Home"
    static let  LaunchScreen = "LaunchScreen"
    static let  SyncContact  = "SyncContact"
    static let  Notification  = "Notification"
    
}

struct getSharPrefernce  {
    
    static let  attendanceEnable   = "androidproattendanceEnable"
    static let  uidLogin = "IsUidLogin"
    static let  userType = "policyBossPro_userType"
    static let  isAgent = "policyBossPro_isAgent"
  
    
}

enum closureType {
    
    case close
    case success
    
}

enum UserType: String {
    case posp = "POSP"
    case fos = "FOS"
    case emp = "EMP"
    case misp = "MISP"
    case none = ""
    
    var isAgent: Bool {
        
     return self == .posp || self == .fos
        
    }
}

struct Constant  {
    
    static let  deeplink   = "deeplink"
    static let  errorMessage   = "No Data Found. Please try Again!!"
    static let  contactReq   = "Please Allow Contact Access."
    static let  contactTitle   = "Contact access is need to get your Contact Sync."

    static let  token   = "FCMTOKEN"
    static let  NotificationCount   = "NotificationCount"
    static let  HeaderToken   = "1234567890"
    static let  NoDataFound   = "No Data Found"
    static let  InvalidURL   = "Invalid URL.."
    static let  EncodeError   = "Failed to encode request data:"
    static let  serverMessage   = "Server Error. Please try Again!!"
    static let  InvalidResponse   = "Invalid Response Type.."
    
   
    
    static let  PbAttendanceKEY   = "K!R:|A*J$P*"
    static let PbKeychain = "pb.KeyChain"
    static let DeviceDetail = "deviceDetail"
    static let  PbAttendanceURL   = "https://pbtimes.policyboss.com/EIS/JSON_Test/app_data_push_test.php"
    
    static let SalesMaterial_TypeOfContyent = "CUSTOMER COMM"
    
    static let POSPURL = "Enable Pro Pospurl"
    
    static let  AddsubuserUrl   = "AddsubuserUrl"
}


struct Screen  {
    
    static let  navigateBack   = "NAVGATION"
    static let  navigateRoot   = "NAVGATIONROOT"
    
  
}

struct ScreenName  {
    
    static let  Insurance   = "Insurance"
    static let  SYNC_TERMS   = "SYNC_TERMS"
    
    static let  SYNC_PRIVACY   = "SYNC_PRIVACY"
    
    static let  privateCar   = "privateCar"
    static let  twoWheeler   = "twoWheeler"
    static let  COMMERCIALVEHICLE   = "COMMERCIALVEHICLE"
    
    static let  HealthInsurance   = "HealthInsurance"
   
    
    
    static let  myFinbox   = "myFinbox"
    static let  Finperks   = "Finperks"
    static let  InsuranceBusiness   = "InsuranceBusiness"
    
    static let  policyByCRN   = "policyByCRN"
    static let  leadDashboard   = "leadDashboard"
    static let  pospEnrollment   = "POSPEnrollment"
    
    static let Dynamic = "Dynamic"
}


struct AnalyticScreenName  {
    
    static let  LoginScreen   = "Login Screen"
    static let  AppCodeScreen   = "AppCode Screen"
    static let  IncomePotentialScreen   = "IncomePotential Screen"
    static let  ChangePasswordScreen   = "ChangePassword Screen"
    static let  DashBoardScreen   = "DashBoard Screen"
    static let  HelpFeedBackScreen   = "HelpFeedBack Screen"
    static let  AboutScreen   = "About Screen"
    
    
    static let  ContactUsScreen   = "ContactUs Screen"
    static let  HomeScreen   = "Home Screen"
    static let  EulaScreen   = "Eula Screen"
    static let  WelcomeScreen   = "Welcome Screen"
   
    
    static let  KnowledgeGuruScreen   = "KnowledgeGuru Screen"
    static let  MyAccountScreen   = "MyAccount Screen"
    static let  NotificationScreen   = "Notification Screen"
    static let  PospScreen   = "Posp Screen"
    static let  RegisterScreen   = "Register Screen"
    static let SalesDetailScreen = "SalesDetail Screen"
    
    static let  SalesMaterialScreen   = "SalesMaterial Screen"
    static let  SalesShareScreen   = "SalesShareScreen"
    static let  SplashScreenScreen   = "SplashScreen Screen"
    static let  SyncContactScreen   = "Sync Contact Screen"
    static let  WelcomeSyncContactScreen   = "Welcome Sync Contact Screen"
    static let CommonWebViewScreen = "Common WebView Screen"
    static let PrivacyScreen = "Privacy Screen"
    
    
   
    
    
}
