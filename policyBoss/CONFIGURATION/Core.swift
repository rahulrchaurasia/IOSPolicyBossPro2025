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
    
    static let signUpEntityKey = "policybosspro.signUpEntityKey"
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
    
    
    /////
    ///
    static func saveUserSignUpEntity(signUpEntity : UserNewSignUpMasterData ){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(signUpEntity) {
            
            UserDefaults.standard.set(encoded, forKey: Core.signUpEntityKey)
        }
    }
    
    static func getSignUpEntity()-> UserNewSignUpMasterData? {
        // return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: String]) ?? [:])
        
        
        if let data = UserDefaults.standard.object(forKey: Core.signUpEntityKey) as? Data {
            let decoder = JSONDecoder()
            if let signUpEntity = try? decoder.decode(UserNewSignUpMasterData.self, from: data) {
                
                return signUpEntity
            }
            
        }
         return nil
        
        
    }
    
    //For calling Core Data
    //Retrieve user signup data if it exists
    func TestCoreData() {
        
        if let signUpEntity = Core.getSignUpEntity() {
            // Use the retrieved data:
            print("enable_otp_only", signUpEntity.enable_otp_only)
           
        } else {
            // No saved data found
            print("No user signup data found.")
        }
    }
       
}
