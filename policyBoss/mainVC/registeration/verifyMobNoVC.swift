//
//  verifyMobNoVC.swift
//  MagicFinmart
//
//  Created by Admin on 05/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class verifyMobNoVC: UIViewController {

    @IBOutlet weak var verifymobTextView: UITextView!
    @IBOutlet weak var verifyOtpTf: ACFloatingTextfield!
    var mobText = ""
    var mobNo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("mobText=",mobText)
        verifymobTextView.text! = mobText

    }
    
    @IBAction func resendBtnCliked(_ sender: Any)
    {
        
    }
    @IBAction func verifyMobBtnCliked(_ sender: Any)
    {
//        retriveOTPAPI()
    }
    
    //---<APICALL>---
    func retriveOTPAPI()
    {
        if Connectivity.isConnectedToInternet()
        {
            
        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
        if let parentView = self.navigationController?.view
        {
            alertView.parentView = parentView
        }
        else
        {
            alertView.parentView = self.view
        }
        alertView.show()
        let params: [String: AnyObject] = ["MobileNo": mobNo as AnyObject,
                                           "MobileOTP": verifyOtpTf.text! as AnyObject]
        
        let url = "retrive-otp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            let Message = jsonData?.value(forKey: "Message") as? String
            if(Message == "Mobile Number and EmailId OTP verified successfully!")
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
            
            //            if let sellerid = jsonData?.value(forKey: "sellerid") as? String{
            //                UserDefaults.standard.set(sellerid, forKey: BeldaraUserDefault.SELLER_ID)
            //            }
            //            let snackbar = TTGSnackbar.init(message: "OTP has been send", duration: .long)
            //snackbar.show()
        }, onError: { errorData in
            alertView.close()
            // let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            // snackbar.show()
        }, onForceUpgrade: {errorData in})
        
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
    }
    
}
