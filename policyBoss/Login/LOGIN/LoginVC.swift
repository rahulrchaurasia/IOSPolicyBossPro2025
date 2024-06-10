//
//  LoginVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 11/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire
import KeychainAccess
import WebEngage
import SwiftUI
//import CobrowseIO

class LoginVC: UIViewController,UITextFieldDelegate {

    //  WebEngage for Analytics
    let weUser: WEGUser = WebEngage.sharedInstance().user
    
    @IBOutlet weak var loginViaMainHeight: NSLayoutConstraint!
    @IBOutlet weak var loginViaMain: UIView!
    @IBOutlet weak var imgOTP: UIImageView!
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var emailTf: ACFloatingTextfield!
   // @IBOutlet weak var passwordTf: ACFloatingTextfield!
    @IBOutlet weak var eyeBtn: UIButton!
    
    @IBOutlet weak var loginViaView: UIStackView!
    
    @IBOutlet weak var loginViaOTP: UIView!
    @IBOutlet weak var loginViaPassword: UIView!
    let aTextField = ACFloatingTextfield()
    var iconClick = true
    var emailId = ""
    var userId = ""
    var deviceID = String()
    
    let alertService = AlertService()
    
    var selectedLoginOption: LoginOption = .otp
    let imageFill = "circlefill"
    let imageEmpty = "circleempty"
    
     let vmLogin = LoginViewModel()
    
    var userNewSignUpEntity : UserNewSignUpMasterData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        //--<textField>--
        aTextField.delegate = self
        emailTf.delegate = self
        
