//
//  AlertLoginTokenVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/02/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit

class AlertLoginTokenVC: UIViewController {

    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewLoginToken: SCView!
    @IBOutlet weak var lblLoginToken: UILabel!
    var alertLoginToken = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblLoginToken.text = alertLoginToken
        
        viewLoginToken.layer.cornerRadius = 8
        viewLoginToken.clipsToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))


        self.viewTitle.addGestureRecognizer(gesture)

    }
    

   
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {

        dismiss(animated: true)
        


     }



}
