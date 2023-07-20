//
//  changePasswrdVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class changePasswrdVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var oldpassTf: ACFloatingTextfield!
    @IBOutlet weak var newpassTf: ACFloatingTextfield!
    @IBOutlet weak var confirmpassTf: ACFloatingTextfield!
    
    let aTextField = ACFloatingTextfield()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        //--<textField>--
        aTextField.delegate = self
        oldpassTf.delegate = self
        newpassTf.delegate = self
        confirmpassTf.delegate = self

    }

    //--<textfieldAnimation>--
    func getRandomColor() -> UIColor{
        return UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func slidemenuBtnCliked(_ sender: Any)
    {

            dismiss(animated: false)
    }
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(oldpassTf.text! != "" && newpassTf.text! != "" && confirmpassTf.text! != "")
        {
            changepasswordAPI()
        }
        else{
            let alert = UIAlertController(title: nil, message: "Please Enter Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    func changepasswordAPI()
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
        
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
        
        let params: [String: AnyObject] = ["Old_Password":oldpassTf.text! as AnyObject,
                                           "FBAID":FBAId as AnyObject,
                                           "New_Password":newpassTf.text! as AnyObject]
        
        let url = "change-password"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSString
            
            let Login : LoginVC! = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as? LoginVC
            Login.modalPresentationStyle = .fullScreen
            self.present(Login, animated: true, completion: nil)
            TTGSnackbar.init(message: "Password updated successfully.", duration: .long).show()
            
            
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
