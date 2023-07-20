//
//  pospAmntModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/06/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import Foundation

struct pospAmntModel {

    var mId : Int
    var mName : String
    var mImg : String
    

    init(name :String,img :String,modelId : Int) {
        mName = name
        mImg = img
        mId = modelId
    }
}