        emailTf.textContentType = .none
        emailTf.keyboardType = .emailAddress
       // passwordTf.delegate = self
        
        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.LoginScreen)


        handleViewStyle()
        let tapOTPGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleOTPTap(_:)))

        loginViaOTP.addGestureRecognizer(tapOTPGestureRecognizer)
        
        let tapPasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePasswordTap(_:)))
        
        
       loginViaPassword.addGestureRecognizer(tapPasswordGestureRecognizer)
        
        
        hideLoginVia(false) //Hiding Password
        let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .forever )
        snackbar.show()
        
        if Connectivity.isConnectedToInternet(){
            
            getusersignup()
        }else{
            
            DispatchQueue.main.async {
            // self.showAlert(message: Connectivity.message)
                
                self.networkCheckDialog()
            }
           

        }
        
       
      
        
    }
    
    
    func hideLoginVia(_ isHide : Bool){
        
        if(isHide){
            
            // To make the view invisible by adjusting the height constraint
            loginViaMainHeight.constant = 0
            loginViaMain.isHidden = true
        }else{
            
            // To make the view invisible by adjusting the height constraint
            loginViaMainHeight.constant = 90
            loginViaMain.isHidden = false
        }
        view.layoutIfNeeded()
    }
    func getusersignup(){
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
     
        Task {
            do {
                
                let result = try await vmLogin.getusersignup()
                alertView.close()
                self.view.layoutIfNeeded()
                switch result {
                case .success(let response):
                    

                    print("API call successful:",response.MasterData[0].enable_pro_signupurl)
                    
                    userNewSignUpEntity = response.MasterData[0]
                    
                    if(userNewSignUpEntity?.enable_otp_only.uppercased() == "Y"){
                        
                        hideLoginVia(true)
                    }
                    else{
                        hideLoginVia(false)
                    }
                    
                    // For Test Retrieve user signup data if it exists from Core
//                           if let signUpEntity = Core.getSignUpEntity() {
//                               // Use the retrieved data:
//                               print("enable_otp_only", signUpEntity.enable_otp_only)
//                              
//                           } else {
//                               // No saved data found
//                               print("No user signup data found.")
//                           }
                    
                    // Update UI based on received data
                case .failure(let error):
                    print("API call failed:", error.localizedDescription)
                   
                }
            } catch  {
                print("Unexpected error:", error.localizedDescription)
                alertView.close()
                // Handle unexpected errors gracefully
            }
        }
        
    }
    @objc func handleOTPTap(_ sender: UITapGestureRecognizer) {
        
       
        
        // Identify the clicked view
          
               selectedLoginOption = .otp
             
        imgOTP.image = UIImage(named: imageFill)
        imgPassword.image = UIImage(named: imageEmpty)

              
         
       
    }
    
    @objc func handlePasswordTap(_ sender: UITapGestureRecognizer) {
        
               selectedLoginOption = .password
              
                
                imgPassword.image = UIImage(named: imageFill)
                imgOTP.image = UIImage(named: imageEmpty)
       
       
    }
    
    
    // Helper function to update selection and images
    private func updateImageSelection() {
        
        switch selectedLoginOption {
        case .otp:
            imgOTP.image = UIImage(named: "checked_round_icon")
            imgPassword.image = UIImage(named: "uncheck_round_icon")
           
        case .password:
            imgOTP.image = UIImage(named: "uncheck_round_icon")
            imgPassword.image = UIImage(named: "checked_round_icon")
          
        case .noData:
            imgOTP.image = UIImage(named: "uncheck_round_icon")
            imgPassword.image = UIImage(named: "uncheck_round_icon")
        }
    }
    
    func handleViewStyle(){
        
        loginViaView.layer.cornerRadius = loginViaView.frame.height/2
              
        loginViaView.layer.borderWidth = 1
             
        loginViaView.layer.borderColor =  UIColor.white.cgColor

    }
    func getRandomColor() -> UIColor{
        return UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if(Core.shared.isNewUser()){

        
            let storyboard = UIStoryboard(name: "Walkthrough", bundle: .main)
            
            let WelComePage = storyboard.instantiateViewController(withIdentifier: "TutorialViewController") as!  TutorialViewController
            WelComePage.modalPresentationStyle = .fullScreen
            self.present(WelComePage, animated: false)
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    @IBAction func eyeBtnCliked(_ sender: Any)
//    {
//        if(iconClick == true) {
//            passwordTf.isSecureTextEntry = false
//            let img = UIImage(named: "baseline_visibility_white_18pt_3x.png")
//            eyeBtn.setImage(img , for: .normal)
//
//        } else {
//            passwordTf.isSecureTextEntry = true
//            let img = UIImage(named: "baseline_visibility_off_white_18pt_3x.png")
//            eyeBtn.setImage(img , for: .normal)
//        }
//        
//        iconClick = !iconClick
//    }
    
    @IBAction func loginSubmitBtnCliked(_ sender: Any)
    {
     
//        if(loginValidate() == false){
//            
//            return
//        }
//        
//        
//        if((emailTf.text?.contains("@"))!){
//            self.view.endEditing(true)
//            emailId = emailTf.text!
//            loginAPI()
//        }else{
//            self.view.endEditing(true)
//            userId = emailTf.text!
//            loginAPI()
//        }
        
//        let hostingController = UIHostingController(rootView: loginView)
//
//         present(hostingController, animated: true)
//        
        //
               //alertLoginPasswordVC
        if !Connectivity.isConnectedToInternet(){
            
            self.showAlert(message: Connectivity.message)
            //return
        }else{
            
           
            //if(emailTf.text?.isEmpty){
            if( emailTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                showAlert(message: "Please Enter User ID")
                //return
            }
            else{
                
                switch selectedLoginOption {
                case .otp:
                   
                    showOTPAlert(strtitle: "Head", strbody: "Body", strsubTitle: "Subtitle")
                
                case .password:
                    showPasswordAlert(strtitle: "Head", strbody: "Body", strsubTitle: "Subtitle")
                    

                case .noData:
                 
                    print("No Data")
                }
                
            }
            
        }
        
       
       
    }

    
    func showOTPAlert( strtitle : String,strbody: String ,strsubTitle : String ){
        
        getotpLoginHorizon()
      

    }
    
    
    func getotpLoginHorizon(){
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
     
        Task {
            do {
                
                let result = try await vmLogin.getotpLoginHorizon(login_id: emailTf.text!)
                alertView.close()
                self.view.layoutIfNeeded()
                
                if(result.lowercased() == "success"){
                    print("OTP API call successful:")
                    
                    callOTPView()
                    
                }
                else{
                    print("OTP API Fail")
//                    let snackbar = TTGSnackbar.init(message: "Invalid User Id", duration: .middle )
//                    snackbar.show()
                    showAlert(message: "Invalid User Id")
                    
                }
                
                
            } catch  {
                print("Unexpected error:", error.localizedDescription)
                alertView.close()
                // Handle unexpected errors gracefully
            }
        }
        
    }
    
    func callOTPView(){
        
        let alertVC = self.alertService.alertLoginOTPVC(title: "",
                                                           body: "",
                                                           subTitle: "")
       
        alertService.completionHandler = { [weak self] closureData in

            guard let self = self else { return } // Check for nil self

           // self.emailTf.becomeFirstResponder()
            switch(closureData){
                
            case .close:
                self.dismissKeyboard()
            case .success:
                self.dismissKeyboard()
                self.loginSuccess()
            }

        }
        self.present(alertVC, animated: true)
        
    }
    
    
    
    func showPasswordAlert( strtitle : String,strbody: String ,strsubTitle : String ){
        
        let alertVC = self.alertService.alertLoginPasswordVC(userID: emailTf.text!)
       
        alertService.completionHandler = { [weak self] closureData in
            
            guard let self = self else { return } // Check for nil self
            switch(closureData){
     
            case .close:
                self.dismissKeyboard()
            case .success:
                self.dismissKeyboard()
                self.loginSuccess()
            }
           
           // self.emailTf.becomeFirstResponder()
           
           
        }
        self.present(alertVC, animated: true)
        
    }
    
    func loginSuccess(){
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
        {
           
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
            KYDrawer.modalPresentationStyle = .fullScreen
            KYDrawer.modalTransitionStyle = .coverVertical
            appDelegate?.window?.rootViewController = KYDrawer
            self.present(KYDrawer, animated: false, completion: nil)
            
            TTGSnackbar.init(message: "Login successfully.", duration: .long).show()
            
        }
        
    }
    
    func networkCheckDialog(){
        
        let alertConnectionVC = self.alertService.alertConnection()
        
        // donot confused with name of closure
        alertService.completionPospAmntHandler =  {  [weak self] in
            self?.getusersignup()
        }
        self.present(alertConnectionVC, animated: true)
        
        
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func callNativeRegister(){
        
        WebEngageAnaytics.shared.trackEvent("Sign Up Initiated")
        let ViewC : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "stbViewController") as! ViewController
        self.addChild(ViewC)
        self.view.addSubview(ViewC.view)
    }
    
    @IBAction func signupBtnCliked(_ sender: Any)
    {
        
        if Connectivity.isConnectedToInternet(){
            
            if let userNewSignUpEntity = userNewSignUpEntity {
                
                if(userNewSignUpEntity.enable_pro_signupurl.isEmpty){
                    
                    callNativeRegister()
                }else{
     
                        // Get app version and device ID
                         let appVersion = Configuration.appVersion
                        let deviceID = UIDevice.current.identifierForVendor?.uuidString
                        
                        // Build the URL string using string interpolation
                    let  signupURL = userNewSignUpEntity.enable_pro_signupurl + "&app_version=\(appVersion )&device_code=\(deviceID ?? "")&ssid=&fbaid="
                    
                    print("URL New SignUp", signupURL)
                    if let url = URL(string: signupURL) {
                        UIApplication.shared.open(url)
                    }

                }
                
            }else{
                callNativeRegister()
            }
            
            
        }
        else{
            
            DispatchQueue.main.async {
                
                let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
                snackbar.show()
                
                
            }
        }
            
            
       

       
        
    }
    @IBAction func forgetpassBtnCliked(_ sender: Any)
    {
        let forgtPass : forgtPassVC = self.storyboard?.instantiateViewController(withIdentifier: "stbforgtPassVC") as! forgtPassVC
        self.addChild(forgtPass)
        self.view.addSubview(forgtPass.view)
        
        
        
    }
    
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        
        return .portrait
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        // let dictionary = defaults.dictionaryRepresentation()
        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
        Core.shared.setNewUser()
         
    }
    func loginValidate()  -> Bool {
        
        if( emailTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Valid Email/User Id")
            return false
        }
       
//        if( passwordTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
//            alertCall(message: "Enter Password")
//            return false
//        }
        
        
        
        return true
    }
    func  saveDeviceInKeyChain1() -> String?{
       
            let deviceID =  UIDevice.current.identifierForVendor?.uuidString
            let keychain = Keychain(service: Constant.PbKeychain)
            keychain[Constant.DeviceDetail] = deviceID
            print("KeyStore Data Stored")
            
           return deviceID
      }
    
    func  getDeviceInKeyChain1() -> String{
        
        
        let keychain  = Keychain(service: Constant.PbKeychain)
        
       // keyChainData = keychain["HighScore"] ?? "No Data"
        
        print("KeyStore Data get",keychain[string : Constant.DeviceDetail] ?? "No Data")
        
        return keychain[string : Constant.DeviceDetail] ?? ""
        
    }
    func removeKeyChain1(){
        do {
            let keychain  = Keychain(service: Constant.PbKeychain)
            try keychain.remove(Constant.PbKeychain)
        } catch let error {
            print("error keychain: \(error)")
        }
    }
    
    //---<APICALL>---
    func loginAPI()
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
        
        //let deviceID = UIDevice.current.identifierForVendor?.uuidString
        if  getDeviceInKeyChain().isEmpty{
               
            self.deviceID = saveDeviceInKeyChain() ?? ""
            print("deviceID generated First time =",deviceID )
                
        }else{
            
            deviceID = getDeviceInKeyChain()
        }
          print("deviceID=",deviceID )
        let token = UserDefaults.standard.string(forKey: Constant.token)
            print("deviceToken=",token ?? "")
        let params: [String: AnyObject] = ["AppID": "" as AnyObject,
                                             "AppPASSWORD": "" as AnyObject,
                                             "AppUSERID": "" as AnyObject,
                                             "DeviceId": deviceID as AnyObject,
                                             "DeviceName": ""as AnyObject,
                                             "DeviceOS": "" as AnyObject,
                                             "EmailId": emailId as AnyObject,
                                             "FBAId": 0 as AnyObject,
                                             "IpAdd": "" as AnyObject,
                                             "LastLog": "" as AnyObject,
                                             "MobileNo": "" as AnyObject,
                                             "OldPassword": "" as AnyObject,
                                             "Password": "000" as AnyObject,
                                             "TokenId": token as AnyObject,
                                             "UserId": userId as AnyObject,
                                             "UserName": emailTf.text! as AnyObject,
                                             "UserType": "" as AnyObject,
                                             "VersionNo": "" as AnyObject]
        
        let url = "login"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            print("jsonData=",jsonData!)
            let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
            let referer_code = jsonData?.value(forKey: "referer_code") as AnyObject
            let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
            let CustID = jsonData?.value(forKey: "CustID") as AnyObject
            let EmailID = jsonData?.value(forKey: "EmailID") as AnyObject
            let MobiNumb1 = jsonData?.value(forKey: "MobiNumb1") as AnyObject
            let FullName = jsonData?.value(forKey: "FullName") as AnyObject
            let LoanId   = jsonData?.value(forKey: "LoanId") as AnyObject
            let IsUidLogin   = jsonData?.value(forKey: getSharPrefernce.uidLogin) as AnyObject
            print ("IsUidLogin",IsUidLogin)
            print ("MobiNumb1",MobiNumb1)
             print ("EmailID",EmailID)
            
            UserDefaults.standard.set(String(describing: FBAId), forKey: "FBAId")
            UserDefaults.standard.set(String(describing: referer_code), forKey: "referer_code")
            UserDefaults.standard.set(String(describing: POSPNo), forKey: "POSPNo")
            UserDefaults.standard.set(String(describing: CustID), forKey: "CustID")
            
            UserDefaults.standard.set(String(describing: MobiNumb1), forKey: "MobiNumb1")
            UserDefaults.standard.set(String(describing: EmailID), forKey: "EmailID")
            UserDefaults.standard.set(String(describing: LoanId), forKey: "LoanId")
            UserDefaults.standard.set(String(describing: FullName), forKey: "FullName")
           
//            let IsFirstLogin = jsonData?.value(forKey: "IsFirstLogin") as AnyObject
            UserDefaults.standard.set(String(describing: "1"), forKey: "IsFirstLogin")
            UserDefaults.standard.set(String(describing: IsUidLogin), forKey: getSharPrefernce.uidLogin)
            
           //--DemoUsingCoBrowserIO--
            
                /*****************  Commented **************************
                CobrowseIO.instance().license = "-6ym5GFRbN0OdQ"
                // print("Cobrowse device id:  \(CobrowseIO.instance().deviceId)")
                CobrowseIO.instance().customData = [
                    kCBIOUserIdKey: FBAId as! NSObject, //FBAID
                    kCBIOUserNameKey: FullName as! NSObject, //USerName
                    kCBIOUserEmailKey: EmailID as! NSObject, //Emailid
                    kCBIODeviceIdKey: CobrowseIO.instance().deviceId as NSObject, //
                    kCBIODeviceNameKey: "iOS" as NSObject
                ]
            
                ******************************************************/
             //--DemoUsingCoBrowserIO--
            

            
      //      self.dismiss(animated: false, completion: nil)
            
            
            if let POSPNoValue = POSPNo as? String ,!POSPNoValue.isEmpty{
              //  WebEngageAnaytics.shared.trackEvent("POSP No Generated")
                self.getFOSUserInfo()
            } else {
                let snackbar = TTGSnackbar.init(message: "Your Posp Number is not generated.!!\nNot Eligible For Login.Please Contact Admin", duration: .long)
                snackbar.show()
            }
            
          
           

            
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
    
    
    
    func getFOSUserInfo(){
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
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
            
          
            let POSPNo = UserDefaults.standard.string(forKey: "POSPNo")
            let params  :[String: AnyObject] = [
                
                "PospId": POSPNo as AnyObject
            ]
            
            
        
            let endUrl = "GetFosInfo"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            
            Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(_):
                    
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(FOSUserResponse.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                            
                            print("response= Suucess Posp Amount")
                            
                            
                            
                            let FOS_STATUS = obj.MasterData.hidesubuser
                            print("FOS_USER_AUTHENTICATIONN" , FOS_STATUS)
                            UserDefaults.standard.set(String(describing: FOS_STATUS), forKey: "FOS_USER_AUTHENTICATIONN")
                            
                            
                            
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
                            KYDrawer.modalPresentationStyle = .fullScreen
                            KYDrawer.modalTransitionStyle = .coverVertical
                            appDelegate?.window?.rootViewController = KYDrawer
                            self.present(KYDrawer, animated: false, completion: nil)
                            
                                // from here  toolbar old logic
//                            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
//                            mainTabBarController.modalTransitionStyle = .coverVertical
//                            mainTabBarController.modalPresentationStyle = .fullScreen
//
//
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                            appDelegate.window?.rootViewController = mainTabBarController
//                            appDelegate.window?.makeKeyAndVisible()

                            // till here
                            
                            
                            // below not in used
//                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                            let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//                            KYDrawer.modalPresentationStyle = .fullScreen
//                            KYDrawer.modalTransitionStyle = .coverVertical
//                            appDelegate?.window?.rootViewController = KYDrawer
//                            self.present(KYDrawer, animated: false, completion: nil)
                            
                            TTGSnackbar.init(message: "Login successfully.", duration: .long).show()
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: "Your FOS Information Not Exsist, Please Contact Admin" , duration: .long)
                            snackbar.show()
                        }
                        
                        
                    } catch let error {
                        print(error)
                        alertView.close()
                        
                        let snackbar = TTGSnackbar.init(message: "Your FOS Information Not Exsist, Please Contact Admin" , duration: .long)
                        snackbar.show()
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: error.localizedDescription, duration: .long)
                    snackbar.show()
                }
            })
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
    }
    
    func alertCall(message:String)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
  
  
    
    
}
    

enum LoginOption {
    case otp
    case password
    case noData
}


