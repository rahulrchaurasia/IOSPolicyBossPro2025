//
//  lyfinshdfcinputModel.swift
//  MagicFinmart
//
//  Created by Admin on 01/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class lyfinshdfcinputModel: NSObject {

    var CustomerReferenceID: Int
    var ProductPlanName: String
    var SumAssured: Int
    
    init(CustomerReferenceID: Int, ProductPlanName: String, SumAssured: Int )
    {
        self.CustomerReferenceID = CustomerReferenceID
        self.ProductPlanName = ProductPlanName
        self.SumAssured = SumAssured
        
    }

}
