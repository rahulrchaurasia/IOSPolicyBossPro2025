//
//  UserConstDashboardModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 16/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

import UIKit

class UserConstDashboarddModel: NSObject {
    
    
    var ProdId: String
    var url: String
   
    
    init(ProdId: String,url :String)
    {
        self.ProdId = ProdId
        self.url = url
    }
}


