//
//  MenuDb.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 02/11/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation

class MenuDb {
    
    static let shareInstance = MenuDb()
    
    var Menulist =  [MenuModel]()
    
    var menuSectionlist = [MenuSection]()
    
    
    
    func getMenuSection(isPbAttendance :String,isUidLogin :String,isenableenrolasPOSP :String, isshowmyinsurancebusiness : String ,
                        addPospVisible :String, fosUser : String) ->  [MenuSection]{
        
        // Here Section is 3 ie "MenuSection" And Row count of each Section represent by "menuModel"
        menuSectionlist.removeAll()
        menuSectionlist.append(MenuSection(section: "Home",menuModel: getHomeMenuData(_isPbAttendance: isPbAttendance, _isUidLogin: isUidLogin)))
        menuSectionlist.append(MenuSection(section: "My Account",menuModel: getMyAccountMenuData(_isenableenrolasPOSP: isenableenrolasPOSP, _isaddPospVisible: addPospVisible,_isfosUser: fosUser)))
        
        //Not in Used
//        menuSectionlist.append(MenuSection(section: "My Documents",menuModel: getMyDocumentMenuData()))
        
//        menuSectionlist.append(MenuSection(section: "My Transactions",menuModel: getMyTransactionMenuData(_isshowmyinsurancebusiness: isshowmyinsurancebusiness)))
        
        menuSectionlist.append(MenuSection(section: "My Leads",menuModel: getMyLeadsMenuData()))
        
        
        
        menuSectionlist.append(MenuSection(section: "My Utilities",menuModel: getMyUtilitiesMenuData()))
        
        menuSectionlist.append(MenuSection(section: "Legal",menuModel: getLegalMenuData()))
        return menuSectionlist
    }
    
    
    func  getHomeMenuData(_isPbAttendance isAttendenceEnable: String,
                          _isUidLogin uidLogin: String) ->  [MenuModel]
    {
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "Home" ,img: "home.png", modelId: "nav_home"))
//        if(isAttendenceEnable == "1"){
//            
//            if (uidLogin == "Y"){
//                Menulist.append(MenuModel(name: "PolicyBoss Attendance" ,img: "attendanceicon.png", modelId: "nav_attendance"))
//            }
//         
//        }
    
        Menulist.append(MenuModel(name: "Generate Login Token" ,img: "ic_business_name.png", modelId: "nav_authToken"))
        
        return Menulist
    }
    
    
    
    
    
    func  getMyAccountMenuData(_isenableenrolasPOSP : String, _isaddPospVisible : String,_isfosUser : String) ->  [MenuModel]
    {
        // Enrol as POSP : hide and show
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "My Profile" ,img: "vector_person.png" ,modelId: "nav_MyProfile"))
    
       
        if(_isenableenrolasPOSP == "1"){
            
            Menulist.append(MenuModel(name: "Enrol as POSP",img: "posp_enrollment.png" ,modelId: "nav_EnrolPosp"))
        }
        
        if(_isaddPospVisible == "1" &&  _isfosUser  != "Y") {

                
            Menulist.append(MenuModel(name: "Add Sub User",img: "posp_enrollment.png" ,modelId: "nav_AddSubUser"))
           

        }
        
        
        Menulist.append(MenuModel(name: "Change Password",img: "change_password.png" ,modelId: "nav_ChangePwd"))
        
        
//        Menulist.append(MenuModel(name: "Sms Templates" ,img: "mps.png" ,modelId: "nav_SmsTemp"))
       
        //////
       
        //todo : check key from userconstant to hide add posp
        /*
                if((userConstantEntity?.addPospVisible ?: "0").toInt() == 1 && (  prefManager?.fosUser?:"" != "Y")) {

                           menuChild.add(MenuChild("nav_addposp", "Add Sub User", R.drawable.enrol_as_posp))            // 05 changeable


                   }
         */
        /////
        
        return Menulist
    }
    
    
    func  getMyDocumentMenuData() ->  [MenuModel]
    {
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "POSP Appointment Letter" ,
                                  img: "agreemnet.png" ,
                                  modelId: "nav_PospAppointmentLetter"))
        Menulist.append(MenuModel(name: "POSP Appointment Form",
                                  img: "agreemnet.png" ,modelId: "nav_PospAppointmentForm"))
        
        return Menulist
    }
    
    
    
    
    func  getMyTransactionMenuData(_isshowmyinsurancebusiness : String) ->  [MenuModel]
    {
        // My Insurance Business : hide and show
        Menulist =  [MenuModel]()
        if(_isshowmyinsurancebusiness == "1"){
            Menulist.append(MenuModel(name: "My Insurance Business" ,
                                      img: "ic_business_name.png" ,
                                      modelId:"nav_MyInsuranceBusiness"))
        }
        
        Menulist.append(MenuModel(name: "My Transcation",img: "vector_date.png" ,modelId: "nav_MyTransaction"))
        
        return Menulist
    }
    
    func  getMyLeadsMenuData() ->  [MenuModel]
    {
        
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "Summary & Dashboard" ,img: "insurance_policy_ic.png" ,modelId: "nav_LeadDashboard"))
       
        
        return Menulist
    }
    
    func  getMyUtilitiesMenuData() ->  [MenuModel]
    {
        
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "My Utilities" ,img: "training_ic.png" ,modelId: "nav_MyUtilities"))
        
        return Menulist
    }
    
    func  getLegalMenuData() ->  [MenuModel]
    {
        
        Menulist =  [MenuModel]()
        Menulist.append(MenuModel(name: "Disclosure" ,img: "insurance_policy_ic.png" ,modelId: "nav_Disclosure"))
        Menulist.append(MenuModel(name: "Privacy Policy" ,img: "agreemnet.png" ,modelId: "nav_PrivacyPolicy"))
        
        Menulist.append(MenuModel(name: "Log-Out" ,img: "logout.png" ,modelId: "nav_Logout"))
        
        return Menulist
    }
}
