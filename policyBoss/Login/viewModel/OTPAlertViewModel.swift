//
//  OTPAlertViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

@MainActor class OTPAlertViewModel : ObservableObject {
    
    
    @Published var isShowingDetails = false
    
    @Published var dynamicText : String = ""
    
    @Published var isValid = true
    
    var errorMessage = ""
    
   
    
   
 
    
    func validateOTP(strCode : String) -> Bool {
      
        if strCode.isEmpty {
            errorMessage = "Please Enter OTP."
            isValid = false
        }  else {
            errorMessage = "" // Clear any previous error message
            isValid = true
        }
        return isValid
    }
    
    
    func validateOTP1(strCode : String) ->( Bool,String) {
      
        var isVerify : Bool = false
        var strMessage = ""
        if strCode.isEmpty {
            strMessage = "Please Enter OTP."
            isVerify = false
        }
        else {
            strMessage = "" // Clear any previous error message
            isVerify = true
        }
        return (isVerify,strMessage)
    }
    
    init(){
        
        print("Init is Called...")
    }
    
    //Note : Class need init if we paas variable which is not initializes.
    
//    init(dynamicText: String) {
//           self.dynamicText = dynamicText
//       }
    
}


struct OTPAlertValidation{
    
    var  isValid : Bool = true
    var  code : String = ""
    var  errorMessage : String = ""
    
   mutating func validateOTP() -> Bool {
        if code.count != 4 {
            isValid = false
            errorMessage = "Please enter a valid OTP."
        } else {
            isValid = true
             errorMessage = ""
        }
       return isValid
    }
}
