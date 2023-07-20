//
//  FinmartStyler.swift
//  MagicFinmart
//
//  Created by Ashwini on 29/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import Foundation
import UIKit
import CustomIOSAlertView

class FinmartStyler {
    
    
    //---<customAlertView>---
    class func getLoadingAlertViewWithMessage(_ message : NSString) -> CustomIOSAlertView {
        
        let alertView: CustomIOSAlertView = CustomIOSAlertView()
        
        let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 15.0)
        let containerView: UIView = UIView(frame : CGRect(x: 0,y: 0,width: 260,height: 100))
        let attributesDictionary : NSDictionary = [ NSAttributedString.Key.font: titleFont ]
        
        let frame: CGRect = message.boundingRect(with: CGSize(width: containerView.frame.size.width - 40 ,height: 250.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: (attributesDictionary as! [NSAttributedString.Key : Any]), context: nil)
        
        //let frame: CGRect = message.boundingRect(with: CGSize(width: containerView.frame.size.width - 40 ,height: 250.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributesDictionary  as [NSAttributedString : Any]? , context: nil)
        
        let titleLabel : UILabel = UILabel(frame: CGRect(x: (containerView.frame.size.width - frame.size.width)/2, y: 20, width: frame.size.width, height: frame.size.height))
        titleLabel.font = titleFont
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = message as String
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        
        let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.gray
        let centerY : CGFloat = titleLabel.frame.size.height + titleLabel.frame.origin.y + 10 + indicator.frame.size.height/2
        let indicatorCenter: CGPoint = CGPoint(x: containerView.frame.size.width/2 , y: centerY)
        indicator.center = indicatorCenter
        indicator.startAnimating()
        
        var oldFrame : CGRect = containerView.frame
        oldFrame.size.height = indicator.frame.origin.y + indicator.frame.size.width + 20
        containerView.frame = oldFrame
        containerView.addSubview(indicator)
        containerView.addSubview(titleLabel)
        containerView.backgroundColor = UIColor.clear
        alertView.containerView = containerView
        alertView.buttonTitles = nil
        return alertView
        
    }
   
    
}

