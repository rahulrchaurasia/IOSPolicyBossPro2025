//
//  UserDefaultsManager.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/03/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//


import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard

    // Keys
    private enum Keys {
        
        //Horizon DSAS API
        static let fbaId = "FBAId"
        static let refererCode = "referer_code"
        static let pospNo = "POSPNo"
        static let custID = "CustID"
        static let mobileNumber = "MobiNumb1"
        static let emailId = "EmailID"
        static let loanID = "LoanId"
        static let fullName = "FullName"
        static let erpId = "ERPID"
        static let userId = "UserId"
        static let isFirstLogin = "IsFirstLogin"
        static let uidLogin = "IsUidLogin"
        static let  isAgent = "policyBossPro_isAgent"
        static let empUID = "EMP_UID"
        
        static let raiseTicketURL = "raiseTicketURL"
        
        //SubUser
        static let subUserSsId = "SubUser_Ss_Id"
               static let subUserSubFbaId = "SubUser_Sub_FBA_ID"
               static let subUserEmail = "SubUser_Email_ID"
               static let subUserFirstName = "SubUser_First_Name"
               static let subUserLastName = "SubUser_Last_Name"
               static let subUserMobile = "SubUser_Mobile"
        //*** end here********
    }

    //Horizon DSAS API
   
    private init() {} // Private init to prevent multiple instances


   
    
   
    
    // MARK: - Save Methods of Horizon Api
        func savePOSPNo(_ pospNo: String) {
            defaults.set(pospNo, forKey: Keys.pospNo)
        }
        
        func saveFbaId(_ fbaId: String) {
            defaults.set(fbaId, forKey: Keys.fbaId)
        }
        
        func saveFullName(_ name: String) {
            defaults.set(name, forKey: Keys.fullName)
        }
        
        func saveErpId(_ erpId: String) {
            defaults.set(erpId, forKey: Keys.erpId)
        }
        
        func saveUserId(_ userId: String) {
            defaults.set(userId, forKey: Keys.userId)
        }
        
        func saveEmailId(_ email: String) {
            defaults.set(email, forKey: Keys.emailId)
        }
        
        func saveMobileNumber(_ number: String) {
            defaults.set(number, forKey: Keys.mobileNumber)
        }
        
        func saveIsAgent(_ isAgent: Bool) {
            defaults.set(isAgent ? "Y" : "N", forKey: Keys.isAgent)
        }
        
        func saveIsFirstLogin(_ value: Bool) {
            defaults.set(value ? "1" : "0", forKey: Keys.isFirstLogin)
        }
        
        func saveEmpUID(_ uid: String) {
            defaults.set(uid, forKey: Keys.empUID)
        }
        
        // MARK: - Retrieve Methods
        func getPOSPNo() -> String {
            return defaults.string(forKey: Keys.pospNo) ?? ""
        }
        
        func getFbaId() -> String {
            return defaults.string(forKey: Keys.fbaId) ?? ""
        }
        
        func getFullName() -> String {
            return defaults.string(forKey: Keys.fullName) ?? ""
        }
        
        func getErpId() -> String {
            return defaults.string(forKey: Keys.erpId) ?? ""
        }
        
        func getUserId() -> String {
            return defaults.string(forKey: Keys.userId) ?? ""
        }
        
        func getEmailId() -> String {
            return defaults.string(forKey: Keys.emailId) ?? ""
        }
        
        func getMobileNumber() -> String {
            return defaults.string(forKey: Keys.mobileNumber) ?? ""
        }
        
        func getIsAgent() -> Bool {
            return defaults.string(forKey: Keys.isAgent) == "Y"
        }
        
        func getIsFirstLogin() -> Bool {
            return defaults.string(forKey: Keys.isFirstLogin) == "1"
        }
        
        func getEmpUID() -> String {
            return defaults.string(forKey: Keys.empUID) ?? ""
        }
    
    
      // Mark: For UserConstant API
        func setRaiseTicketURL(_ raiseTicket: String) {
            defaults.set(raiseTicket, forKey: Keys.raiseTicketURL)
        }
    
        func getRaiseTicketURL() -> String {
            return defaults.string(forKey: Keys.raiseTicketURL) ?? ""
        }
    
    /// ✅ Save all sub-user details at once
       func saveSubUserDetails(ssId: String, subFbaId: String, email: String, firstName: String, lastName: String, mobile: String) {
           defaults.set(ssId, forKey: Keys.subUserSsId)
           defaults.set(subFbaId, forKey: Keys.subUserSubFbaId)
           defaults.set(email, forKey: Keys.subUserEmail)
           defaults.set(firstName, forKey: Keys.subUserFirstName)
           defaults.set(lastName, forKey: Keys.subUserLastName)
           defaults.set(mobile, forKey: Keys.subUserMobile)
       }
    
    func isUserAgent() -> Bool {
        
        let userType = Core.shared.getUserType()
        
        return if( userType == .posp || (userType == .fos)  ){
            true
        }else{
            false
        }
    }

       /// ✅ Retrieve values separately
       func getSubUserSsId() -> String? {
         
           
        let userType = Core.shared.getUserType() // Fetch latest stored userType
        return userType == .posp ? (defaults.string(forKey: Keys.subUserSsId) ?? "0") : "0"

       }
       
      //getSubFbaId(): This function only retrieves the stored value from UserDefaults without adding logic.
       private func getSubFbaId() -> String? {
            return defaults.string(forKey: Keys.subUserSubFbaId)
        }
    
    
    // Mark : Vip, Required this Field to pass in SubUser
    //this function applies business logic (checking userType) before returning a value.
       func getSubUserSubFbaId() -> String? {
           //return defaults.string(forKey: Keys.subUserSubFbaId)
           
           // Fetch latest stored userType
            let userType = Core.shared.getUserType()
              
              // Ensure latest sub user details are fetched
           return userType == .posp ? (UserDefaultsManager.shared.getSubFbaId() ?? "0") : "0"

       }
       
       func getSubUserEmail() -> String? {
           return defaults.string(forKey: Keys.subUserEmail)
       }
       
       func getSubUserFirstName() -> String? {
           return defaults.string(forKey: Keys.subUserFirstName)
       }
       
       func getSubUserLastName() -> String? {
           return defaults.string(forKey: Keys.subUserLastName)
       }
    
       func getSubUserName() -> String {
        let firstName = getSubUserFirstName() ?? ""
        let lastName = getSubUserLastName() ?? ""

        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
       }
       
       func getSubUserMobile() -> String? {
           return defaults.string(forKey: Keys.subUserMobile)
       }
       
       /// ✅ Clear all stored sub-user details
       func clearSubUserDetails() {
           defaults.removeObject(forKey: Keys.subUserSsId)
           defaults.removeObject(forKey: Keys.subUserSubFbaId)
           defaults.removeObject(forKey: Keys.subUserEmail)
           defaults.removeObject(forKey: Keys.subUserFirstName)
           defaults.removeObject(forKey: Keys.subUserLastName)
           defaults.removeObject(forKey: Keys.subUserMobile)
       }
    
    /// ✅ Clear all stored UserDefaults values (used during logout)
        func clearAllUserDefaults() {
            let keys = defaults.dictionaryRepresentation().keys
            for key in keys {
                defaults.removeObject(forKey: key)
            }
           
            debugPrint("UserDefaults cleared successfully")
        }

    
    //*** end here********
    
    
    //For retreive
    
    /*
    if let ssId = UserDefaultsManager.shared.getSubUserSsId() {
        print("SubUser_Ss_Id:", ssId)
    }

    if let subFbaId = UserDefaultsManager.shared.getSubUserSubFbaId() {
        print("SubUser_Sub_FBA_ID:", subFbaId)
    }
     */
    
}
