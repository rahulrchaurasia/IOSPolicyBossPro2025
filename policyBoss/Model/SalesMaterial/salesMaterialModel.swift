//
//  salesMaterialModel.swift
//  MagicFinmart
//
//  Created by Admin on 24/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class salesMaterialModel: NSObject {
    
    var productCount: Int
    var productOldCount: Int
    var product_Id: Int
    
    init(productCount: Int,Product_Id : Int)
    {
        self.productCount = productCount
        self.productOldCount = 0
        self.product_Id = Product_Id
    }

}
