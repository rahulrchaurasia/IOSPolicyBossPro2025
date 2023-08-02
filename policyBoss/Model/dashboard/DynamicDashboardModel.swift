//
//  DynamicDashboardModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 10/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

class DynamicDashboardModel: NSObject {

    
    var menuid: Int
    var menuname: String
    var link: String
    var iconimage : String

    var isActive: Int
    var dashdescription : String
    var modalType: String
    var dashboard_type : String

    var ProdId: String
    var ProdName: String?
    var ProductNameFontColor: String
    var ProductDetailsFontColor: String
    var ProductBackgroundColor : String

    var IsExclusive: String
    var IsNewprdClickable: String
    var IsSharable: String
    var popupmsg : String

    var title: String
    var info: String
//
    
    
    
    init(menuid: Int, menuname: String,link: String,iconimage :String,
         isActive: Int, dashdescription: String,modalType: String,dashboard_type :String,
        ProdId: String,ProdName: String, ProductNameFontColor:String,ProductDetailsFontColor:String,ProductBackgroundColor :String,
        IsExclusive: String, IsNewprdClickable:String,IsSharable:String,popupmsg :String,
        title:String,info: String) {
        
        self.menuid = menuid
        self.menuname = menuname
        self.link=link
        self.iconimage = iconimage
        
        self.isActive = isActive
        self.dashdescription = dashdescription
        self.modalType = modalType
        self.dashboard_type=dashboard_type
        
        self.ProdId = ProdId
        self.ProdName = ProdName
        self.ProductNameFontColor = ProductNameFontColor
        self.ProductDetailsFontColor = ProductDetailsFontColor
        self.ProductBackgroundColor=ProductBackgroundColor
        
        self.IsExclusive = IsExclusive
        self.IsNewprdClickable = IsNewprdClickable
        self.IsSharable = IsSharable
        self.popupmsg=popupmsg
        
        self.title = title
        self.info = info
        
    }
    init( modalType: String,ProdId: String , menuname: String,dashdescription: String,iconimage :String)
    {
        
         self.menuid = 0
         self.iconimage = iconimage
         self.link = ""
         self.isActive = 1
     
        self.dashdescription = dashdescription
         self.modalType = modalType
        self.dashboard_type = ""
        
        self.ProdId = ProdId
        self.menuname = menuname
        
        self.dashdescription = dashdescription
        
        self.ProductNameFontColor = ""
        self.ProductDetailsFontColor = ""
        self.ProductBackgroundColor = ""
        
        self.IsExclusive = ""
        self.IsNewprdClickable = ""
        self.IsSharable = ""
        self.popupmsg = ""
        
        self.title = ""
        self.info = ""
        
    }

}
