//
//  Core.swift
//  MagicFinmart
//
//  Created by iOS Developer on 22/07/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import Foundation


class Core {
    
    
    static let shared  = Core ()
    
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setNewUser()  {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
    
    //////////////////
    ///
    
    func isVerifyInstall() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isVerifyINSTALL")
    }
    
    func setVerifyInstall()  {
        UserDefaults.standard.set(true, forKey: "isVerifyINSTALL")
    }
    
    
    
    func setNewUserFalse()  {
        UserDefaults.standard.set(false, forKey: "isNewUser")
    }
}
