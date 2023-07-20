//
//  Extension+UserDefaults.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 30/03/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation


extension UserDefaults {
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
