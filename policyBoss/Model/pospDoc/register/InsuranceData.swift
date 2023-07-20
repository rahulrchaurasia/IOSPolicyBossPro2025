//
//  InsuranceData.swift
//  MagicFinmart
//
//  Created by iOS Developer on 09/06/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

class InsuranceData: NSObject {
    
    
    var InsuID: Int
   var InsuShorName: String
    var IsSelected: Bool
   
  
    //
    
    
    
    init(InsuID: Int, InsuShorName: String) {
        
        self.InsuID = InsuID
    
        self.InsuShorName=InsuShorName
      
        self.IsSelected = false
        
    }
}
