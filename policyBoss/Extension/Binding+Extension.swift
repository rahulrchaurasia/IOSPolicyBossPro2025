//
//  Binding+Extension.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

import SwiftUI


extension Binding where Value == String {
    

    func limit(_ length : Int) -> Self {
        
        if self.wrappedValue.count > length {
            
            DispatchQueue.main.async{
                self.wrappedValue = String(self.wrappedValue.prefix(length))
                
            }
        }
        return self
        
    }
    
}
