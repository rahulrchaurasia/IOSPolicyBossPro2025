//
//  LoginNewResponse_DSAS_Horizon.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 13/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation


struct LoginNewResponse_DSAS_Horizon: Codable {
    var EMP: EMP?
    var POSP: POSP?  = nil  //some time come String ie"NA" or some time posp Object
    var POSP_USER: POSP_USER?
    var DEVICE: DEVICE?
    var channel: String?
    var product: String?
    var status: String?
    var user_type: String?
    var Ss_Id: Int64?
    
  
  
}

struct EMP: Codable {
    var Email_Id: String?
    var Emp_Name: String?
    var UID: Int64?
    
   
   
}

struct POSP: Codable {
    
    var Erp_Id: String?
    var Fba_Id: String?
    var Email_Id: String?
    
   
}



struct POSP_USER: Codable {
    var Name_On_PAN: String?
    var User_Id: Int?
    var Mobile_No: String?
    
  
}

struct DEVICE: Codable {
    var OS_Detail: String?
    var App_Version: String?
    var Device_Name: String?
    var Device_Identifier: String?
    var Created_On: String?
    var Activated_On: String?
    

}
