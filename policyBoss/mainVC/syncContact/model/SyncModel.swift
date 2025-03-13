//
//  SyncRequestModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/04/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

//Mark : Requset Model Of Sync
//************* Start Requset Model Of Sync*************************************
struct SyncContactModelRequest : Encodable {
    var fbaid : String
    var ssid : String
    var sub_fba_id : String
    var device_id : String
    var raw_data : String
    var contactlist : [ContactMainModel] = []
   
}

// Encodable : For Swift To JSON
struct ContactMainModel :Identifiable, Encodable  {
    
    //var id1 = UUID().uuidString
    var id : Int
    var name : String
    var mobileno : String
    
//    init(id: Int, name: String, mobileno: String) {
//        self.id = id
//        self.name = name
//        self.mobileno = mobileno
//    }
}

//
class ContactModelRaw :Identifiable, Encodable {
    var id = UUID().uuidString
    
    var displayName: String = ""
    var givenName: String = ""
    var middleName: String = ""
    var familyName : String = ""
    
    var phone: [String] = []
    var phoneNumbers: [PhoneData] = []
    var nickname: String = ""
    var companyName : String = ""
    var companyTitle : String = ""
    var companyDepartment : String = ""
    
    var emails: [EmailData] = [] 
    var addresses: [AddressData] = []
    var websites: [String] = []
    var relations : [RelationData] = []
    var events : [EventData] = []
    var note: String = ""
  

    
}

struct PhoneData  : Encodable {
    var normalizedNumber: String = ""
    var number: String = ""
    var type: String = ""
   
}

struct EventData  : Encodable {
   
    var startDate: String = ""
    var type: String = ""
   
}


struct EmailData  : Encodable {
   
    var address: String = ""
    var type: String = ""
   
}

struct AddressData  : Encodable {
   
    var formattedAddress: String = ""
    var type: String = ""
   
}

struct RelationData  : Encodable {
   
    var relationName : String  = ""
    var relationLabel : String = ""
   
}



struct ContactModel :Identifiable, Encodable {
    var id = UUID().uuidString
    
    var Name: String //= "No firstName"
    var PhoneNumbers: [String] //= []
    var EmailAddresses: [String]// = []
    
    var OrganizationName: String
    
    var PostalAddress: [String]
    
    var Nickname: String
  

}

//******************* End *******************************



// Mark : Response OF Sync
struct SyncContactResponse: Codable {
    let Message , Status: String?
    let StatusNo: Int?

   
}
//********** End *********************************************
