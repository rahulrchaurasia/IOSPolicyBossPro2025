//
//  notipopupurlVC.swift
//  MagicFinmart
//
//  Created by Admin on 11/06/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class notipopupurlVC: UIViewController {
    
    @IBOutlet var finwebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        finwebView.loadRequest(URLRequest(url: URL(string: "http://bo.magicfinmart.com/magicTestout/index.html?test")!))
    }
    
    
    @IBAction func webcloseBtnCliked(_ sender: Any)
    {
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        present(KYDrawer, animated: true, completion: nil)
        
         self.dismissAll(animated: false)
    }
    
   
}
