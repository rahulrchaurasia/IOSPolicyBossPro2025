//
//  AlertHealthAssureVC.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 08/07/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import UIKit
import TTGSnackbar

class AlertHealthAssureVC: UIViewController {
    
    
    typealias completionHandler = ([String: Any]) -> Void
   
    var didClickShare : completionHandler?
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblBody: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    var alertTitle = String()
     
     var alertBody = String()
     
     var alertButtonTitle = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         setupview()
        // Do any additional setup after loading the view.
    }
    
    func setupview(){
           
           lblTitle.text = alertTitle
           lblBody.text = alertBody
           btnShare.setTitle(alertButtonTitle, for: .normal)
           
          // lblBody.numberOfLines = countLines(of: lblBody, maxHeight: 180)
           
       }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func btnShareClick(_ sender: Any) {
        
        if( txtName.text!.trimmingCharacters(in: .whitespaces).isEmpty){
          
            let snackbar = TTGSnackbar.init(message: "Please Enter Name", duration: .long)
                snackbar.show()
        }
        dismiss(animated: true)
        let dict = ["name": txtName.text ?? ""]
        didClickShare?(dict)
        
    }
    
    
    
}
