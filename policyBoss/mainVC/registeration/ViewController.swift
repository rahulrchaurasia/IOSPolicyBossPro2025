//
//  ViewController.swift
//  MagicFinmart
//
//  Created by Ashwini on 10/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire
import WebEngage

class ViewController: UIViewController,UITextFieldDelegate,SelectedDateDelegate,getPickerDataDelegate,selectedDataDelegate , UITableViewDelegate,UITableViewDataSource  {
    
    
    @IBOutlet weak var pospAmntTableView: UITableView!
    
    let aTextField = ACFloatingTextfield()

    @IBOutlet var ViewControllerBckView: UIView!
    @IBOutlet weak var verifymobOTPView: UIView!
    @IBOutlet weak var verifymobOTPViewHeight: NSLayoutConstraint!//250
    @IBOutlet weak var perArrowImg: UIImageView!
    @IBOutlet weak var profArrowImg: UIImageView!
    @IBOutlet weak var persnlBtn: UIButton!
    @IBOutlet weak var profBtn: UIButton!
    @IBOutlet weak var persnlTfView: UIView!
    @IBOutlet weak var persnlTfViewHeight: NSLayoutConstraint!//660
    @IBOutlet weak var profTfView: UIView!
    @IBOutlet weak var profTfViewHeight: NSLayoutConstraint!//380
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    //textfield
    @IBOutlet weak var firstNameTf: ACFloatingTextfield!
    @IBOutlet weak var lastNameTf: ACFloatingTextfield!
    @IBOutlet weak var dobTf: ACFloatingTextfield!
    @IBOutlet weak var mob1Tf: ACFloatingTextfield!
    @IBOutlet weak var mob2Tf: ACFloatingTextfield!
    @IBOutlet weak var emailTf: ACFloatingTextfield!
    @IBOutlet weak var confEmailTf: ACFloatingTextfield!
    @IBOutlet weak var pincodeTf: ACFloatingTextfield!
    @IBOutlet weak var cityTf: ACFloatingTextfield!
    @IBOutlet weak var stateTf: ACFloatingTextfield!
    @IBOutlet weak var referrCodeTf: ACFloatingTextfield!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var lifeinsuranceCheckbox: UIImageView!
    @IBOutlet weak var gernalinsuranceCheckbox: UIImageView!
    @IBOutlet weak var healthinsuranceCheckbox: UIImageView!
    @IBOutlet weak var mutualfundCheckbox: UIImageView!
    @IBOutlet weak var stockinsuranceCheckbox: UIImageView!
    @IBOutlet weak var postalinsuranceCheckbox: UIImageView!
    @IBOutlet weak var bondsinsuranceCheckbox: UIImageView!
    @IBOutlet weak var lifeinsuranceLbl: UILabel!
    @IBOutlet weak var gernlinsuranceLbl: UILabel!
    @IBOutlet weak var healthinsuranceLbl: UILabel!
    @IBOutlet weak var lifeinsuranceBtn: UIButton!
    @IBOutlet weak var gernlinsuranceBtn: UIButton!
    @IBOutlet weak var healthinsuranceBtn: UIButton!
    @IBOutlet weak var mutualfundBtn: UIButton!
    @IBOutlet weak var stockBtn: UIButton!
    @IBOutlet weak var postalBtn: UIButton!
    @IBOutlet weak var bondBtn: UIButton!
    @IBOutlet weak var verifymobTextView: UITextView!
    @IBOutlet weak var verifyOtpTf: ACFloatingTextfield!
    @IBOutlet weak var fieldSaleView: UIView!
    @IBOutlet weak var fieldSaleViewHeight: NSLayoutConstraint!//60
    @IBOutlet weak var fieldSaleLbl: UILabel!
    
    
   
    @IBOutlet weak var btnVerify: UIButton!
    
    @IBOutlet weak var btnResend: UIButton!
    
    
    var lifeinsuranceSelected = "0"
    var gernalinsuranceSelected = "0"
    var healthinsuranceSelected = "0"
    var mutualFundSelected = "0"
    var stocksSelected = "0"
    var postalSelected = "0"
    var bondsSelected = "0"
    var Gender = "M"
    var profViewOpen = "No"
    
    var sourceNameArray = [String]()
    var sourceIdArray = [String]()
    var EmployeeNameArray = [String]()
    var EmployeeIdArray = [String]()
    var sourceId = "1"
    var EmployeeId = ""
    var fromScreen = ""
    var multipleSelectedData = String()
    
    var lifeSelectedData = ""
    var genSelectedData = ""
    var healthSelectedData = ""
    
    var multiselctionTV : multiselctionTVC! = multiselctionTVC()
    
    var PinCode = ""
    var ReferrerCode = ""
    var Password = ""
    var StateID = ""
    var POSP_AMOUNT = ""
    var isVerifyMobileOTP = false
    
    var insuranceCompObj: InsuranceCompModel? = nil
     var insuranceLifeData = [InsuranceData]()
    
    var pospAmntObj: PospAmountModel? = nil
    
    var pospAmntList =  [MasterDataPospAmnt]()
    
