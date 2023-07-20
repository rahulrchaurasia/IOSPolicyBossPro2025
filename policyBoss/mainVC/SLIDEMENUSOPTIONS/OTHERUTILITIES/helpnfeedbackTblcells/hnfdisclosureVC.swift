//
//  hnfdisclosureVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class hnfdisclosureVC: UIViewController{

    @IBOutlet weak var disclsureView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor.darkGray
        disclsureView.layer.borderWidth=1.0;
        disclsureView.layer.borderColor=borderColor.cgColor;
        
        
       

    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
         helpnfeedback.modalPresentationStyle = .fullScreen
        present(helpnfeedback, animated: true, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        
         UserDefaults.standard.set(String(describing: "0"), forKey: "enableenrolasposp")
        
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
        
    }
    
}
