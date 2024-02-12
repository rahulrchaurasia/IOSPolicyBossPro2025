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
    
    @Published var isValid = true
    
    var msgOTPOnMobNo : String = "We have sent you One-Time Password on"
    
    var errorMessage = ""
    
    
    
    @Published var password: String = ""  // For TextField

    @Published var isPasswordValid: Bool = false  // For Checking always Password Validation req Publish

    
   
    //Mark : OTP handling
    func getMobOTPMessage() ->String {
        
        return "\(msgOTPOnMobNo) \(maskPhoneNumber("9773113793"))"
    }
    
    func maskPhoneNumber(_ phoneNumber: String) -> String {
        guard phoneNumber.count >= 10 else {
            // Handle cases where the phone number is not long enough to mask
            return phoneNumber
        }

        let maskedDigits = String(repeating: "*", count: 6)
        let lastDigits = String(phoneNumber.suffix(4))
        let maskedPortion = maskedDigits + lastDigits

        return maskedPortion
    }

    func validateOTP(strCode : String) -> Bool {
      
        if strCode.isEmpty {
            errorMessage = "Please Enter OTP"
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
            strMessage = "Please Enter OTP"
            isVerify = false
        }
        else {
            strMessage = "" // Clear any previous error message
            isVerify = true
        }
        return (isVerify,strMessage)
    }
    
    //*********************************************************//
    
    //Mark : Password Handling
    func validatePasswordForm() -> Bool {
       
        if self.password.isEmpty {
            isPasswordValid = true
            errorMessage = "Please Enter Password"
             
            return false
          }
          
        return true
      }
    
    
    init(){
        
        print("Init is Called...")
    }
    
    //Note : Class need init if we paas variable which is not initializes.
    
//    init(dynamicText: String) {
//           self.dynamicText = dynamicText
//       }
    
}


// Not in used
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
