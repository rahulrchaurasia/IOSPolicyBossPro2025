//
//  CallingDashboardModel.swift
//  MagicFinmart
//
//  Created by iOS Developer on 07/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

import UIKit

class CallingDashboardModel: NSObject {
    
    
    var MobileNo : String
    var EmailId: String
    var EmployeeName: String
    var Designation : String
    
  
    
    
    init( MobileNo: String,EmailId: String,EmployeeName :String, Designation: String) {
        
     
        self.MobileNo = MobileNo
        self.EmailId=EmailId
        self.EmployeeName = EmployeeName
        self.Designation = Designation
     
    }
   
    
}
