//
//  MenuModel.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 02/11/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation

// MARK: - MenuSection (For Header Menu)
struct MenuSection {
    var section: String
    var menuModel: [MenuModel]

    init(section: String, menuModel: [MenuModel]) {
        self.section = section
        self.menuModel = menuModel
    }
}

//MARK :- Menu Model is Inside in Menu Section
// Indicate Menu Content
struct MenuModel {

     var mId : String
    var mName : String
    var mImg : String

    init(name :String,img :String,modelId : String) {
        mName = name
        mImg = img
        mId = modelId
    }
}

