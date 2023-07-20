//
//  AlertViewController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 09/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblBody: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    var alertTitle = String()
    
    var alertBody = String()
    
    var alertButtonTitle = String()
    
    
    var didClickShare: ( () -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setupview()
        
        // Position Button
      //  btnShare.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        // Set text on button
      
        
      //  btnShare.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    
    func setupview(){
        
        lblTitle.text = alertTitle
        lblBody.text = alertBody
        btnShare.setTitle(alertButtonTitle, for: .normal)
        
       // lblBody.numberOfLines = countLines(of: lblBody, maxHeight: 180)
        
    }
    
    func countLines(of label: UILabel, maxHeight: CGFloat) -> Int {
        // viewDidLayoutSubviews() in ViewController or layoutIfNeeded() in view subclass
        guard let labelText = label.text else {
            return 0
        }
        
        let rect = CGSize(width: label.bounds.width, height: maxHeight)
        let labelSize = labelText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font!], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
          dismiss(animated: true)
    }
    

    @IBAction func btnShareClick(_ sender: Any) {
        
        
          didClickShare?()
          dismiss(animated: true)
        
        ////
    }
    

}
