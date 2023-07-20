//
//  FinmartUserDefault.swift
//  MagicFinmart
//
//  Created by Ashwini on 29/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class FinmartUserDefault: NSObject {
    
    static let USER_CODE = "policyBossPro.userdefaults.userCode"
    static let USER_LOGGEDIN = "policyBossPro.userdefaults.loggedIn"
    static let USER_PASSWORD = "policyBossPro.userdefaults.Password"
    static let USER_DEFAULT_LAT = "19.0176147"
    static let USER_DEFAULT_LNG = "72.8561644"
    static let USER_ID = "USERID"
    static let USER_HRMSID = "policyBossPro.userdefaults.hrmsid"
    
    
    
    static func getlat() -> String {
        //let defaults = UserDefaults.standard
        var lati = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_DEFAULT_LAT)
        if(lati == nil){
            lati = ""
        }
        // return lati!;
        return lati!
    }
    
    static func getlag() -> String {
        var lag = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_DEFAULT_LNG)
        if(lag == nil){
            lag = ""
        }
        return lag!
    }
    
    static func userid() -> String {
        var userid = UserDefaults.standard.string(forKey: FinmartUserDefault.USER_ID)
        if(userid == nil){
            userid = ""
        }
        return userid!
    }
    
}
