//
//  DynamicDashboardResponse.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

struct DynamicDashboardResponse : Codable {
    
    let Message: String
    let Status: String
    let StatusNo: Int
    let MasterData: MasterDataModel
    
}

struct MasterDataModel: Codable {
    //let Menu: [String] // or actual type if defined later
    let Dashboard: [DynamicDashboardItem]?
}

struct DynamicDashboardItem: Codable {
    let infourl: String?
    let title: String?
    let popupinfo: String?
    let IsSharable: String?
    let IsNewprdClickable: String?
    
    let IsExclusive: String?
    let OrderNo: Int?
//    let ProductBackgroundColor: String?
//    let ProductDetailsFontColor: String?
//    let ProductNameFontColor: String?
    
    let ProdId: Int?
    let dashboard_type: Int?
    let type: Int?
    let description: String?
    let isActive: Int?
    
    let iconimage: String?
    let link: String?
    let menuname: String?
    let menuid: Int?
    let _id: String
}

extension DynamicDashboardItem {
    func toModel() -> DynamicDashboardModel {
        return DynamicDashboardModel(
            menuid: menuid ?? 0,
            menuname: menuname ?? "",
            link: link ?? "",
            iconimage: iconimage ?? "",
            isActive: isActive ?? 0,
            dashdescription: description ?? "",
            modalType: "INSURANCE",
            dashboard_type: "\(dashboard_type ?? 0)",
            ProdId: "\(ProdId ?? 0)",
            ProdName: menuname ?? "",
            ProductNameFontColor:  "",
            ProductDetailsFontColor:  "",
            ProductBackgroundColor:  "",
            IsExclusive: IsExclusive ?? "",
            IsNewprdClickable: IsNewprdClickable ?? "",
            IsSharable: IsSharable ?? "",
            popupmsg: popupinfo ?? "",
            title: title ?? "",
            info: infourl ?? ""
        )
    }
}
