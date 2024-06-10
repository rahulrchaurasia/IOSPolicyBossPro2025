//
//  LoginRepository.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 14/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation
import UIKit


final class LoginRepository {
    
    static let shared = LoginRepository()
    
    var userType : UserType = .none
    var ErpId = "0"
    var POSP_FbaId   = "0"
    var POSP_EmailId = ""
   
    
    var EMP_EmpName = ""
    var EMP_FbaId = "0"
    var EMP_UID = "0"
    var EMP_Mobile_Number = ""
    var EMP_Email_Id = ""
   
    
    var POSP_USERNameOnPAN = ""
    var POSP_USERUserId = ""
    var POSP_USERMobile_No = ""
    
    private init() {
           // Private initializer to prevent external instantiation
    }

    func getotpLoginHorizon(login_id: String) async throws -> (String ,String,String) {
        
        var Mobile_No = ""
        var Status = ""
        var Ss_Id = ""

        let endUrl = "/postservicecall/otp_login"
        let urlString =  Configuration.baseROOTURL  + endUrl
        
        guard let url = URL(string: urlString) else {
         
            throw APIError.invalidURL
        }
        
        // Set the "token" header
        let tokenValue = "1234567890"
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        
        let apiReq: [String: Any] = [
                        
                        "login_id": login_id ,
                         ]
               
                do {
                       let jsonData = try JSONSerialization.data(withJSONObject: apiReq)
                       debugPrint("Request:-", jsonData)
                       request.httpBody = jsonData
                   } catch {
                       print(error.localizedDescription)
                   }

        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            if httpResponse.statusCode != 200 {
                
                // Create an appropriate error based on status code and optional message
                throw APIError.unexpectedResponse
                
            }
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if let _status = jsonObject["Status"] as? String {
                    print("status",_status )
                    Status = _status
                    
                }
                if let msgDict = jsonObject["Msg"] as? [String: Any] {
                    
//                    if let _mobileNo = msgDict["Mobile_No"] as? NSNumber {
//                        print("OTP Mobile_No",_mobileNo )
//                        Mobile_No = _mobileNo.stringValue
//                        
//                    }
                    if let _mobileNo = msgDict["Mobile_No"] as? String {
                        print("OTP Mobile_No",_mobileNo )
                        Mobile_No = _mobileNo
                        
                    }
                    if let _ss_Id = msgDict["Ss_Id"] as? NSNumber {
                        print("OTP Ss_Id",_ss_Id )
                        Ss_Id = _ss_Id.stringValue
                        
                    }
                }
               
            }
        } catch {
            // Handle errors during the network request
            
            throw APIError.unexpectedError(error: error)
           
        }
        return (Status,Mobile_No,Ss_Id)
    }
    
    func verifyOTP(otp: String, mobileNumber: String) async throws -> String {
        let urlString = "https://horizon.policyboss.com:5443/verifyOTP_New/\(otp)/\(mobileNumber)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            if httpResponse.statusCode != 200 {
                
                // Create an appropriate error based on status code and optional message
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: Constant.serverMessage)
                
            }
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if let Msg = jsonObject["Msg"] as? String {
                    print("Msg",Msg )
                    
                    return Msg
                }
            }
        } catch {
            // Handle errors during the network request
            
            throw APIError.unexpectedError(error: error)
        }
        return "fail"
    }
    
    func resendOTP( mobileNumber: String) async throws -> String {
        let urlString = "https://horizon.policyboss.com:5443/generateOTP_New/\(mobileNumber)/ONBOARDING"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            if httpResponse.statusCode != 200 {
                
                // Create an appropriate error based on status code and optional message
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: Constant.serverMessage)
                
            }
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if let Msg = jsonObject["Msg"] as? String {
                    print("Msg",Msg )
                    
                    return Msg
                }
            }
        } catch {
            // Handle errors during the network request
            
            throw APIError.unexpectedError(error: error)
        }
        return "fail"
    }
    
    func getLoginDetailHorizon(ssID : Int) async throws {
        
        
        guard let url = URL(string: "https://horizon.policyboss.com:5443/posps/dsas/view/\(ssID)") else {
            throw APIError.invalidURL
        }
    
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        debugPrint("Request:-", url)
       
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            if httpResponse.statusCode != 200 {
                
                // Create an appropriate error based on status code and optional message
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: Constant.serverMessage)
                
            }
            
            
