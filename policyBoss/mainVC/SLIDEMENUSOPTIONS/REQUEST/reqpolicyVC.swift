//
//  reqpolicyVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import TTGSnackbar

class reqpolicyVC: UIViewController {
    
    @IBOutlet weak var reqpolicyView: UIView!
    @IBOutlet weak var crnNumberTf: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor.lightGray
        reqpolicyView.layer.cornerRadius=2.0;
        reqpolicyView.layer.borderWidth=1.0;
        reqpolicyView.layer.borderColor=borderColor.cgColor;

    }
    

    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(crnNumberTf.text! != "")
        {
            //        let text = "This is the text...."
            //        let image = UIImage(named: "Product")
            let myWebsite = NSURL(string:"pending")
            let shareAll = [myWebsite as Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        else{
            TTGSnackbar.init(message: "Enter CRN Number", duration: .long).show()
        }
        
    }
    
    
   
    
    
}