    let alertService = AlertService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.RegisterScreen)

        self.hideKeyboardWhenTappedAround()
        //---<hideViews>--
        
        ViewControllerBckView.isHidden = true
        verifymobOTPView.isHidden = true
        verifymobOTPViewHeight.constant = 0
        persnlTfView.isHidden = true
        persnlTfViewHeight.constant = 0
        profTfView.isHidden = true
        profTfViewHeight.constant = 0
        fieldSaleView.isHidden = true
        fieldSaleViewHeight.constant = 0
        
        //--<border>--
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor=borderColr.cgColor;
        let borderColor = UIColor.gray
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor=borderColor.cgColor;
        self.maleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)

        
       
        

        
      
        // Editable False City and State
        
        cityTf.isEnabled = false
        stateTf.isEnabled = false
        
        //--<textField>--
        aTextField.delegate = self
        multiselctionTV.delegateData = self
        
        //// added //////
        firstNameTf.delegate = self
        lastNameTf.delegate = self
        dobTf.delegate = self
        mob1Tf.delegate = self
        mob2Tf.delegate = self
        emailTf.delegate = self
        confEmailTf.delegate = self
        pincodeTf.delegate = self
        cityTf.delegate = self
        stateTf.delegate = self
        referrCodeTf.delegate = self
        verifyOtpTf.delegate = self
        
        ////  ended ////////
    
        getregistrationsourceAPI()
        getInsuranceCompany()
        getPospAmount()
        
       
        pospAmntTableView.delegate = self
        pospAmntTableView.dataSource = self
        
        
       
    }
    
    func setUserInfoToWebEngAnalytic(blnLogin :Bool = false) {
        
        if(blnLogin){
           
            WebEngageAnaytics.shared.getWEGUser().login(emailTf.text!)
        }
 
        WebEngageAnaytics.shared.getWEGUser().setFirstName(firstNameTf.text!)
        WebEngageAnaytics.shared.getWEGUser().setLastName(lastNameTf.text! )
        
        if(Gender == "M"){
         
            WebEngageAnaytics.shared.getWEGUser().setGender("MALE")
        }else{
            WebEngageAnaytics.shared.getWEGUser().setGender("FEMALE")
        }
        WebEngageAnaytics.shared.getWEGUser().setEmail(emailTf.text!)
        
        
        WebEngageAnaytics.shared.getWEGUser().setPhone(mob1Tf.text!)
        
        let dobFormatted  = dobTf.text!.toDateString(inputDateFormat: "dd-MM-yyyy", ouputDateFormat:"yyyy-MM-dd") ?? ""
        WebEngageAnaytics.shared.getWEGUser().setBirthDateString(dobFormatted )
        
        WebEngageAnaytics.shared.getWEGUser().setPhone(sourceLbl.text!)
        WebEngageAnaytics.shared.getWEGUser().setPhone(fieldSaleLbl.text!)
        
        
        if(sourceLbl.text! != "Select"){
            WebEngageAnaytics.shared.getWEGUser().setAttribute("Source", withStringValue: sourceLbl.text! )
        }else{
            WebEngageAnaytics.shared.getWEGUser().setAttribute("Source", withStringValue: "" )
        }
       
        if(sourceLbl.text! != "Select"){
            
            WebEngageAnaytics.shared.getWEGUser().setAttribute("Field Sale", withStringValue: fieldSaleLbl.text! )
        }else{
            WebEngageAnaytics.shared.getWEGUser().setAttribute("Field Sale", withStringValue: "" )
        }
            
        
       
        
        WebEngageAnaytics.shared.getWEGUser().setAttribute("Referrer Code", withStringValue: referrCodeTf.text! )
        
        WebEngageAnaytics.shared.getWEGUser().setOptInStatusFor(WEGEngagementChannel.whatsapp, status: true)
        
        debugPrint("Analytic dob", dobFormatted)
        debugPrint("Analytic Source", sourceLbl.text!)
        debugPrint("Analytic Field Sale", fieldSaleLbl.text!)
        debugPrint("Analytic Refer Code", referrCodeTf.text!)
       
    }
   
    //05 temp
    func getselectedData(insuranceCompObj: InsuranceCompModel? ,selectedData: [String], selectedID: [String], stringId : String) {
        print("selected Joined=",selectedData)
        print("stringId=",stringId)
        self.insuranceCompObj = insuranceCompObj
        
        if(stringId == "lyf")
        {
            lifeinsuranceLbl.text = selectedData.joined(separator: ",")
           
            lifeSelectedData = selectedID.joined(separator: ",")
        }
        else if(stringId == "gen")
        {
            gernlinsuranceLbl.text = selectedData.joined(separator: ",")
            genSelectedData = selectedID.joined(separator: ",")
        }
        else if(stringId == "health")
        {
            healthinsuranceLbl.text = selectedData.joined(separator: ",")
            healthSelectedData = selectedID.joined(separator: ",")
        }
    }
    
    @IBAction func regiBackBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
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
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == mob1Tf  ||  textField == mob2Tf)
        {
            if((textField.text?.count)! <= 9)
            {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = NSCharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
            }
            else{
                
                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace = range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace
                
                return newLength <= (textField.text?.count)!
            }
        }
        
       else if(textField == referrCodeTf  )
        {
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            if(updatedText.count <= 6 )
            {
                
                if(updatedText.count == 6)
                {
                    print("referrCodeTf.text?=",updatedText)
                   
                    validaterefercodeAPI(refferCode: updatedText)
                
                }
                return true
            }
            else{
                
                return false
            }
        }
        
        else if(textField == pincodeTf)
         {
            ////////////////////
            
            var blnStatus : Bool = false
            
            // get the current text, or use an empty string if that failed
            let currentText = textField.text ?? ""
            
            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }
            
        
            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            ////////////////////////////
        
            
            if(updatedText.count <= 6 && textField == pincodeTf)
            {
                
                 let allowedCharacters = CharacterSet.decimalDigits
                 let characterSet = NSCharacterSet(charactersIn: string)
                
                 blnStatus = allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                
                if(updatedText.count == 6)
                {
                    if(blnStatus){
                        print("pincodeTf.text?=",updatedText)
                        getCityStateAPI(pinCode: updatedText)
                    }
                   
                }else{
                    cityTf.text = ""
                    stateTf.text = ""
                }
                
                return blnStatus
                

            }else{
                 return false
            }
                
 
        }
        else{
            if((textField.text?.count)! <= 50)
            {
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
        
       
//        if (textField == self.cityTf || textField == self.stateTf)
//        {
//            getCityStateAPI()
//        }
//        if(textField == self.referrCodeTf)
//        {
//            validaterefercodeAPI()
//        }
        
        //            else if(pincodeTf.text!.count == 6)
        //            {
        //                print("pincodeTf.text?=",pincodeTf.text!)
        ////                pincodeTf.text? = textField.text!
        //                getCityStateAPI()
        //
        //                return false
        //            }
        //            else if(referrCodeTf.text!.count == 6)
        //            {
        //                print("referrCodeTf.text?=",referrCodeTf.text!)
        //                //                pincodeTf.text? = textField.text!
        //                validaterefercodeAPI()
        //
        //                return false
        //            }
    }
    
    //---<ButtonCliked>---
    @IBAction func persnlBtnCliked(_ sender: Any)
    {
        if(persnlTfView.isHidden)
        {
            if(self.sourceLbl.text == "Select"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
              //  persnlTfViewHeight.constant = 600
                persnlTfViewHeight.constant = 800
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
               // persnlTfViewHeight.constant = 660  //temp 05
                
                persnlTfViewHeight.constant = 860
            }
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profArrowImg.image = UIImage(named: "down_arrow.png")
        }
        else{
            persnlTfView.isHidden = true
            persnlTfViewHeight.constant = 0
            perArrowImg.image = UIImage(named: "down_arrow.png")
        }
    }
   
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
   
    @IBAction func dobBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let DatePicker : DatePickerVC = storyboard?.instantiateViewController(withIdentifier: "stbDatePickerVC") as! DatePickerVC
        DatePicker.fromScreen = "fromRegisterPage"
        self.addChild(DatePicker)
        self.view.addSubview(DatePicker.view)
        DatePicker.dateDelegate = self
    }
    
    func getDateData(currDate: String, fromScreen: String) {
        print(currDate)
        Password = currDate.replacingOccurrences(of: "-", with: "")
        print("password",Password)
        dobTf.text = currDate
        dobTf.textColor = UIColor.black
    }
    func getintData(indata: Int) {
        
    }
        
    @IBAction func maleBtnCliked(_ sender: Any)
    {
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor=borderColor.cgColor;
        self.maleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
        let borderColorr = UIColor.gray
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor = borderColorr.cgColor
        self.femaleBtn.titleLabel?.textColor = UIColor.darkGray
        self.Gender = "M"
    }
    @IBAction func femaleBtnCliked(_ sender: Any)
    {
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        self.femaleBtn.layer.cornerRadius=2.0;
        self.femaleBtn.layer.borderWidth=2.0;
        self.femaleBtn.layer.borderColor=borderColor.cgColor;
        self.femaleBtn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
        let borderColorr = UIColor.gray
        self.maleBtn.layer.cornerRadius=2.0;
        self.maleBtn.layer.borderWidth=2.0;
        self.maleBtn.layer.borderColor = borderColorr.cgColor
        self.maleBtn.titleLabel?.textColor = UIColor.darkGray
        self.Gender = "F"
    }
    
    @IBAction func sourceLblBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "source"
        Picker.pickerData = ["Select"]+sourceNameArray.filter { ($0) != "-- SELECT SOURCE --" }
      //  Picker.pickerData = sourceNameArray
        Picker.pickerIdData = [""]+sourceIdArray.filter { ($0) != "1" }
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    @IBAction func fieldSaleBtnCliked(_ sender: Any)
    {
        if(self.EmployeeIdArray.count > 0 ){
            
            self.view.endEditing(true)
            let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
            Picker.fromScreen = "fieldSale"
            Picker.pickerData = ["Select"]+EmployeeNameArray
         //   Picker.pickerData = EmployeeNameArray
            Picker.pickerIdData = [""]+EmployeeIdArray
            self.addChild(Picker)
            self.view.addSubview(Picker.view)
            Picker.pickerdelegate = self
            }
      
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
    {
        case "source":
            self.sourceLbl.text = pickerSelectedData
            self.sourceId = pickerSelectedId
            
              print("AA sourceId",pickerSelectedId)
             print("AA sourceLbl",pickerSelectedData)
            
            if(self.sourceLbl.text == "Select"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 800
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
               // persnlTfViewHeight.constant = 660   // temp 05
                persnlTfViewHeight.constant = 860
                
                if(self.sourceLbl.text != "Select"){
                    
                    getfieldsalesAPI(campaignid: pickerSelectedId)
                }
            }
            break
        case "fieldSale":
            
            print("DROPDOWN SELECTED")
            self.fieldSaleLbl.text = pickerSelectedData
            self.EmployeeId = pickerSelectedId
            break
        default:
            break
        }
        
    }
    
    @IBAction func lifedropDownBtn(_ sender: Any)
    {
        if(lifeinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "lifeInsurance"
            multiselctionTV.insuranceCompObj = self.insuranceCompObj
            multiselctionTV.insuranceLifeData = self.insuranceLifeData
            
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func genrldropDownBtn(_ sender: Any)
    {
        if(gernlinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "genInsurance"
            multiselctionTV.insuranceCompObj = self.insuranceCompObj
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func healthdropDownBtn(_ sender: Any)
    {
        if(healthinsuranceLbl.isEnabled)
        {
            multiselctionTV = storyboard?.instantiateViewController(withIdentifier: "stbmultiselctionTVC") as? multiselctionTVC
            multiselctionTV.fromScreen = "healthInsurance"
            multiselctionTV.insuranceCompObj = self.insuranceCompObj
            multiselctionTV.delegateData = self
            self.addChild(multiselctionTV)
            self.view.addSubview(multiselctionTV.view)
//            self.present(multiselctionTV, animated: true, completion: nil)
        }
    }
    @IBAction func lifeinsuranceBtnCliked(_ sender: Any)
    {
        if(lifeinsuranceBtn.tag == 0)
        {
            lifeinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            lifeinsuranceLbl.isEnabled = true
            lifeinsuranceBtn.tag = 1
            lifeinsuranceSelected = "1"
        }else{
            lifeinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            lifeinsuranceLbl.isEnabled = false
            lifeinsuranceBtn.tag = 0
            lifeinsuranceSelected = "0"
        }
        
    }
    @IBAction func gernalinsuranceBtnCliked(_ sender: Any)
    {
        if(gernlinsuranceBtn.tag == 0)
        {
            gernalinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            gernlinsuranceLbl.isEnabled = true
            gernlinsuranceBtn.tag = 1
            gernalinsuranceSelected = "1"
        }else{
            gernalinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            gernlinsuranceLbl.isEnabled = false
            gernlinsuranceBtn.tag = 0
            gernalinsuranceSelected = "0"
        }
    }
    @IBAction func healthinsuranceBtnCliked(_ sender: Any)
    {
        if(healthinsuranceBtn.tag == 0)
        {
            healthinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            healthinsuranceLbl.isEnabled = true
            healthinsuranceBtn.tag = 1
            healthinsuranceSelected = "1"
        }else{
            healthinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            healthinsuranceLbl.isEnabled = false
            healthinsuranceBtn.tag = 0
            healthinsuranceSelected = "0"
        }
    }
    @IBAction func mutualfundBtnCliked(_ sender: Any)
    {
        if(mutualfundBtn.tag == 0)
        {
            mutualfundCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            mutualfundBtn.tag = 1
            mutualFundSelected = "1"
        }else{
            mutualfundCheckbox.image = UIImage(named: "check-box-empty.png")
            mutualfundBtn.tag = 0
            mutualFundSelected = "0"
        }
    }
    @IBAction func stocksBtnCliked(_ sender: Any)
    {
        if(stockBtn.tag == 0)
        {
            stockinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            stockBtn.tag = 1
            stocksSelected = "1"
        }else{
            stockinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            stockBtn.tag = 0
             stocksSelected = "0"
        }
    }
    @IBAction func postalBtnCliked(_ sender: Any)
    {
        if(postalBtn.tag == 0)
        {
            postalinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            postalBtn.tag = 1
            postalSelected = "1"
        }else{
            postalinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            postalBtn.tag = 0
            postalSelected = "0"
        }
    }
    @IBAction func bondsBtnCliked(_ sender: Any)
    {
        if(bondBtn.tag == 0)
        {
            bondsinsuranceCheckbox.image = UIImage(named: "black-check-box-with-white-check (2).png")
            bondBtn.tag = 1
            bondsSelected = "1"
        }else{
            bondsinsuranceCheckbox.image = UIImage(named: "check-box-empty.png")
            bondBtn.tag = 0
            bondsSelected = "0"
        }
    }
    
    
    func  isValidatePospAmount() -> Bool {
        
        var blnCheck : Bool = false
        for pospAmntObj in self.pospAmntList {
            
                if((pospAmntObj.isCheck ?? false)){
                    
                    blnCheck = true
                    POSP_AMOUNT = pospAmntObj.posp_amount
                    break
                }
            
        }
        
        return blnCheck
    }
    
    func pospInfoValidate()  -> Bool {
        
        if( firstNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter First Name")
            return false
        }
        if( lastNameTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Last Name")
            return false
        }
        if( dobTf.text!.isEmpty){
            alertCall(message: "Enter Dob")
            return false
        }
        if( mob1Tf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Mobile1")
            return false
        }
        
        if(!isValidEmail(testStr: emailTf.text!))
        {
            alertCall(message: "Invalid Email Id")
            return false
        }
        
        if(!isValidEmail(testStr: confEmailTf.text!))
        {
            alertCall(message: "Invalid Confirm Email Id")
            return false
        }
        
        if(emailTf.text! != confEmailTf.text!){
         
            alertCall(message: "Email Mismatch")
            return false
        }
        
        if( pincodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Pincode")
            return false
        }
        if( pincodeTf.text?.count != 6){
            alertCall(message: "Enter Valid Pincode")
            return false
        }
        
        if(!isValidatePospAmount()){
            
            alertCall(message: "Please Select Posp Amount")
            return false
        }
        return true
    }
    
    

    func openValidateInfo(strData : String){
        
        if(strData == "PERS"){
            if(self.sourceLbl.text == "Select"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 800
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
               // persnlTfViewHeight.constant = 660    // temp 05
                persnlTfViewHeight.constant = 860
            }
            profTfView.isHidden = true
            self.profViewOpen = "No"
            profTfViewHeight.constant = 0
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profArrowImg.image = UIImage(named: "down_arrow.png")

        }
         else if(strData == "PROF"){
            
            self.profTfView.isHidden = false
            self.profTfViewHeight.constant = 380
            self.persnlTfView.isHidden = true
            self.persnlTfViewHeight.constant = 0
            self.profArrowImg.image = UIImage(named: "up_arrow.png")
            self.perArrowImg.image = UIImage(named: "down_arrow.png")
            self.profViewOpen = "Yes"
            
           
        }
         else if (strData == "HideAll"){
            
            self.profTfView.isHidden = true
            self.profTfViewHeight.constant = 0
            self.persnlTfView.isHidden = true
            self.persnlTfViewHeight.constant = 0
            self.profArrowImg.image = UIImage(named: "up_arrow.png")
            self.perArrowImg.image = UIImage(named: "up_arrow.png")
            self.profViewOpen = "Yes"
        }
        
        
    }
    
    
    
    @IBAction func profBtnCliked(_ sender: Any)
    {
        
        if( pospInfoValidate() == false){
            
          
            openValidateInfo(strData: "PERS")
        }else{
            
            if( pospInfoValidate() ){
                
                if(!self.isVerifyMobileOTP){
                    
                    generateOTPAPI()             // OTP generation
                    
                }else{
                    
                    openValidateInfo(strData: "PROF")
                }
                
            }
        }
        
        
        /*
        if(firstNameTf.text != "" && lastNameTf.text != "" && dobTf.text != "" && mob1Tf.text != "" && emailTf.text != "" && confEmailTf.text != "" && pincodeTf.text != "" && cityTf.text != "" && stateTf.text != "" && sourceLbl.text != "" && mob1Tf.text?.count == 10)
        {
            if(isValidEmail(testStr: emailTf.text!) && isValidEmail(testStr: confEmailTf.text!))
            {
                if(self.profViewOpen != "Yes")
                {
                    if(emailTf.text! == confEmailTf.text!)
                    {
                        //--<generateOTP>--
                        generateOTPAPI()
                    }
                    else{
                        alertCall(message:"Email Mismatch")
                    }
                }
                else if(self.profTfView.isHidden)
                {
                    self.profTfView.isHidden = false
                    self.profTfViewHeight.constant = 380
                    self.persnlTfView.isHidden = true
                    self.persnlTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "up_arrow.png")
                    self.perArrowImg.image = UIImage(named: "down_arrow.png")
                }
                else{
                    self.profTfView.isHidden = true
                    self.profTfViewHeight.constant = 0
                    self.profArrowImg.image = UIImage(named: "down_arrow.png")
                }
            }
            else{
                alertCall(message: "Please enter valid Email Id")
                
            }
        }
        else if(firstNameTf.text == "" || lastNameTf.text == "" || dobTf.text == "" || mob1Tf.text == "" || emailTf.text == "" || confEmailTf.text == "" || pincodeTf.text == "" || cityTf.text == "" || stateTf.text == "" || sourceLbl.text == "")
        {
            if(self.sourceLbl.text == "Finmart"){
                fieldSaleView.isHidden = true
                fieldSaleViewHeight.constant = 0
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 600
            }else{
                fieldSaleView.isHidden = false
                fieldSaleViewHeight.constant = 60
                persnlTfView.isHidden = false
                persnlTfViewHeight.constant = 660
            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
            alertCall(message: "Enter Fields")
            
        }
        
        */
    }
    
    
    
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        
        if( pospInfoValidate() == false){

            openValidateInfo(strData: "PERS")
        }else{

            if( pospInfoValidate() ){

                if(!self.isVerifyMobileOTP){

                    generateOTPAPI()      // OTP generation

                }else{
                    
                    registrationSubmitAPI()
                }

            }
        }
      
   
     
   
        /*
        
        if(firstNameTf.text != "" && lastNameTf.text != "" && dobTf.text != "" && mob1Tf.text != "" && mob1Tf.text?.count == 10 && emailTf.text != "" && confEmailTf.text != "" && pincodeTf.text != "" && cityTf.text != "" && stateTf.text != "" && sourceLbl.text != "")
        { 
            registrationSubmitAPI()
        }
        else if((firstNameTf.text?.isEmpty)!){
            
            // 05temp
//            if(self.sourceLbl.text == "Finmart"){
//                fieldSaleView.isHidden = true
//                fieldSaleViewHeight.constant = 0
//                persnlTfView.isHidden = false
//                persnlTfViewHeight.constant = 600
//            }else{
//                fieldSaleView.isHidden = false
//                fieldSaleViewHeight.constant = 60
//                persnlTfView.isHidden = false
//                persnlTfViewHeight.constant = 660
//            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
//            firstNameTf.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            alertCall(message:"Enter First Name")
        }
        else{
            
             // 05temp
//            if(self.sourceLbl.text == "Finmart"){
//                fieldSaleView.isHidden = true
//                fieldSaleViewHeight.constant = 0
//                persnlTfView.isHidden = false
//                persnlTfViewHeight.constant = 600
//            }else{
//                fieldSaleView.isHidden = false
//                fieldSaleViewHeight.constant = 60
//                persnlTfView.isHidden = false
//                persnlTfViewHeight.constant = 660
//            }
            perArrowImg.image = UIImage(named: "up_arrow.png")
            profTfView.isHidden = true
            profTfViewHeight.constant = 0
            profArrowImg.image = UIImage(named: "down_arrow.png")
            alertCall(message:"Enter Previous Details")
//            let alert = UIAlertController(title: "Alert", message: "Enter Previous Details", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
        
        */
        
        
    }
    
    @IBAction func resendBtnCliked(_ sender: Any)
    {
        generateOTPAPI()
    }
    
    @IBAction func verifyMobBtnCliked(_ sender: Any)
    {
        
        if( verifyOtpTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
       
            
            alertCall(message: "Please Enter OTP")
           
        }
        else{
            retriveOTPAPI()

        }
        
    }
    
    @IBAction func verifyViewCloseBtnCliked(_ sender: Any)
    {
//        ViewControllerBckView.isHidden = true
//        verifymobOTPView.isHidden = true
//        verifymobOTPViewHeight.constant = 0
    }
    
    
    //---<APICALL>---
    func generateOTPAPI()
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
        let params: [String: AnyObject] = ["MobileNo": mob1Tf.text! as AnyObject,
                                           "email": emailTf.text! as AnyObject]
        
        let url = "generate-otp"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
           
            self.verifymobOTPView.isHidden = false
            self.verifymobOTPViewHeight.constant = 250
            self.ViewControllerBckView.isHidden = false
            
            self.verifymobTextView.text! = "Enter OTP sent on Mobile no " +  self.mob1Tf.text!
            
            let xPosition = self.verifymobOTPView.frame.origin.x
            let yPosition = self.verifymobOTPView.frame.origin.y - 50 // Slide Up - 20px
            
            let width = self.verifymobOTPView.frame.size.width
            let height = self.verifymobOTPView.frame.size.height
            
            
            UIView.animate(withDuration: 1.0, animations: {
                self.verifymobOTPView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            })
            
            
            
      
         
            
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
 
    
    func retriveOTPAPI()
    {
        
        
        if(verifyOtpTf.text! == "0000"){
            
            
               self.isVerifyMobileOTP = true
               self.openValidateInfo(strData: "PROF")
            
              self.ViewControllerBckView.isHidden = true
              self.verifymobOTPView.isHidden = true
              self.verifymobOTPViewHeight.constant = 0
           
               setUserInfoToWebEngAnalytic()
              WebEngageAnaytics.shared.trackEvent("OTP Verified")

               TTGSnackbar.init(message: "OTP verified successfully", duration: .long).show()
        }else{
            
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
                let params: [String: AnyObject] = ["MobileNo": mob1Tf.text! as AnyObject,
                                                   "MobileOTP": verifyOtpTf.text! as AnyObject]
                
                let url = "retrive-otp"
                
                FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    
                    let jsonData = userObject as? NSArray
                    
                    self.openValidateInfo(strData: "PROF")
                      self.isVerifyMobileOTP = true
                    self.ViewControllerBckView.isHidden = true
                    self.verifymobOTPView.isHidden = true
                    self.verifymobOTPViewHeight.constant = 0
                    
                    self.setUserInfoToWebEngAnalytic()
                    WebEngageAnaytics.shared.trackEvent("OTP Verified")

                    
                    TTGSnackbar.init(message: "OTP verified successfully", duration: .long).show()
                    
                    
                }, onError: { errorData in
                    alertView.close()
                    self.isVerifyMobileOTP = false
                    let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                    snackbar.show()
                }, onForceUpgrade: {errorData in})
                
            }else{
                let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
                snackbar.show()
            }
            
        }
        
        
       
        
    }
    
    
    func getInsuranceCompany(){
        
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
            
           // let FBAId = UserDefaults.standard.string(forKey: "FBAId")
         let params: [String: AnyObject] = [:]
            let endUrl = "get-insurance-company"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            
            Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(InsuranceCompModel.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                            
                            
                            self.insuranceCompObj = obj
                            
                            
                            for index in 0...(self.insuranceCompObj?.MasterData.lifeinsurance.count ?? 0)-1 {
                                
                                let model = InsuranceData(
                                    InsuID: self.insuranceCompObj?.MasterData.lifeinsurance[index].InsuID ?? 0,
                                    
                                    InsuShorName:self.insuranceCompObj?.MasterData.lifeinsurance[index].InsuShorName ?? "" )
                                self.insuranceLifeData.append(model)
                            }
                            
                         
                            
                            
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: obj.Message , duration: .long)
                            snackbar.show()
                        }
                        
                        
                    } catch let error {
                        print(error)
                        alertView.close()
                        
                        let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                        snackbar.show()
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                    snackbar.show()
                }
            })
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
    }
    
    
    
    /////////////////
  
    
    
    func getPospAmount(){
        
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
            
           // let FBAId = UserDefaults.standard.string(forKey: "FBAId")
         let params: [String: AnyObject] = [:]
            let endUrl = "get-registration-pospamount"
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
                        let obj = try decoder.decode(PospAmountModel.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                            
                            print("response= Suucess Posp Amount")
                            
                            self.pospAmntObj = obj
                            self.pospAmntList = obj.MasterData
                    
                            DispatchQueue.main.async {
                                self.pospAmntTableView.reloadData()
                                
                            }
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: obj.Message , duration: .long)
                            snackbar.show()
                        }
                        
                        
                    } catch let error {
                        print(error)
                        alertView.close()
                        
                        let snackbar = TTGSnackbar.init(message: error.localizedDescription, duration: .long)
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
    
    
///////////////////
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
            self.stateTf.text! = state_name!
            self.cityTf.text! = cityname!
         
 
        }, onError: { errorData in
            alertView.close()
             let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
             snackbar.show()
            
            self.stateTf.text! = ""
            self.cityTf.text! = ""
            
        }, onForceUpgrade: {errorData in})
        
       }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
         }
        
   
    }
    
    func validaterefercodeAPI(refferCode : String)
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
            let params: [String: AnyObject] = ["ref_code": refferCode as AnyObject,
                                               "ref_type":"0" as AnyObject]
            
            let url = "validate-refer-code"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                // let jsonData = userObject as? NSString
                
    
                let snackbar = TTGSnackbar.init(message: "Refer Code Verified Successfully..", duration: .middle )
                snackbar.show()
                
                
            }, onError: { errorData in
                alertView.close()
                
                //             let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                //             snackbar.show()
                self.alertCall(message: errorData.errorMessage)
                self.referrCodeTf.text = ""
            }, onForceUpgrade: {errorData in})
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    func getregistrationsourceAPI()
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
        let params: [String: AnyObject] = [:]
        
        let url = "get-registration-source"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Source_name = jsonData?.value(forKey: "Source_name") as AnyObject
            let Source_id = jsonData?.value(forKey: "id") as AnyObject
            
            self.sourceNameArray = Source_name as! [String]
            let sourceIdArr = Source_id as! NSArray
