//
//  AlertConnectionVC.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 25/09/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import UIKit

class AlertConnectionVC: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    // Closure for Dismiss
    var completionHandler: (() -> Void)?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnRetry: UIButton!
    var alertMessage = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainView.layer.cornerRadius  = 25
        mainView.clipsToBounds = true
           btnRetry.layer.cornerRadius = btnRetry.frame.height / 2 // Consistent curve
           btnRetry.clipsToBounds = true // Hide overflow
        
        self.stopLoading()

    }
    
    func startLoading() {
            indicator.isHidden = false // Ensure visibility
            indicator.startAnimating()
        }

        func stopLoading() {
            indicator.stopAnimating()
            indicator.isHidden = true // Hide if desired
        }
   
    @IBAction func btnRetryClick(_ sender: Any) {
        
        if Connectivity.isConnectedToInternet(){
            
            stopLoading()
            self.dismiss(animated: true)
            
             completionHandler?()
        }else{
            self.startLoading()
            // Simulate some work
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.stopLoading()
            }
        }
       
    }
    
    
}
