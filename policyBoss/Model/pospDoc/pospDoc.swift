//
//  pospDoc.swift
//  MagicFinmart
//
//  Created by iOS Developer on 15/06/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

class pospDoc : NSObject {
    

    var DocType: Int
    var FileName: String
    var DocName: String
    
    init(DocType: Int,FileName : String,DocName : String)
    {
        self.DocType = DocType
        self.FileName = FileName
        self.DocName = DocName
    }
    
}
