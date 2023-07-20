//
//  DynamicLabelSize.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 24/09/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation
import UIKit

class DynamicLabelSize {
    
    static func height(text : String, font : UIFont, width : CGFloat) -> CGFloat{
        
        var currentHeight : CGFloat!
        
        let label = UILabel(frame: CGRect(x: 0,y :0,width: width,height: CGFloat.greatestFiniteMagnitude))
        
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        currentHeight = label.frame.height
        label.removeFromSuperview()
        
        return currentHeight
    }
}
