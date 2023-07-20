//
//  Extension+UIView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 02/11/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import Foundation
import UIKit

//Refrence : For Corner radius
//https://www.advancedswift.com/corners-borders-shadows/#corner-radius

// https://www.youtube.com/watch?v=Kt9XiUpmcWY      (VIP)

extension UIView {
    
    @discardableResult
    func corners(_radius: CGFloat) -> UIView{
        
        self.layer.cornerRadius = _radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func shadow(radius: CGFloat, color: UIColor, offset : CGSize, opacity : Float ) -> UIView {
        
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        return self
    }
    
}

class SCView : UIView {
    
    init(radius: CGFloat, color: UIColor, offset : CGSize, opacity : Float , cornerRadius : CGFloat){

        super.init(frame: .zero)
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity

        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
   
    func shadowCorner (radius: CGFloat, color: UIColor, offset : CGSize, opacity : Float , cornerRadius : CGFloat){
        
       
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        
      
    }
}
