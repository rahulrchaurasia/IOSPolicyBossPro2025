//
//  OTPAlertViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

@MainActor class LoginViewModel : ObservableObject {
    
   // static let shareInstance = OTPAlertViewModel()
    
    @Published var isLoading: Bool = false
    
    @Published var isShowingDetails = false
    
    @Published var isValid = true
    
    var msgOTPOnMobNo : String = "We have sent you One-Time Password on"
    
     var errorMessage = ""
    
    
    
    @Published var password: String = ""  // For TextField

    @Published var isPasswordValid: Bool = false  // For Checking always Password Validation req Publish

    
    var data: [String] = []
    
    // For Api
    @Published var userNewSignUpData: [UserNewSignUpMasterData] = []
   
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
          
        isPasswordValid = false
        errorMessage = ""
        return true
        
        
      }
    
    
    init(){
        
        print("Init is Called...")
    }
    
    //Note : Class need init if we paas variable which is not initializes.
    
//    init(dynamicText: String) {
//           self.dynamicText = dynamicText
//       }
    
    
    //*********************************************************//
    
    //Mark : Api Call
    
  
    
    func getusersignup() async throws -> Result<UserNewSignUpResponse, APIErrors>{


        let endUrl = "/quote/Postfm/Getusersignup"
        let urlString =  Configuration.baseROOTURL  + endUrl
        
        guard let url = URL(string: urlString) else {
         
            return .failure(.custom(message: Constant.InvalidURL))
        }
        
        // Set the "token" header
        let tokenValue = "1234567890"
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        
        let (data,_) =  try await URLSession.shared.data(for: request,delegate: nil)
        
        let UserNewSignUpResponse = try JSONDecoder().decode(UserNewSignUpResponse.self, from: data)
        
        print("Called API Done \(UserNewSignUpResponse.Message)")
        
       // return( String(UserNewSignUpResponse.StatusNo))
        
        if UserNewSignUpResponse.StatusNo == 0 {
           // self.userNewSignUpData = UserNewSignUpResponse.MasterData
            
            print("Called API Done")
            Core.saveUserSignUpEntity(signUpEntity: UserNewSignUpResponse.MasterData[0])
            return .success(UserNewSignUpResponse)
           
        } else {
            
           // errorMessage = UserNewSignUpResponse.Message // Handle error message
            
            return .failure(.custom(message: UserNewSignUpResponse.Message ))
         
        }
        
        
        
    }
    
    func getAuthLoginHorizon() async throws -> Result<AuthLoginResponse, APIErrors>{
        
        
        let endUrl = "/quote/Postfm/auth_login"
        let urlString =  Configuration.baseROOTURL  + endUrl
        
        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
        
        // Set the "token" header
        let tokenValue = "1234567890"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        
        let apiReq: [String: Any] = [
                "username": "107896",
                "password": 107896 ,
                
            ]
        
        do {
               let jsonData = try JSONSerialization.data(withJSONObject: apiReq)
               debugPrint("Request:-", jsonData)
               request.httpBody = jsonData
           } catch {
               print(error.localizedDescription)
           }
        
        
        
        let (data,_) =  try await URLSession.shared.data(for: request,delegate: nil)
        
        let authLoginResponse = try JSONDecoder().decode(AuthLoginResponse.self, from: data)
        
        print("auth_login API\(authLoginResponse)")
        
        // return( String(UserNewSignUpResponse.StatusNo))
        
        if authLoginResponse.Status.lowercased() == "success" {
            // self.userNewSignUpData = UserNewSignUpResponse.MasterData
            
            print("Called API Done")
            
           
             
                if let ssID = authLoginResponse.SS_ID {
                    // SS_ID is not nil, use it here
                    print("SS_ID:", ssID)
                    //getLoginDetailHorizon(it)
                } else {
                    // SS_ID is nil, handle it accordingly
                    print("SS_ID is nil")
                }
            
            return .success(authLoginResponse)
            
        } else {
            
            // errorMessage = UserNewSignUpResponse.Message // Handle error message
            
            return .failure(.custom(message: serverUnavailbleError ))
            
        }
        
        
        
    }

    //not used
    func getempbyregsource1000(campaignid : String) async throws -> (
    
        String
    ){
        
        let endUrl = "/quote/Postfm/getempbyregsource"
        let urlString =  Configuration.baseROOTURL  + endUrl
        
        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
       
        // Set the "token" header
        let tokenValue = "1234567890"
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        

        let apiReq: [String: Any] = [
                "appTypeId": "4",
                "campaignid": campaignid ,
                
            ]
        
        
        do {
               let jsonData = try JSONSerialization.data(withJSONObject: apiReq)
               debugPrint("Request:-", jsonData)
               request.httpBody = jsonData
           } catch {
               print(error.localizedDescription)
           }
        
        
        let (data,_) =  try await URLSession.shared.data(for: request,delegate: nil)
        
        let EmpbyregsourceResp = try JSONDecoder().decode(EmpbyregsourceResponse.self, from: data)
        
        
        
        return( String(EmpbyregsourceResp.StatusNo))
    }
    
        
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
