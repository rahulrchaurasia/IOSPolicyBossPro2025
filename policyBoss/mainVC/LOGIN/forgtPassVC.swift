//
//  forgtPassVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class forgtPassVC: UIViewController {

    @IBOutlet weak var emailIDTf: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func removeViewBtnCliked(_ sender: Any)
    {
        let Login : LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
        self.addChild(Login)
        self.view.addSubview(Login.view)
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(emailIDTf.text! != "")
        {
            if(isValidEmail(testStr: emailIDTf.text!))
            {
                forgotPasswordAPI()
            }
            else{
                let alert = UIAlertController(title: nil, message: "Invalid Email ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: nil, message: "Enter Email ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    //  commented//
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //---<APICALL>---
    func forgotPasswordAPI()
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
        let params: [String: AnyObject] = ["EmailID":emailIDTf.text! as AnyObject]
        
        let url = "forgotPassword"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSString
            print("jsonData=",jsonData!)
            
            let Login : LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
            self.addChild(Login)
            self.view.addSubview(Login.view)
            TTGSnackbar.init(message: "Email has been sent on your registered Email address.", duration: .long).show()
            
        }, onError: { errorData in
            alertView.close()
             let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
             snackbar.show()
        }, onForceUpgrade: {errorData in})
            
      }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    
}