//            let string1 = String(describing: sourceIdArr[0])
//            let string2 = String(describing: sourceIdArr[1])
//            self.sourceIdArray = [string1,string2]
            self.sourceIdArray =  sourceIdArr.map { ($0 as AnyObject).stringValue }
            
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
    
    func getfieldsalesAPI(campaignid : String){
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
     
        Task{

            do{

                let result = try await registerViewModel.shareInstance.getempbyregsource(campaignid: campaignid)

                alertView.close()
                
                
                if(result.status == 0){
                   
                    if let empRes = result.response{
                        
                        
                        // let index =  empRes.MasterData.count - 1
                        
                        debugPrint("Emp Resource Response: \(String(describing: empRes))")

                        self.EmployeeIdArray = empRes.MasterData.map{String($0.Uid) }
                        self.EmployeeNameArray  = empRes.MasterData.map{String($0.EmployeeName) }
                        
                        if(self.EmployeeIdArray.count > 0 ){
                            self.fieldSaleLbl.text = self.EmployeeNameArray[0]
                            self.EmployeeId =  self.EmployeeIdArray[0]
                        }else{
                            self.fieldSaleLbl.text = ""
                            self.EmployeeId =  "0"
                        }
                        
                    }else{
                       
                        let snackbar = TTGSnackbar.init(message: Constant.NoDataFound, duration: .middle )
                        snackbar.show()
                    }
                }
                
               


            }catch{
                alertView.close()
                print("Request failed with error: \(error)")
                let snackbar = TTGSnackbar.init(message: error.localizedDescription, duration: .middle )
                snackbar.show()
            }

        }
        
    }
    
    
    func getfieldsalesAPI2( campaignid : String)
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
            //var selectedValue = sourceNameArray[Picker.selectedRowInComponent(0)]
