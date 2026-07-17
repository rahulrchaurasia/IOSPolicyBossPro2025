//
//  UserConstantResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

struct UserConstantResponse : Decodable{
    
      let Message: String
        let Status: String
        let StatusNo: Int
        let MasterData: UserConstantMasterData
}


struct UserConstantMasterData: Decodable {
    let pospselfdesignation: String?
    let pospselfphoto: String?
    let FBAId: Int64?
    let POSPNo: Int64?
    let ManagName: String?
    let MangMobile: String?
    let MangEmail: String?
    let SuppMobile: String?
    let SuppEmail: String?
    let notificationpopupurl: String?
    let ERPID: Int64?
    let crnmobileno: Int64?
    let insurancerepositorylink: String?
    let uid: Int64?
    let iosuid: Int64?
    let TwoWheelerEnabled: String?
    let TwoWheelerUrl: String?
    let FourWheelerEnabled: String?
    let FourWheelerUrl: String?
    let RaiseTickitEnabled: String?
    let InvestmentEnabled: String?
    let IsDynamicDashEnabled: String?
    let HealthPopup: String?
    let TermPopup: String?
    let enablesynccontact: String?
    let iosversion: String?
    let androidproversion: String?
    let enablesyncprofileupdate: String?
    let androidproouathEnabled: String?
    let androidpromarketEnable: String?
    let androidpromarketuidurl: String?
    let androidpromarkefbaurl: String?
    let myaccountupdateurl: String?
    let TermPopupurl: String?
    let hdfc_code: String?
    let notif_popupurl_elite: String?
    let serviceurl: String?
    let healthurl: String?
    let healthurltemp: String?
    let messagesender: String?
    let PBByCrnSearch: String?
    let HealthDemoUrl: String?
    let CVUrl: String?
    let RaiseTickitUrl: String?
    let InvestmentUrl: String?
    let LeadDashUrl: String?
    let EliteKotakUrl: String?
    let dashboardarray: [DashboardItem]?
}

struct DashboardItem: Codable {
    let ProdId: String
    let url: String
}