//            let decoder = JSONDecoder()
//            return try  decoder.decode(LoginNewResponse_DSAS_Horizon.self, from: data)
//
            
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if let user_type = jsonObject["user_type"] as? String {
                    print("user_type",user_type )
                    userType = UserType(rawValue: user_type) ?? .none
                    
                    debugPrint("User Type",userType.rawValue)
                    
                   
                    if(userType.isAgent){
                        
                        UserDefaults.standard.set("Y", forKey: getSharPrefernce.isAgent)
                        
                    }else{
                        UserDefaults.standard.set("N", forKey: getSharPrefernce.isAgent)
                        
                    }
                    
                    //Mark : POSP
                    if let pospDict = jsonObject["POSP"] as? [String: Any] {
                        // Access pospDict within this block
                        if let Erp_Id = pospDict["Erp_Id"] as? String {
                            print("Erp_Id",Erp_Id  )
                        }
                       // Fba_Id Fba_Id
                        if let Fba_Id = pospDict["Fba_Id"] as? String {
                            
                            POSP_FbaId = Fba_Id
                        }
                        
                        if let Email_Id = pospDict["Email_Id"] as? String {
                            POSP_EmailId = Email_Id
                        }
                        
                        
                        
                        
                        
                    }
                    
                    // Mark : EMP
                    if let empDict = jsonObject["EMP"] as? [String: Any] {
                        // Access pospDict within this block
                        if let Emp_Name = empDict["Emp_Name"] as? String {
                            EMP_EmpName = Emp_Name
                        }
                        if let _UID = empDict["UID"] as? NSNumber {
                            EMP_UID = _UID.stringValue
                        }
                        if let FBA_ID = empDict["FBA_ID"] as? NSNumber {
                            EMP_FbaId = FBA_ID.stringValue
                        }
                        if let Mobile_Number = empDict["Mobile_Number"] as? NSNumber {
                            EMP_Mobile_Number = Mobile_Number.stringValue
                        }
                        if let Email_Id = empDict["Email_Id"] as? String {
                            EMP_Email_Id = Email_Id
                        }
                        
                      
                        
                    }
                    
                    // Mark : POSP_USER
                    if let userDict = jsonObject["POSP_USER"] as? [String: Any] {
                        
                        if let Erp_Id = userDict["Erp_Id"] as? String {
                            ErpId = Erp_Id
                        }
                        // Access pospDict within this block
                        if let Name_On_PAN = userDict["Name_On_PAN"] as? String {
                            POSP_USERNameOnPAN = Name_On_PAN
                        }
                        if let User_Id = userDict["User_Id"] as? NSNumber {
                            POSP_USERUserId = User_Id.stringValue
                        }
                        
                        if let Mobile_No = userDict["Mobile_No"] as? String {
                            POSP_USERMobile_No = Mobile_No
                        }
                        
                    } else {
                        // Handle missing or unexpected POSP (not a dictionary)
                    }
                    
                    
                    
    
                }
                

                //let fbaid = getFbaId(userType: userType)
                UserDefaults.standard.set(getFbaId(userType: userType), forKey: "FBAId")
                UserDefaults.standard.set("", forKey: "referer_code")
                UserDefaults.standard.set(String(describing: ssID), forKey: "POSPNo")
                UserDefaults.standard.set(String(describing: 0), forKey: "CustID")
                UserDefaults.standard.set(String(describing: getMobileNo()), forKey: "MobiNumb1")
                UserDefaults.standard.set(String(describing: getEmailId()), forKey: "EmailID")
                UserDefaults.standard.set(String(describing: 0), forKey: "LoanId")
                UserDefaults.standard.set(String(describing: getName()), forKey: "FullName")
                       
                UserDefaults.standard.set(String(describing: ErpId), forKey: "ERPID")
                UserDefaults.standard.set(String(describing: getUserId()), forKey: "UserId")
                
                UserDefaults.standard.set(String(describing: "1"), forKey: "IsFirstLogin")
                UserDefaults.standard.set(String(describing: EMP_UID), forKey: getSharPrefernce.uidLogin)

               
                
            } else {
                throw APIError.custom(message: "Error decoding JSON")
            }
         
            ////////////////
//            let horizonDetailResult = try JSONDecoder().decode(LoginNewResponse_DSAS_Horizon.self, from: data)
//                
//            print("HORIZON CALL",horizonDetailResult.Ss_Id ?? "No Data")
//            
//            
//            return horizonDetailResult
            
        } catch {
            print("HORIZON CALL",error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
        
    }

    
    private func getFbaId(userType : UserType) -> String {
            switch userType {
            case .posp:
                return POSP_FbaId
            case .fos:
                // Handle FOS
                return POSP_FbaId
            case .emp:
                return EMP_FbaId
            case .misp:
                // Handle MISP
                return EMP_FbaId
            case .none:
                return ""
            }
        }
    
    private func getName() -> String {
            switch userType {
            case .posp:
                if(!POSP_USERNameOnPAN.isEmpty)
                {
                   return POSP_USERNameOnPAN
                }else{
                    return EMP_EmpName
                }
            case .fos:
                // Handle FOS
                return POSP_USERNameOnPAN
            case .emp:
                return EMP_EmpName
            case .misp:
                // Handle MISP
                return EMP_EmpName
                
            case .none:
                return ""
            
            }
        }
    
    private func getMobileNo() -> String {
            switch userType {
            case .posp:
                return POSP_USERMobile_No
            case .fos:
                // Handle FOS
                return POSP_USERMobile_No
            case .emp:
                return EMP_Mobile_Number
            case .misp:
                // Handle MISP
                return EMP_Mobile_Number
                
            case .none:
                return ""
            }
        }
    
    private func getEmailId() -> String {
            switch userType {
            case .posp:
                return POSP_EmailId
            case .fos:
                // Handle FOS
                return POSP_EmailId
            case .emp:
                return EMP_Email_Id
            case .misp:
                // Handle MISP
                return EMP_Email_Id
                
            case .none:
                return ""
            }
        }
    
    private func getUserId() -> String {
        return EMP_UID
    }
    
    
    
    
    //Mark :--> SalesMaterial User Click Api
    // Using Async and Await :-->
    func salesMaterialContent_usage(salesMaterClickReq : SalesMaterialContentUsageRequest) async throws ->  String{

        
        let endUrl = "/postservicecall/content_usage"
        let urlString =  Configuration.baseROOTURL  + endUrl


        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("URL :-", urlString)

            
        do {
            let jsonReq = try? JSONEncoder().encode(salesMaterClickReq)
            debugPrint("Request:-", salesMaterClickReq)
            request.httpBody = jsonReq
            
           
        } catch {
            print(error.localizedDescription)
        }
        
       
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        //Parse the JSON Data
        
            let salesMaterialResp = try? JSONDecoder().decode(SalesMaterialContentUsageResponse.self, from: data)
       
        
        
        return salesMaterialResp?.Status ?? ""
        
        
        
    }
    
}
