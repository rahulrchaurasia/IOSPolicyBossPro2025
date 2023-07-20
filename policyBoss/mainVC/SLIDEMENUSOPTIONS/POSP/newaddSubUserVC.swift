//
//  newaddSubUserVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 16/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class newaddSubUserVC: UIViewController,UITextFieldDelegate,SelectedDateDelegate {
  

    @IBOutlet weak var addsubUserView: UIView!
    @IBOutlet weak var ufirstNameTf: ACFloatingTextfield!
    @IBOutlet weak var ulastNameTf: ACFloatingTextfield!
    @IBOutlet weak var udobTf: ACFloatingTextfield!
    @IBOutlet weak var umaleBtn: UIButton!
    @IBOutlet weak var ufemaleBtn: UIButton!
    @IBOutlet weak var umobNoTf: ACFloatingTextfield!
    @IBOutlet weak var umobNo2Tf: ACFloatingTextfield!
    @IBOutlet weak var uemailTf: ACFloatingTextfield!
    @IBOutlet weak var upincodeTf: ACFloatingTextfield!
    @IBOutlet weak var ucityTf: ACFloatingTextfield!
    @IBOutlet weak var ustateTf: ACFloatingTextfield!
    
    var Gender = "M"
    var Password = ""
    var StateID = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        let borderColor = UIColor.lightGray
        addsubUserView.layer.cornerRadius=5.0;
        addsubUserView.layer.borderWidth=1.0;
        addsubUserView.layer.shadowColor=borderColor.cgColor;
        addsubUserView.layer.borderColor=borderColor.cgColor;
        
        //--<border>--
        btnColorChangeBlue(Btn: umaleBtn)
        btnColorChangeGray(Btn: ufemaleBtn)
        
        //--<textField>--
         ufirstNameTf.delegate = self
         ulastNameTf.delegate = self
         udobTf.delegate = self
         umobNoTf.delegate = self
         umobNo2Tf.delegate = self
         uemailTf.delegate = self
         upincodeTf.delegate = self
         ucityTf.delegate = self
         ustateTf.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func getintData(indata: Int) {
        
    }
    
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        
        self.dismissAll(animated: false)
        
    }
    
    @IBAction func udobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        Password = currDate.replacingOccurrences(of: "-", with: "")
        print("password",Password)
        udobTf.text = currDate
        udobTf.textColor = UIColor.black
        

    }
    
   
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == umobNoTf  ||  textField == umobNo2Tf)
        {
            if((textField.text?.count)! <= 9)
            {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = NSCharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
            }
            else{
                //            let characterCountLimit = 30
                // We need to figure out how many characters would be in the string after the change happens
                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace = range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace
                
                return newLength <= (textField.text?.count)!
            }
        }
        else if(textField == upincodeTf)
        {

            
            var blnStatus : Bool = false
            
            // get the current text, or use an empty string if that failed
            let currentText = textField.text ?? ""
            
            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }
            
        
            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            ////////////////////////////
        
            
            if(updatedText.count <= 6 && textField == upincodeTf)
            {
                
                 let allowedCharacters = CharacterSet.decimalDigits
                 let characterSet = NSCharacterSet(charactersIn: string)
                
                 blnStatus = allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                
                if(updatedText.count == 6)
                {
                    if(blnStatus){
                        print("pincodeTf.text?=",updatedText)
                        getCityStateAPI(pinCode:  updatedText)
                        
                        
                    }
                   
                }else{
                    ucityTf.text = ""
                    ustateTf.text = ""
                }
                
                return blnStatus
                

            }else{
                 return false
            }
                
        }
        else{
            if((textField.text?.count)! <= 50)
            {
//                var allowedCharacters = CharacterSet.letters
//                allowedCharacters.formUnion(CharacterSet.whitespaces)
//                let characterSet = NSCharacterSet(charactersIn: string)
//                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                
                return true
            }
            else{
                //            let characterCountLimit = 30
                // We need to figure out how many characters would be in the string after the change happens
                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace = range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace
                
                return newLength <= (textField.text?.count)!
            }
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
//        if (textField == self.ucityTf || textField == self.ustateTf)
//        {
//            getCityStateAPI()
//        }
        
    }
    
    @IBAction func umaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: umaleBtn)
        btnColorChangeGray(Btn: ufemaleBtn)
        
        self.Gender = "M"
        
    }
    
    @IBAction func ufemaleBtnCliked(_ sender: Any)
    {
        btnColorChangeBlue(Btn: ufemaleBtn)
        btnColorChangeGray(Btn: umaleBtn)
        
        self.Gender = "F"
    }
    
    func addUserValidate()  -> Bool {
        
        if( ufirstNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            TTGSnackbar.init(message: "Enter First Name", duration: .long).show()
            return false
        }
        if( ulastNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            TTGSnackbar.init(message: "Enter Last Name", duration: .long).show()
            return false
        }
        if( udobTf.text!.isEmpty){
            TTGSnackbar.init(message: "Enter Dob", duration: .long).show()
            return false
        }
        if( umobNoTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            TTGSnackbar.init(message: "Enter Mobile No", duration: .long).show()
            return false
        }
        
        if(!isValidEmail(testStr: uemailTf.text!))
        {
            TTGSnackbar.init(message: "Invalid Email Id", duration: .long).show()
            return false
        }
        
        
        if( upincodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            TTGSnackbar.init(message: "Enter Pincode", duration: .long).show()
            return false
        }
        if( upincodeTf.text?.count != 6){
            
            TTGSnackbar.init(message: "Enter Valid Pincode", duration: .long).show()
            return false
        }
        
        else if(ucityTf.text! == ""){
            TTGSnackbar.init(message: "Enter City", duration: .long).show()
            return false
        }
        else if(ustateTf.text! == ""){
            TTGSnackbar.init(message: "Enter State", duration: .long).show()
            return false
        }
        
        return true
    }
    
    @IBAction func useraddBtnCliked(_ sender: Any)
    {
        
        
        if(addUserValidate()){
            
            addChildPospAPI()
        }
        
//        if(ufirstNameTf.text! != "" && ulastNameTf.text! != "" && udobTf.text! != "" && umobNoTf.text! != "" && uemailTf.text! != "" && upincodeTf.text! != "" && ucityTf.text! != "" && ustateTf.text! != "")
//        {
//            if(isValidEmail(testStr: uemailTf.text!))
//            {
//                addChildPospAPI()
//            }
//            else{
//               TTGSnackbar.init(message: "Please enter valid Email ID", duration: .long).show()
//            }
//        }
//        else if(ufirstNameTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter First Name", duration: .long).show()
//        }
//        else if(ulastNameTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter Last Name", duration: .long).show()
//        }
//        else if(udobTf.text! == ""){
//            TTGSnackbar.init(message: "Please select date of birth", duration: .long).show()
//        }
//        else if(umobNoTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter Mobile No", duration: .long).show()
//        }
//        else if(uemailTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter Email ID", duration: .long).show()
//        }
//        else if(upincodeTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter Pincode", duration: .long).show()
//        }
//        else if(ucityTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter City", duration: .long).show()
//        }
//        else if(ustateTf.text! == ""){
//            TTGSnackbar.init(message: "Please enter State", duration: .long).show()
//        }
        
    }
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //---<APICALL>---
    func getCityStateAPI(pinCode : String)
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
            let params: [String: AnyObject] = ["PinCode":pinCode as AnyObject]
            
            let url = "get-city-and-state"
            
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let state_name = jsonData?.value(forKey: "state_name") as? String
            let cityname = jsonData?.value(forKey: "cityname") as? String
            
            self.StateID = jsonData?.value(forKey: "stateid") as? String ?? ""
            self.ustateTf.text! = state_name!
            self.ucityTf.text! = cityname!
            
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
    
    func addChildPospAPI()
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
        
        let params: [String: AnyObject] = ["Address_1": "" as AnyObject,
                                            "Address_2": "" as AnyObject,
                                            "Address_3": "" as AnyObject,
                                            "Bonds": "0" as AnyObject,
                                            "Bonds_Comp": "" as AnyObject,
                                            "BrokID": 0 as AnyObject,
                                            "City": ucityTf.text! as AnyObject,
                                            "CustID": 0 as AnyObject,
                                            "DOB": udobTf.text! as AnyObject,
                                            "DisplayDesignation": "" as AnyObject,
                                            "DisplayEmail": "" as AnyObject,
                                            "DisplayPhoneNo": "" as AnyObject,
                                            "EmailId": uemailTf.text! as AnyObject,
                                            "FBAID": 0 as AnyObject,
                                            "FBALiveID": 0 as AnyObject,
                                            "FBAPan": "" as AnyObject,
                                            "FBAStat": "" as AnyObject,
                                            "FBA_Designation": "" as AnyObject,
                                            "FirstName": ufirstNameTf.text! as AnyObject,
                                            "GIC_Comp": "" as AnyObject,
                                            "GIC_Comp_ID": "" as AnyObject,
                                            "GSTNumb": "" as AnyObject,
                                           
                                            "Gender": Gender as AnyObject,
                                            "Health_Comp": "" as AnyObject,
                                            "Health_Comp_ID": "" as AnyObject,
                                            "IsFOC": "" as AnyObject,
                                            "IsGic": "" as AnyObject,
                                            "IsHealth": "" as AnyObject,
                                            "IsLic": "" as AnyObject,
                                            "LIC_Comp": "" as AnyObject,
                                            "LIC_Comp_ID": "" as AnyObject,
                                           
                                            "LastName": ulastNameTf.text! as AnyObject,
                                            "Link": "" as AnyObject,
                                            "Loan_Aadhaar": "" as AnyObject,
                                            "Loan_Account_Type": "" as AnyObject,
                                            "Loan_BankAcNo": "" as AnyObject,
                                            "Loan_BankBranch": "" as AnyObject,
                                            "Loan_BankCity": "" as AnyObject,
                                            "Loan_BankID": 0 as AnyObject,
                                            "Loan_BankName": "" as AnyObject,
                                           
                                            "Loan_FirstName": "" as AnyObject,
                                            "Loan_IFSC": "" as AnyObject,
                                            "Loan_LastName": "" as AnyObject,
                                            "Loan_MICR": "" as AnyObject,
                                            "Loan_PAN": "" as AnyObject,
                                            "MF": "" as AnyObject,
                                            "MF_Comp": "" as AnyObject,
                                            "Mobile_1": umobNoTf.text! as AnyObject,
                                            "Mobile_2": umobNo2Tf.text! as AnyObject,
                                            "Other_Aadhaar": "" as AnyObject,
                                            "Other_Account_Type": "" as AnyObject,
                                            "Other_BankAcNo": "" as AnyObject,
                                            "Other_BankBranch": "" as AnyObject,
                                            "Other_BankCity": "" as AnyObject,
                                            "Other_BankID": 0 as AnyObject,
                                            "Other_BankName": "" as AnyObject,
                                            "Other_FirstName": "" as AnyObject,
                                            "Other_IFSC": "" as AnyObject,
                                            "Other_LastName": "" as AnyObject,
                                            "Other_MICR": "" as AnyObject,
                                            "Other_PAN": "" as AnyObject,
                                           
                                            "POSPID": 0 as AnyObject,
                                            "PinCode": upincodeTf.text! as AnyObject,
                                            "Posp_Aadhaar": "" as AnyObject,
                                            "Posp_Account_Type": "" as AnyObject,
                                            "Posp_Address1": "" as AnyObject,
                                            "Posp_Address2": "" as AnyObject,
                                            "Posp_Address3": "" as AnyObject,
                                            "Posp_BankAcNo": "" as AnyObject,
                                            "Posp_BankBranch": "" as AnyObject,
                                            "Posp_BankCity": "" as AnyObject,
                                            "Posp_BankID": 0 as AnyObject,
                                            "Posp_BankName": "" as AnyObject,
                                           
                                            "Posp_ChanPartCode": "" as AnyObject,
                                            "Posp_City": "" as AnyObject,
                                            "Posp_DOB": "" as AnyObject,
                                            "Posp_Email": ""as AnyObject,
                                            "Posp_FirstName": "" as AnyObject,
                                            "Posp_Gender": "" as AnyObject,
                                            "Posp_IFSC": "" as AnyObject,
                                            "Posp_LastName": "" as AnyObject,
                                            "Posp_MICR": "" as AnyObject,
                                            "Posp_Mobile1": "" as AnyObject,
                                            "Posp_Mobile2": "" as AnyObject,
                                            "Posp_PAN": "" as AnyObject,
                                            "Posp_PinCode": "" as AnyObject,
                                            "Posp_ServiceTaxNo": "" as AnyObject,
                                            "Posp_StatID": "" as AnyObject,
                                           
                                            "Postal": "" as AnyObject,
                                            "Postal_Comp": "" as AnyObject,
                                            "SMID": 0 as AnyObject,
                                            "SM_Name": "" as AnyObject,
                                            "StatActi": "" as AnyObject,
                                            "State": ustateTf.text! as AnyObject,
                                            "StateID": StateID as AnyObject,
                                            "Stock": "" as AnyObject,
                                            "Stock_Comp": "" as AnyObject,
                                            "Type": "" as AnyObject,
                                            "password": Password as AnyObject,   
                                            "referedby_code": "" as AnyObject,
                                            "VersionCode": Configuration.appVersion as AnyObject,
                                            "AppSource": "" as AnyObject,
                                            "ParentId": FBAId as AnyObject]
        
        let url = "AddChildPosp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let StatusNo = jsonData?.value(forKey: "SavedStatus") as? Int
            
            let Message = jsonData?.value(forKey: "Message") as? Int
            if(StatusNo == 0){
                TTGSnackbar.init(message: "FBA registered successfully.", duration: .long).show()
                let addSubUser : addSubUserVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddSubUserVC") as! addSubUserVC
                addSubUser.modalPresentationStyle = .fullScreen
                self.present(addSubUser, animated:false, completion: nil)
                
              //  self.showToast(controller: addSubUser.self, message: Message!, seconds: 4)
            }
            else{
                TTGSnackbar.init(message: "Error", duration: .long).show()
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
    
    
    //----<buttonColor>----
    func btnColorChangeBlue(Btn:UIButton)
    {
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=0.5;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
}