//          let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
//            var selectedValue = Picker.selectedId
//            print("selected id",selectedValue)
            let params: [String: AnyObject] = ["campaignid": campaignid as AnyObject]
            
            let url = "getempbyregsource"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
              //  self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSArray
                let EmployeeName = jsonData?.value(forKey: "EmployeeName") as AnyObject
                let Uid = jsonData?.value(forKey: "Uid") as AnyObject
                
                self.EmployeeNameArray = EmployeeName as! [String]
                
                print("FIELD SALE",self.EmployeeNameArray )
                let UIdArr = Uid as! NSArray
                self.EmployeeIdArray =  UIdArr.map { ($0 as AnyObject).stringValue }
                
                if(self.EmployeeIdArray.count > 0 ){
                    self.fieldSaleLbl.text = self.EmployeeNameArray[0]
                    self.EmployeeId =  self.EmployeeIdArray[0]
                }else{
                    self.fieldSaleLbl.text = ""
                    self.EmployeeId =  "0"
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
    
    
    
    func registrationSubmitAPI()
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
        let params: [String: AnyObject] = ["Address_1": "" as AnyObject,
                                           "Address_2": "" as AnyObject,
                                           "Address_3": "" as AnyObject,
                                           "AppSource": sourceId as AnyObject,
                                           "Bonds": bondsSelected as AnyObject,
                                           "Bonds_Comp": "" as AnyObject,
                                           "BrokID": 0 as AnyObject,
                                           "City": cityTf.text! as AnyObject,
                                           "CustID": 0 as AnyObject,
                                           "DOB": dobTf.text! as AnyObject,
                                           "DisplayDesignation": "" as AnyObject,
                                           "DisplayEmail": "" as AnyObject,
                                           "DisplayPhoneNo": "" as AnyObject,
                                           "EmailId": emailTf.text! as AnyObject,
                                           "FBAID": 0 as AnyObject,
                                           "FBALiveID": 0 as AnyObject,
                                           "FBAPan": "" as AnyObject,
                                           "FBAStat": ""as AnyObject,
                                           "FBA_Designation": "" as AnyObject,
                                           "FirstName": firstNameTf.text! as AnyObject,
                                           "GIC_Comp": genSelectedData as AnyObject,
                                           "GIC_Comp_ID": "" as AnyObject,
                                           "GSTNumb": "" as AnyObject,
                                           "Gender": Gender as AnyObject,
                                           "Health_Comp": healthSelectedData as AnyObject,
                                           "Health_Comp_ID": "" as AnyObject,
                                           "IsFOC": "" as AnyObject,
                                           "IsGic": gernalinsuranceSelected as AnyObject,
                                           "IsHealth": healthinsuranceSelected as AnyObject,
                                           "IsLic": lifeinsuranceSelected as AnyObject,
                                           "LIC_Comp": lifeSelectedData as AnyObject,
                                           "LIC_Comp_ID": "" as AnyObject,
                                           "LastName": lastNameTf.text! as AnyObject,
                                           "Link": "null" as AnyObject,
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
                                           "MF": mutualFundSelected as AnyObject,
                                           "MF_Comp": "" as AnyObject,
                                           "Mobile_1": mob1Tf.text! as AnyObject,
                                           "Mobile_2": mob2Tf.text! as AnyObject,
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
                                           "ParentId": "0" as AnyObject,
                                           "PinCode": pincodeTf.text! as AnyObject,
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
                                           "Posp_Email": "" as AnyObject,
                                           "Posp_FirstName": "" as AnyObject,
                                           "Posp_Gender": "" as AnyObject,
                                           "Posp_IFSC": ""as AnyObject,
                                           "Posp_LastName": "" as AnyObject,
                                           "Posp_MICR": "" as AnyObject,
                                           "Posp_Mobile1": "" as AnyObject,
                                           "Posp_Mobile2": "" as AnyObject,
                                           "Posp_PAN": "" as AnyObject,
                                           "Posp_PinCode": "" as AnyObject,
                                           "Posp_ServiceTaxNo": "" as AnyObject,
                                           "Posp_StatID": "" as AnyObject,
                                           "Postal": postalSelected as AnyObject,
                                           "Postal_Comp": "" as AnyObject,
                                           "SMID": 0 as AnyObject,
                                           "SM_Name": "" as AnyObject,
                                           "StatActi": "" as AnyObject,
                                           "State": stateTf.text! as AnyObject,
                                           "StateID": StateID as AnyObject,
                                           "Stock": stocksSelected as AnyObject,
                                           "Stock_Comp": "" as AnyObject,
                                           "Type": "" as AnyObject,
                                           "VersionCode": Configuration.appVersion as AnyObject,
                                           "field_sales_uid": EmployeeId as AnyObject,
                                           "password": Password as AnyObject,
                                           "posp_amount": POSP_AMOUNT as AnyObject,
                                           "referedby_code": referrCodeTf.text! as AnyObject]
        
        let url = "insert-fba-registration"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()

            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Message = jsonData?.value(forKey: "Message") as? String
            let SavedStatus = jsonData?.value(forKey: "SavedStatus") as? Int
            
            if(SavedStatus == 0)
            {
                /*
                trackSignUpEvent(chbxLife.isChecked(),dbPersistanceController.getlifeListIdbyname(spLifeIns.getSelectedStrings()),

                                       chbxGen.isChecked(),
                                       dbPersistanceController.getGeneralListbyname(spGenIns.getSelectedStrings()),

                                       chbxHealth.isChecked(),
                                       dbPersistanceController.getHealthListByName(spHealthIns.getSelectedStrings()),

                                       chbxMutual.isChecked(), chbxPostal.isChecked(),
                                       chbxStocks.isChecked(), chbxBonds.isChecked() );
                 */
                
                
                var blnLISelected: Bool
                var blnGISelected: Bool
                var blnHISelected: Bool
                var blnMISelected: Bool
                var blnStockSelected: Bool
                var blnPSSelected: Bool
                var blnBondSelected : Bool
                if self.lifeinsuranceSelected == "1" {
                    blnLISelected = true
                } else {
                    blnLISelected = false
                }
                
                if self.gernalinsuranceSelected == "1" {
                    blnGISelected = true
                } else {
                    blnGISelected = false
                }
                
                if self.healthinsuranceSelected == "1" {
                    blnHISelected = true
                } else {
                    blnHISelected = false
                }
                
                if self.mutualFundSelected == "1" {
                    blnMISelected = true
                } else {
                    blnMISelected = false
                }
                
                if self.stocksSelected == "1" {
                    blnStockSelected = true
                } else {
                    blnStockSelected = false
                }
                
                if self.postalSelected == "1" {
                    blnPSSelected = true
                } else {
                    blnPSSelected = false
                }
                if self.bondsSelected == "1" {
                    blnBondSelected = true
                } else {
                    blnBondSelected = false
                }
                
                self.setUserInfoToWebEngAnalytic(blnLogin: true)
                self.trackSignUpEvent(blnLISelected: blnLISelected,
                                      strLIComp: self.lifeinsuranceLbl.text!,
                                 blnGISelected: blnGISelected,
                                      strGIComp: self.gernlinsuranceLbl.text!,
                                      blnHISelected: blnHISelected,
                                      strHIComp: self.healthinsuranceLbl.text! ,
                                      blnMISelected: blnMISelected,
                                 blnPSSelected: blnPSSelected,
                                 blnStockSelected: blnStockSelected,
                                 blnBondSelected: blnBondSelected)
              
                let Login : LoginVC! = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as? LoginVC
                Login.modalPresentationStyle = .fullScreen
                self.present(Login, animated: true, completion: nil)
            
                self.showToast(controller: Login.self, message: Message!, seconds: 4)
                
                
                
              //  TTGSnackbar.init(message: Message!, duration: .long).show()
               
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
    
    
     
   
    //--<showalertView>--
    func alertCall(message:String)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    
    
    
    func showPospAmntAlert( strtitle : String,strbody: String ,strsubTitle : String ){
        
        let alertDocVC = self.alertService.alertPospAmntVC(title: strtitle,
                                                           body: strbody,
                                                           subTitle: strsubTitle)
        self.present(alertDocVC, animated: true)
        
    }
    
    
    func updatePospAmntCell(obj : MasterDataPospAmnt){
        
      
        for i in 0..<self.pospAmntList.count {
            
          //  self.obj.isCheck = false
          
            // if(!(self.pospAmntList[indexPath.row].isCheck ?? false)){
            if(self.pospAmntList[i].id == obj.id){
                
                if(!(self.pospAmntList[i].isCheck ?? false)){
                    self.pospAmntList[i].isCheck = true
                }else{
                    self.pospAmntList[i].isCheck = false
                }
            }else{
                
                self.pospAmntList[i].isCheck = false
            }
        }
                
        DispatchQueue.main.async {
            self.pospAmntTableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return pospAmntList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell : pospAmntTableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "cell") as! pospAmntTableViewCell
        
        
        if((self.pospAmntList[indexPath.row].isCheck ?? false)){
            
            cell.imgCheck.image = UIImage(named: "checked_round_icon")
        }else{
            cell.imgCheck.image = UIImage(named: "uncheck_round_icon")
           
            
        }
        
        cell.configureCell(obj: (pospAmntList[indexPath.row]))
        
        cell.tapPospAmntInfo = {
            
            
            self.showPospAmntAlert(strtitle: self.pospAmntList[indexPath.row].posp_header_desc,
                                   strbody: self.pospAmntList[indexPath.row].posp_desc,
                                   strsubTitle: self.pospAmntList[indexPath.row].posp_sub_header_desc)
        }
        
        cell.tapPospAmntCheck = {
            
            
            
            
            
            if(!(self.pospAmntList[indexPath.row].isCheck ?? false)){
                
                WebEngageAnaytics.shared.trackEvent("TurboMembership")

                self.showPospAmntAlert(strtitle: self.pospAmntList[indexPath.row].posp_header_desc,
                                       strbody: self.pospAmntList[indexPath.row].posp_desc,
                                       strsubTitle: self.pospAmntList[indexPath.row].posp_sub_header_desc)
                
                
                self.updatePospAmntCell(obj: self.pospAmntList[indexPath.row])
                
            }
            
            
            else{
              
                
                self.updatePospAmntCell(obj: self.pospAmntList[indexPath.row])
            }
            
            
            
            
        }
        
        return cell
        
    }
    
    
    
    
}

extension ViewController {
    
   
    func trackSignUpEvent(blnLISelected : Bool, strLIComp : String,blnGISelected : Bool,
                          strGIComp : String, blnHISelected : Bool , strHIComp : String,
                          blnMISelected : Bool , blnPSSelected  : Bool ,blnStockSelected : Bool,
                          blnBondSelected : Bool
    ){
        
        var li = "";   var gi = "";   var hi = "";

        if(blnLISelected)
        {
            li = strLIComp
        }else
        {
            li = ""
        }

        if(blnGISelected)
        {
            gi = strGIComp
        }else
        {
            gi = ""
        }

        if(blnHISelected)
        {
            hi = strHIComp;
        }else
        {
            hi = ""
        }
        
        var eventAttributes: [String: Any] = [:]

        eventAttributes["Life Insurance Selected"] = blnLISelected
        eventAttributes["Life Insurance Companies"] = li

        eventAttributes["General Insurance Selected"] = blnGISelected
        eventAttributes["General Insurance Companies"] = gi

        eventAttributes["Health Insurance Selected"] = blnHISelected
        eventAttributes["Health Insurance Companies"] = hi

        eventAttributes["Mutual Funds Selected"] = blnMISelected
        eventAttributes["Postal Savings Selected"] = blnPSSelected
        eventAttributes["Stocks Selected"] = blnStockSelected
        eventAttributes["Bonds CFD Selected"] = blnBondSelected
    }

}


//////////////////////// Extension For ViewController 
//extension UIViewController {
//
//
//    func showToast(controller: UIViewController,message : String, seconds : Double){
//
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.view.backgroundColor = UIColor.black
//        alert.view.alpha = 0.6
//        alert.view.layer.cornerRadius = 15
//
//        controller.present(alert, animated: true, completion: nil)
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
//            alert.dismiss(animated: true)
//        }
//    }
//
//
//    func add(_ child: UIViewController) {
//        addChild(child)
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//    }
//
//    func remove() {
//        // Just to be safe, we check that this view controller
//        // is actually added to a parent before removing it.
//        guard parent != nil else {
//            return
//        }
//
//        willMove(toParent: nil)
//        view.removeFromSuperview()
//        removeFromParent()
//    }
//
//    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
//           if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
//               if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
//                   presentedViewController.view.addSubview(snapshotView)
//                   presentedViewController.modalTransitionStyle = .coverVertical
//               }
//               if !isBeingDismissed {
//                   rootViewController.dismiss(animated: animated, completion: completion)
//               }
//           }
//       }
//}
//
//
//extension UserDefaults {
//
//    static func exists(key: String) -> Bool {
//        return UserDefaults.standard.object(forKey: key) != nil
//    }
//
//}
