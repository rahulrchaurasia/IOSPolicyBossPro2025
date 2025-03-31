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
        
        return "\(msgOTPOnMobNo) \(maskPhoneNumber(OTPDataViewModel.shareInstance.getOtpMobileNo()))"
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
//    private var OTP_ssid: String = ""
//    private  var OTP_mobNo = ""
//    
//    func setOTPSSID(newSsid : String){
//        
//        OTP_ssid = newSsid
//    }
//    func getOTPSsid() -> String {
//        
//      return OTP_ssid
//    }
//    
//    func setOTPMobileNo(newMobleNo : String){
//        
//        OTP_mobNo = newMobleNo
//    }
//    func getOtpMobileNo() ->String {
//           
//        return OTP_mobNo
//    }
    init(){
        
        print("Init is Called...")
    }
    
    //Note : Class need init if we paas variable which is not initializes.
    
//    init(dynamicText: String) {
//           self.dynamicText = dynamicText
//       }
    
    
    //*********************************************************//
    
    //Mark : Api Call
    
    
     // LoginVC
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
        
        let (data,response) =  try await URLSession.shared.data(for: request,delegate: nil)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print ("httpResponse.statusCode: \(httpResponse.statusCode)")

            
            return .failure(.custom(message: Constant.InvalidResponse ))
        }
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
    //************************* Password ********************************************
   
    //Mark :  Horizon Api Called Main here {After login success horizon Api called}
    func getAuthLoginHorizon(username : String,password : String) async throws -> Result<String, APIErrors>{
        
        
        let endUrl = "/auth_tokens/auth_login"
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
        
        let apiReq: [String: Any] = [
                "username": username,
                "password": password ,
                
            ]
        
        do {
               let jsonData = try JSONSerialization.data(withJSONObject: apiReq)
               debugPrint("Request:-", jsonData)
               request.httpBody = jsonData
           } catch {
            
               return .failure(.custom(message: Constant.EncodeError))
            }
        
        do {
            let (data,_) =  try await URLSession.shared.data(for: request,delegate: nil)
            
            //let authLoginResponse = try JSONDecoder().decode(AuthLoginResponse.self, from: data)
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
   
                  do {
     
                      if let status = jsonObject["Status"] as? String {
                          
                          if(status.lowercased() == "success"){
                              
                              if let ssIdInt = jsonObject["SS_ID"] as? Int {
                                   print("SS_ID as Int:", ssIdInt)
                                                      //let horizonDetailResult =
                                                      try await  LoginRepository.shared.getLoginDetailHorizon(ssID: (ssIdInt))
                                                      
                                                        print("HORIZON CALL \(ssIdInt)")
                               }
                              
                              else if let ssIdString = jsonObject["SS_ID"] as? String {
                                   if let ssidInt = Int(ssIdString){
                                       
                                       print("SS_ID as String:", ssIdString)
                                       
                                               print("HORIZON CALL",ssIdString )
                                                          // let horizonDetailResult =
                                       try await  LoginRepository.shared.getLoginDetailHorizon(ssID:  ssidInt )
                                           
                                   }
                                                  
                                                      
                               }
                          }
                          
                          else {
                              
                              isLoading = false
                              isValid = false
                             // errorMessage = authLoginResponse.Msg?.ErrorResponse ?? "Invalid UserId and password"
                              errorMessage =  "Invalid UserId and password"
                              return .failure(.custom(message: serverUnavailbleError ))
                              
                              
                          }
                      }
                      
                    
                }catch {
                    isLoading = false
                    print("HORIZON CALL",error.localizedDescription)
                    
                    return .failure(.custom(message:  String(describing: error)) )
                }
                
                
    
            }
            
          
                print("Called API Done")
                
               

                
                return .success("Success")
                
            }
            
        catch {
         
            return .failure(.custom(message: "Network error: \( String(describing: error))"))
         }
        
    }
    
    
    //************************* OTP ********************************************
   
    //Mark : Get OTP : Called From LoginVC ie Uikit not swiftui
    func getotpLoginHorizon(login_id: String) async throws -> String {
        
       
        do{
           let (status , mobNo, SsID)  =  try await  LoginRepository.shared.getotpLoginHorizon(login_id: login_id)
            
            if status.lowercased() == "success"{
                
//                setOTPSSID(newSsid: SsID)
//                setOTPMobileNo(newMobleNo: mobNo)
                
                OTPDataViewModel.shareInstance.setOTPSSID(newSsid: SsID)
                OTPDataViewModel.shareInstance.setOTPMobileNo(newMobleNo: mobNo)
                
            }
           print("otp status",status)
            return status
            
        }catch{
            
            print(String(describing: error))
            return "fail"
           
        }
       
    }
    
    //Mark : Veridy OTP
    func verifyOTP(otp: String, mobileNumber: String) async throws -> String {
        
        isLoading = true
        do{
            let response =  try await  LoginRepository.shared.verifyOTP(otp: otp, mobileNumber: mobileNumber)
            
            if(response.lowercased() == "success"){
               
                print("HORIZON CALL",OTPDataViewModel.shareInstance.getOTPSsid() )
                if let ssidInt = Int(OTPDataViewModel.shareInstance.getOTPSsid()){
                   // let horizonDetailResult =
                   
                    try await  LoginRepository.shared.getLoginDetailHorizon(ssID: ssidInt  )
                }
                
            }
           
            print("OTP Verify reponse",response)
            return response
        }catch{
            isLoading = false
            print(String(describing: error))
            return "fail"
           
        }
       
    }
    
    //Mark : resend OTP
    func resendOTP( mobileNumber: String) async throws -> String {
        
    
        do{
           let response =  try await  LoginRepository.shared.resendOTP(mobileNumber: mobileNumber)
            
            print("API Resend Response",response)
            return response
        }catch{
            
            print(String(describing: error))
            return "fail"
           
        }
       
    }

    
    //************************* Horizon call ********************************************
   
    func getLoginDetailHorizon(userID : Int)  async throws -> Result<LoginNewResponse_DSAS_Horizon, APIErrors>{


      
        let urlString =  "https://horizon.policyboss.com:5443/posps/dsas/view/\(userID)"
        
     
        guard let url = URL(string: urlString) else {
         
            return .failure(.custom(message: Constant.InvalidURL))
        }
        
        // Set the "token" header
        //let tokenValue = "1234567890"
      
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        do {
//            let (data,response) =  try await URLSession.shared.data(for: request,delegate: nil)
            let (data, response) = try await URLSession.shared.data(for: request)

            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print ("httpResponse.statusCode: \(httpResponse.statusCode)")
                
                
                return .failure(.custom(message: Constant.InvalidResponse ))
            }
            let horizonDetailResult = try JSONDecoder().decode(LoginNewResponse_DSAS_Horizon.self, from: data)
            
            print("horizon Called API Done \(horizonDetailResult.status ?? "")")
            
            // return( String(UserNewSignUpResponse.StatusNo))
            
            if  horizonDetailResult.status == "SUCCESS" {
                // self.userNewSignUpData = UserNewSignUpResponse.MasterData
                
                print("Called API Done")
                return .success(horizonDetailResult)
                
            } else {
                
                // errorMessage = UserNewSignUpResponse.Message // Handle error message
                
                return .failure(.custom(message: horizonDetailResult.status ?? "" ))
                
            }
        }catch {
            print("HORIZON CALL",error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
        
        
        
    }
   
   
    //not used
    
    
    
    //************************ Sales Material ******************************************
   
    //Mark : resend OTP
    func salesMaterialContent_usage( salesMaterClickReq : SalesMaterialContentUsageRequest) async throws -> String {
        
    
    
        do{
           let response =  try await  LoginRepository.shared.salesMaterialContent_usage(salesMaterClickReq: salesMaterClickReq )
            
           // print("API Resend Response",response)
            return response
        }catch{
            
           // print(String(describing: error))
            return "fail"
           
        }
       
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

final class OTPDataViewModel{
    
   
    static let shareInstance = OTPDataViewModel()
    
    //POSP NO.
    private var OTP_ssid: String = ""
    private  var OTP_mobNo = ""
    
    var blnIsKeyBoardOTP : Bool = false
    var tempCodeDict = Dictionary<Int,String>(uniqueKeysWithValues: (0..<4).map{($0,"")}
    )
     
                                          
                                              
                                        
    private var tempIndex : Int = 0
    
    func setOTPSSID(newSsid : String){
        
        OTP_ssid = newSsid
    }
    func getOTPSsid() -> String {
        
      return OTP_ssid
    }
    
    func setOTPMobileNo(newMobleNo : String){
        
        OTP_mobNo = newMobleNo
    }
    func getOtpMobileNo() ->String {
           
        return OTP_mobNo
    }
    
    
    //
    func settempIndex(){
        
        tempIndex = tempIndex + 1
    }
    func gettempIndex() -> Int{
        
        return tempIndex
    }
    
    func settempDict( data : String){
        
        if( tempIndex >= 0 && tempIndex <= 3 ){
            
            tempCodeDict.updateValue(data, forKey: tempIndex)
            
            debugPrint("temp Dict position: \(tempIndex)  and value\(data)")
            
            tempIndex = tempIndex + 1
        }
      
        
    }
   
    func gettempDict() -> Dictionary<Int,String>{
        
        return tempCodeDict
    }
    
    func resetIsKeyBoard(){
        
        blnIsKeyBoardOTP = false
    }
    
    func resettempDictandIndex(){
        
        tempIndex = 0
       
        
        for (key, _) in tempCodeDict {
            tempCodeDict[key] = "" // Or nil, depending on your needs
        }
    }
    
   
}
