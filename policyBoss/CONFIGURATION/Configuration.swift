//
//  Configuration.swift
//  beldara
//
//  Created by Daniyal Shaikh on 18/08/18.
//  Copyright © 2018 Daniyal Shaikh. All rights reserved.
//

import UIKit

class Configuration: NSObject {

  // static let baseURLString = "http://qa.mgfm.in"               //testing
    //http://api.magicfinmart.com
   static let baseURLString = "https://horizon.policyboss.com:5443/quote/Postfm/"     //live
    
    static let baseROOTURL = "https://horizon.policyboss.com:5443"
    
    static let baseFileUploadURLString = "https://horizon.policyboss.com:5443/quote/Postfm_fileupload/"
    //http://49.50.95.141:19
    //http://202.131.96.101:3333
    static let baseServiceURLString = ""     // for attendance  (Not in used)
    static let baseEncryptedErpIdURL = ""
  
    static let basegenerateloanLeadURL = ""   //ERP URL {Android}  for loan (currently used in pending case only)
    static let basehealthassureURL = ""
    
   
    //static let appVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
   // static let buildVersion =  Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    
    
    static let appVersion: String = {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "policyboss-" + version
        } else {
            return "policyboss-"
        }
    }()
    
    
    static let menuappVersion: String = {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "Ver." + version
        } else {
            return "Ver."
        }
    }()
    static let buildVersion: String = {
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return version
        } else {
            return "Unknown Build Version"
        }
    }()
    
    static let deviceID : String = DeviceHelper.deviceId
}
