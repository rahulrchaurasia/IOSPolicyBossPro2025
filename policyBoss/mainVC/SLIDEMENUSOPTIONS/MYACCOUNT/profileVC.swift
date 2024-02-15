//
//  profileVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 21/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire
import SDWebImage
import AVFoundation

class profileVC: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var myaccountImgeView: UIImageView!
    @IBOutlet weak var myprofileView: UIView!
    @IBOutlet weak var myprofileViewHeight: NSLayoutConstraint!//200
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressViewHeight: NSLayoutConstraint!//310
    @IBOutlet weak var bankdetailsView: UIView!
    @IBOutlet weak var bankdetailsViewHeight: NSLayoutConstraint!//410
    @IBOutlet weak var docdetailsView: UIView!
    @IBOutlet weak var docdetailsViewHeight: NSLayoutConstraint!//180
    @IBOutlet weak var pospinfoView: UIView!
    @IBOutlet weak var pospinfoViewHeight: NSLayoutConstraint!//200
    @IBOutlet weak var aboutme1View: UIView!
    @IBOutlet weak var aboutmeViewHeight: NSLayoutConstraint!//400
    @IBOutlet weak var aboutme2View: UIView!
    @IBOutlet weak var notisettingView: UIView!
    @IBOutlet weak var notisettingViewHeight: NSLayoutConstraint!//50
    
    @IBOutlet weak var designationTf: ACFloatingTextfield!
    @IBOutlet weak var mobilenotoshareTf: ACFloatingTextfield!
    @IBOutlet weak var emailtoshareTf: ACFloatingTextfield!
    @IBOutlet weak var address1Tf: ACFloatingTextfield!
    @IBOutlet weak var address2Tf: ACFloatingTextfield!
    @IBOutlet weak var address3Tf: ACFloatingTextfield!
    @IBOutlet weak var pincodeTf: ACFloatingTextfield!
    @IBOutlet weak var cityTf: ACFloatingTextfield!
    @IBOutlet weak var stateTf: ACFloatingTextfield!
    @IBOutlet weak var savingBtn: UIButton!
    @IBOutlet weak var currentBtn: UIButton!
    @IBOutlet weak var accountHolderNameTf: ACFloatingTextfield!
    @IBOutlet weak var panTf: ACFloatingTextfield!
    @IBOutlet weak var addharTf: ACFloatingTextfield!
    @IBOutlet weak var bankaccnoTf: ACFloatingTextfield!
    @IBOutlet weak var ifscCodeTf: ACFloatingTextfield!
    @IBOutlet weak var micrCodeTf: ACFloatingTextfield!
    @IBOutlet weak var bankNameTf: ACFloatingTextfield!
    @IBOutlet weak var bankBranchTf: ACFloatingTextfield!
    @IBOutlet weak var bankCityTf: ACFloatingTextfield!
    @IBOutlet weak var pospDesignTf: ACFloatingTextfield!
    @IBOutlet weak var pospMobNumTf: ACFloatingTextfield!
    @IBOutlet weak var pospemailTf: ACFloatingTextfield!
    @IBOutlet weak var fbaIdLbl: UILabel!
    @IBOutlet weak var pospNoLbl: UILabel!
    @IBOutlet weak var loginIdLbl: UILabel!
    @IBOutlet weak var pospStatusLbl: UILabel!
    @IBOutlet weak var abtmeMobnoLbl: UILabel!
    @IBOutlet weak var abtmeemailLbl: UILabel!
    @IBOutlet weak var spprtMobNoLbl: UILabel!
    @IBOutlet weak var spportEmailLbl: UILabel!
    @IBOutlet weak var fbaNameLbl: UILabel!
    @IBOutlet weak var managerNameLbl: UILabel!
    
    
    @IBOutlet weak var imgDoc1: UIImageView!
    @IBOutlet weak var imgDoc2: UIImageView!
    @IBOutlet weak var imgDoc3: UIImageView!
    @IBOutlet weak var imgDoc4: UIImageView!
    
    
    @IBOutlet weak var docView1Btn: UIButton!
    @IBOutlet weak var docView2Btn: UIButton!
    @IBOutlet weak var docView3Btn: UIButton!
    @IBOutlet weak var docView4Btn: UIButton!
   
    
    @IBOutlet weak var docView1Img: UIImageView!
    @IBOutlet weak var docView2Img: UIImageView!
    @IBOutlet weak var docView3Img: UIImageView!
    @IBOutlet weak var docView4Img: UIImageView!
   
    
    let aTextField = ACFloatingTextfield()
    var imagePicker = UIImagePickerController()
    var pickedImage = UIImage()
    var dataImage = ""
    var uploadDoc = ""
    
    var accountType = "SAVING"
    var stateid = String()
    var stateName = String()
    var profileDocModel = [pospDoc]()
    

    // For AlertDialog
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.MyAccountScreen)
        imagePicker.delegate = self
        //--<textField>--
        aTextField.delegate = self
        
        micrCodeTf.delegate = self
        bankBranchTf.delegate = self
        bankNameTf.delegate = self
        bankCityTf.delegate = self
        
        designationTf.delegate = self
        mobilenotoshareTf.delegate = self
        emailtoshareTf.delegate = self
        address1Tf.delegate = self
        address2Tf.delegate = self
        address3Tf.delegate = self
        pospemailTf.delegate = self
        pincodeTf.delegate = self
        cityTf.delegate = self
        stateTf.delegate = self
        
        accountHolderNameTf.delegate = self
        panTf.delegate = self
        addharTf.delegate = self
        bankaccnoTf.delegate = self
        ifscCodeTf.delegate = self
        
        
        pospDesignTf.delegate = self
        pospMobNumTf.delegate = self
        
        // FOr Hiding Navigation Bar
        self.navigationController?.isNavigationBarHidden = true;
        
        panTf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        ifscCodeTf.autocapitalizationType = .allCharacters
        
        //--<cornerradius>--
//        myaccountImgeView.layer.cornerRadius = 64
        self.view.layoutIfNeeded()
        
        //--<borderView>--
        viewColorblue(view: myprofileView)
        viewColorblue(view: addressView)
        viewColorblue(view: bankdetailsView)
        viewColorblue(view: docdetailsView)
        viewColorblue(view: pospinfoView)
        viewColorblue(view: notisettingView)
        viewColorblue(view: aboutme1View)
        btnColorChangeGray(Btn: currentBtn)
        btnColorChangeBlue(Btn: savingBtn)
        
        let borderColor2 = UIColor.gray
        aboutme2View.layer.borderWidth=1.0;
        aboutme2View.layer.borderColor=borderColor2.cgColor;
        aboutme2View.layer.shadowColor=borderColor2.cgColor
      
        //--<viewHidden>--
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
        
        
        cityTf.isEnabled = false
        stateTf.isEnabled = false
            
        docView1Img.isHidden = true
        docView1Btn.isHidden = true
        
        docView2Img.isHidden = true
        docView2Btn.isHidden = true
        
        docView3Img.isHidden = true
        docView3Btn.isHidden = true
        
        docView4Img.isHidden = true
        docView4Btn.isHidden = true
        
      
        //--<apiCall>--
        getmyaccountAPI()
        
//        enmob1Tf.isEnabled = false
//        enemailTf.isEnabled = false
        
    }
    
    //--<roundImageView>--
    override func viewDidLayoutSubviews()
    {
        myaccountImgeView.layer.cornerRadius = myaccountImgeView.frame.size.width/2
        myaccountImgeView.clipsToBounds = true
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
    
    @IBAction func myaccountBackBtn(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//         KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
        
         self.dismiss(animated: false, completion: nil)
    }
    
    //---<textFieldRange>---
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if(textField == bankaccnoTf  )
              {
                  
                  let allowedCharacters = CharacterSet.decimalDigits
                  let characterSet = NSCharacterSet(charactersIn: string)
                  return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                  
                  
              }
        if(textField == mobilenotoshareTf   ||  textField == pospMobNumTf)
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
        
        else if(textField == addharTf)
        {
            if((textField.text?.count)! <= 11)
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
        
        else if(textField == pincodeTf)
        {

            
            
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
                        print("pincode =",updatedText)
                       getCityStateAPI(pincode: updatedText)
                    }
                    
                }
                
                return blnStatus
                
                
            }else{
                return false
            }
            
            

        }
            
//        else if(textField == ifscCodeTf)
//        {
//            if((textField.text?.count)! <= 10)
//            {
//                let allowedCharacters = CharacterSet.alphanumerics
//                let characterSet = NSCharacterSet(charactersIn: string)
//                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
//            }
//            else{
//               return false
//            }
//
//        }
        else if(textField == panTf)
        {
            if((textField.text?.count)! <= 9)
            {
//                let allowedCharacters = CharacterSet.alphanumerics
//                let characterSet = NSCharacterSet(charactersIn: string)
//                return allowedCharacters.isSuperset(of: characterSet as CharacterSet)
                
                return true
            }
            else{
                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace = range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace
                
                return newLength <= (textField.text?.count)!            }

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
    
    //---<buttonsClicks>---
    @IBAction func myprofileBtnCliked(_ sender: Any)
    {
        if(myprofileView.isHidden)
        {
            myprofileView.isHidden = false
            myprofileViewHeight.constant = 200
        }else{
            myprofileView.isHidden = true
            myprofileViewHeight.constant = 0
        }
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
    }
    
    @IBAction func addressBtnCliked(_ sender: Any)
    {
        if(addressView.isHidden)
        {
            addressView.isHidden = false
            addressViewHeight.constant = 310
        }else{
            addressView.isHidden = true
            addressViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
    }
    
    @IBAction func bankdetailsBtnClick(_ sender: Any)
    {
        if(bankdetailsView.isHidden)
        {
            bankdetailsView.isHidden = false
            bankdetailsViewHeight.constant = 410
        }else{
            bankdetailsView.isHidden = true
            bankdetailsViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
    }
    
    @IBAction func docuploadBtnCliked(_ sender: Any)
    {
        if(docdetailsView.isHidden)
        {
            docdetailsView.isHidden = false
            docdetailsViewHeight.constant = 180
        }else{
            docdetailsView.isHidden = true
            docdetailsViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
        
    }
    
    @IBAction func pospBtnClicked(_ sender: Any)
    {
        if(pospinfoView.isHidden)
        {
            pospinfoView.isHidden = false
            pospinfoViewHeight.constant = 200
        }else{
            pospinfoView.isHidden = true
            pospinfoViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
    }
    
    @IBAction func aboutmeBtnCliked(_ sender: Any)
    {
        if(aboutme1View.isHidden){
            aboutme1View.isHidden = false
            aboutmeViewHeight.constant = 400
        }
        else{
            aboutme1View.isHidden = true
            aboutmeViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        notisettingView.isHidden = true
        notisettingViewHeight.constant = 0
    }
    
    @IBAction func notisettingBtnCliked(_ sender: Any)
    {
        if(notisettingView.isHidden)
        {
            notisettingView.isHidden = false
            notisettingViewHeight.constant = 50
        }else{
            notisettingView.isHidden = true
            notisettingViewHeight.constant = 0
        }
        myprofileView.isHidden = true
        myprofileViewHeight.constant = 0
        addressView.isHidden = true
        addressViewHeight.constant = 0
        bankdetailsView.isHidden = true
        bankdetailsViewHeight.constant = 0
        docdetailsView.isHidden = true
        docdetailsViewHeight.constant = 0
        pospinfoView.isHidden = true
        pospinfoViewHeight.constant = 0
        aboutme1View.isHidden = true
        aboutmeViewHeight.constant = 0
    }
    
    
    //05
    func setAccountType(type: String){
        
        if(type == "SAVING"){
            btnColorChangeGray(Btn: currentBtn)
            btnColorChangeBlue(Btn: savingBtn)
            accountType = "SAVING"
        }else{
            
            btnColorChangeGray(Btn: savingBtn)
            btnColorChangeBlue(Btn: currentBtn)
            accountType = "CURRENT"
        }
     
    }
    func setWebEnagageUser(mob : String ,email : String , gender : String ,dob : String){
        
        WebEngageAnaytics.shared.getWEGUser().setPhone(mob)
        WebEngageAnaytics.shared.getWEGUser().setEmail(email)
        if(gender == "M"){
         
            WebEngageAnaytics.shared.getWEGUser().setGender("MALE")
        }else{
            WebEngageAnaytics.shared.getWEGUser().setGender("FEMALE")
        }
      
        do {
            
            if(!dob.isEmpty){
                let dobFormatted  = dob.toDateString(inputDateFormat: "dd-MM-yyyy", ouputDateFormat:"yyyy-MM-dd") ?? ""
                
                debugPrint("User dob ", dobFormatted )
                WebEngageAnaytics.shared.getWEGUser().setBirthDateString(dobFormatted)

            }else{
                WebEngageAnaytics.shared.getWEGUser().setBirthDateString("")

            }
                      
        }catch{
            WebEngageAnaytics.shared.getWEGUser().setBirthDateString("")
        }
         
        debugPrint("User Phone ",mob)
        debugPrint("User Gender ",gender)
        debugPrint("User enmail ",email)
     
    }
    
    func viewDoc(strImage : String , strtitle : String){
        
        let alertDocVC = self.alertService.alertDocView(strURL: strImage, strTitle: strtitle)
        self.present(alertDocVC, animated: true)
        
    }
    
      @IBAction func docView1btnClick(_ sender: Any) {
            
            
            viewDoc(strImage: (sender as AnyObject).layer.name!, strtitle: "FBA PHOTOGRAPH")
        }

    
      @IBAction func docView2btnClick(_ sender: Any) {
           
            viewDoc(strImage: (sender as AnyObject).layer.name!, strtitle: "FBA PAN CARD")
        }
        
        
        @IBAction func docView3btnClick(_ sender: Any) {
            viewDoc(strImage: (sender as AnyObject).layer.name!, strtitle: "CANCELLED CHQ")
        }
        
        @IBAction func docView4btnClick(_ sender: Any) {
            
            viewDoc(strImage: (sender as AnyObject).layer.name!, strtitle: "FBA AADHAR CARD")
        }
    
    @IBAction func savingBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: currentBtn)
        btnColorChangeBlue(Btn: savingBtn)
        accountType = "SAVING"
    }
    
    @IBAction func currentBtnCliked(_ sender: Any)
    {
        btnColorChangeGray(Btn: savingBtn)
        btnColorChangeBlue(Btn: currentBtn)
        accountType = "CURRENT"
    }
   
    //---<accessCamera>---
    @IBAction func cameraBtnCliked(_ sender: Any)
    {
        uploadDoc = "CameraClick"
        callCamera((Any).self)
    }
    
    @IBAction func fbaphotoCamBtnCliked(_ sender: Any)
    {
        uploadDoc = "fbaPhoto"
        callCamera((Any).self)
    }
    
    @IBAction func fbapanCamBtnCliked(_ sender: Any)
    {
        uploadDoc = "fbaPan"
        callCamera((Any).self)
    }
    
    @IBAction func cancelchqCamBtnCliked(_ sender: Any)
    {
        uploadDoc = "cancelChq"
        callCamera((Any).self)
    }
    
    @IBAction func fbaaadharCamBtnCliked(_ sender: Any)
    {
        uploadDoc = "fbaAadhar"
        callCamera((Any).self)
    }
    
    func callCamera(_ sender: Any)
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
           // self.openCamera()
            self.checkCameraPermission()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkCameraPermission(){
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authStatus {
        case .denied:
            print("Deny status called")
            CheckPermissionAlert( _title: "Camera access is need to capture the image",_message: "Please Allow Camera Access")
            break
            
            
        case .restricted:
            print("User Don't Allow")
            break
            
        case .authorized:
            print("Success")
            self.openCamera()
           
            break
        
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (success) in
                
                if success {
                    print("Permission Granted")
                    self.openCamera()
                }else{
                    print("Permission Not Granted")
                }
            }
        break
        default:
            print("Statuds : Unknown")
        }
    }
    
    func openCamera()
    {
        DispatchQueue.main.async {
            
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
       
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - ImagePicker delegate
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
          pickedImage = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!
        
//        print("pickedImage==",pickedImage)
//        myaccountImgeView.image = pickedImage
////        myaccountImgeView.layer.cornerRadius = 64
//
//        //--Encoding Base-64 image--
//        let userImage:UIImage = pickedImage
//        print("userImage",userImage)
//        let imageData:NSData = userImage.pngData()! as NSData
//        dataImage = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        if(uploadDoc == "CameraClick"){
            
            trackDocUploadEvent(strDocType: "PROFILE PICTURE")
            uploaddocAPI(documentName:"FBAPhotograph", documentType:"1")
        }
        else if(uploadDoc == "fbaPhoto"){
            
            trackDocUploadEvent(strDocType: "PROFILE PICTURE")
            uploaddocAPI(documentName:"FBAPhotograph", documentType:"2")
        }
        else if(uploadDoc == "fbaPan"){
            
            trackDocUploadEvent(strDocType: "FBA PAN CARD")
            uploaddocAPI(documentName:"LoanRepPanCard", documentType:"3")
        }
        else if(uploadDoc == "cancelChq"){
            
            trackDocUploadEvent(strDocType: "CANCELLED CHQ")
            uploaddocAPI(documentName:"LoanRepCancelChq", documentType:"4")
        }
        else if(uploadDoc == "fbaAadhar"){
            
            trackDocUploadEvent(strDocType: "FBA AADHAR CARD")
            uploaddocAPI(documentName:"OtherAadharCard", documentType:"5")
        }
        
        
        self.view.layoutIfNeeded()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    //--<endCamera>--
    
    
    
    func profileValidate()  -> Bool {
        
        
        if( designationTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Designation")
            return false
        }
        if( mobilenotoshareTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Mobile Number")
            return false
        }
        if(mobilenotoshareTf.text!.count != 10){
            alertCall(message: "Enter Valid Mobile Number")
            return false
        }
        if( emailtoshareTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            alertCall(message: "Enter Email ID")
            return false
        }
        if(!isValidEmail(testStr: emailtoshareTf.text!))
        {
            alertCall(message: "Invalid Email Id")
            return false
        }
        
        
        return true
    }
    @IBAction func savinfoBtnCliked(_ sender: Any)
    {
        
        if(profileValidate() == false){
            
            myprofileView.isHidden = false
            myprofileViewHeight.constant = 200
            
        }else{
            
            trackMyAccountSubmitEvent()
            myaccountAPI()
        }
        
        
        
//        if(designationTf.text! != "" && mobilenotoshareTf.text! != "" && emailtoshareTf.text! != "" && mobilenotoshareTf.text!.count == 10 && pospMobNumTf.text!.count == 10){
//
//            if(isValidEmail(testStr: emailtoshareTf.text!) && isValidEmail(testStr: pospemailTf.text!))
//            {
//                myaccountAPI()
//
//            }else{
//                alertCall(message: "Invalid Email Id")
//            }
//        }
//        else if(designationTf.text! == "")
//        {
//            if(myprofileView.isHidden)
//            {
//                myprofileView.isHidden = false
//                myprofileViewHeight.constant = 200
//            }
//            alertCall(message: "Please enter Designation")
//        }
//        else if(mobilenotoshareTf.text! == "")
//        {
//            if(myprofileView.isHidden)
//            {
//                myprofileView.isHidden = false
//                myprofileViewHeight.constant = 200
//            }
//            alertCall(message: "Please enter Mobile Number")
//        }
//        else if(emailtoshareTf.text! == "")
//        {
//            if(myprofileView.isHidden)
//            {
//                myprofileView.isHidden = false
//                myprofileViewHeight.constant = 200
//            }
//            alertCall(message: "Please enter Email Id")
//        }
//        else if(mobilenotoshareTf.text!.count != 10)
//        {
//            if(myprofileView.isHidden)
//            {
//                myprofileView.isHidden = false
//                myprofileViewHeight.constant = 200
//            }
//            alertCall(message: "Please enter 10 Digit Mobile number")
//        }
//        else if(pospMobNumTf.text!.count != 10)
//        {
//            alertCall(message: "Please enter 10 Digit Mobile number")
//        }
        
    }
    
    
    /**********************************************************/
    //---<keyboard change for PAN text>---
    @objc func handleTextChange(_ textChange: UITextField) {
        if panTf.text?.count == 5 || panTf.text?.count == 6 || panTf.text?.count == 7 || panTf.text?.count == 8
        {
            panTf.keyboardType = .numberPad
            panTf.reloadInputViews() // need to reload the input view for this work
        } else {
            panTf.keyboardType = .default
            panTf.reloadInputViews()
        }
    }
    //---<end keyboard text change for PAN>---
    
    //---<EmailValidation>---
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
  
    
    
    
    //---<end keyboard text change for PAN>---
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    
//        if(ifscCodeTf.text!.trimmingCharacters(in: .whitespaces).isEmpty){
//
//            return
//        }
        
        if(textField == self.micrCodeTf || textField == self.bankBranchTf || textField == self.bankCityTf || textField == self.bankNameTf)
        {
            getifsccodeAPI()
        }
        
    }
    
    
    func setupUploadDoc(type : Int, srUrl : String){
        
        let srUrl =  srUrl + "?\( Int.random(in: 1...100))"
        switch(type) {
            
        case 1,2 :
            
            print("DOC FBA PHOtograph " + srUrl)
            
            trackDocUploadSuccessEvent(strDocType: "PROFILE PICTURE")
            let remoteImageURL = URL(string: srUrl )!
            self.myaccountImgeView.sd_setImage(with: remoteImageURL )
            
            imgDoc1.image = UIImage(named: "doc_uploaded")

            myaccountImgeView.layer.cornerRadius = 64
            
            docView1Btn.layer.name = srUrl
            docView1Img.isHidden = false
            docView1Btn.isHidden = false
            
          
            break;

       case 3 :
            trackDocUploadSuccessEvent(strDocType: "FBA PAN CARD")
            print("DOC PanCard ")
            imgDoc2.image = UIImage(named: "doc_uploaded")
           
            docView2Btn.layer.name = srUrl
            docView2Img.isHidden = false
            docView2Btn.isHidden = false
            break;
            
       case 4 :
            trackDocUploadSuccessEvent(strDocType: "CANCELLED CHQ")
            print("DOC Cancel Cheque")
            imgDoc3.image = UIImage(named: "doc_uploaded")
           
            docView3Btn.layer.name = srUrl
            docView3Img.isHidden = false
            docView3Btn.isHidden = false
            break;
            
            
        case 5 :
            trackDocUploadSuccessEvent(strDocType: "FBA AADHAR CARD")
            print("DOC Aadhar")
            imgDoc4.image = UIImage(named: "doc_uploaded")

            docView4Btn.layer.name = srUrl
            docView4Img.isHidden = false
            docView4Btn.isHidden = false
            break;
            
     
            
        default:
            print("DOC : No Data")
        }
        
    }

    
    func getCityStateAPI(pincode : String)
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
            let params: [String: AnyObject] = ["PinCode": pincode as AnyObject]
            
            let url = "get-city-and-state"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSDictionary
                let state_name = jsonData?.value(forKey: "state_name") as? String
                self.stateid = (jsonData?.value(forKey: "stateid") as? String ?? "")
                self.stateName = state_name ?? ""
                let cityname = jsonData?.value(forKey: "cityname") as? String
                self.stateTf.text! = state_name!
                self.cityTf.text! = cityname!
                
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
    
  
    
    
    func getifsccodeAPI(){
     
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
                
                
                let parameter  :[String: AnyObject] = [
                    
                    "IFSCCode": ifscCodeTf.text as AnyObject
                  
                ]
                let endUrl = "get-ifsc-code"
                let url =  FinmartRestClient.baseURLString  + endUrl
                print("urlRequest= ",url)
                print("parameter= ",parameter)
                Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                    switch response.result {
                        
                    case .success(let value):
                        
                        alertView.close()
                        
                        self.view.layoutIfNeeded()
                        guard let data = response.data else { return }
                        do {
                            let decoder = JSONDecoder()
                            let obj = try decoder.decode(IFSCModel.self, from: data)
                            
                            
                          
                            print("response= ",obj)
                            
                         
                            
                            if obj.StatusNo == 0 {
                            
                                
                                var  micrCode = obj.MasterData[0]?.micrCode ?? ""
                                self.micrCodeTf.text! = micrCode
                                
                                self.bankBranchTf.text! = obj.MasterData[0]?.bankBran ?? ""
                                self.bankCityTf.text! = obj.MasterData[0]?.bankCity ?? ""
                                self.bankNameTf.text! = obj.MasterData[0]?.bankName ?? ""
                                
                                if( micrCode.isEmpty){
                                    
                                  // For Focus
                                    //self.ifscCodeTf.becomeFirstResponder()
                                   
                                    // for Hiding
                                    self.ifscCodeTf.endEditing(true)
                                    let snackbar = TTGSnackbar.init(message: "No Data Found" , duration: .long)
                                    snackbar.show()
                                    
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
    
    //---<APICALL>---

    func uploaddocAPI(documentName:String, documentType:String)
    {
        
       
        if Connectivity.isConnectedToInternet()
        {
        
        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
           
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
        
//        if UIImageJPEGRepresentation(self.pickedImage,1) != nil {
        let imageData = pickedImage.jpegData(compressionQuality: 1)
        if imageData != nil
        {
            let parameters = [
                "FBAID":FBAId,
                "DocType":documentType,
                "DocName":documentName,
                "DocFile":"swift_file.jpeg"
            ]
            
            let endUrl = "upload-doc"
            let url =  FinmartRestClient.baseFileUploadURLString  + endUrl
            let headers: HTTPHeaders = [
                   "Content-Type": "application/json",
                   "token": "1234567890"
               ]
               
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(imageData!, withName: "DocFile", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    
                }
            }, to: url, method: .post, headers: headers)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                   
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                        
                        if let parentView = self.navigationController?.view
                        {
                            alertView.parentView = parentView
                        }
                        else
                        {
                            alertView.parentView = self.view
                        }
                        alertView.show()
                    })
                    
                    upload.responseJSON { response in
                        //self.delegate?.showSuccessAlert()
                        print(response.request!)  // original URL request
                        print(response.response!) // URL response
                        print(response.data!)     // server data
                        print(response.result)   // result of response serialization
                      
                        alertView.close()
                       // self.view.layoutIfNeeded()
                        
                        if let jsonData = response.result.value as? NSDictionary {
                            
                           let Status = (jsonData as AnyObject).value(forKey: "StatusNo") as? Int ?? 1
                           let Message = (jsonData as AnyObject).value(forKey: "Message") as? String ?? ""
                            
                            if (Status  ==  0){
                                
                                let jsonMasterData = (jsonData as AnyObject).value(forKey: "MasterData") as! NSArray
                                
                                print("URL: \(jsonMasterData)")
                                
                               let prv_file = (jsonMasterData[0] as AnyObject).value(forKey: "prv_file") as! String
                                let resultMssg = (jsonMasterData[0] as AnyObject).value(forKey: "Message") as! String
                                
                                print("URL: prv_file \(prv_file)")
                                self.setupUploadDoc(type: Int(documentType)!, srUrl: prv_file)

                                let snackbar = TTGSnackbar.init(message: resultMssg, duration: .middle )
                                snackbar.show()
                            }else{
                                
                                let snackbar = TTGSnackbar.init(message: Message , duration: .middle )
                                snackbar.show()
                                
                            }
                            
                        }
                        
                        
                    }
                    
                case .failure(let encodingError):
                   
                    print(encodingError)
                    let snackbar = TTGSnackbar.init(message: "Doc Not Uploaded. Please try again", duration: .middle )
                                          snackbar.show()
                }
                
            }

            }
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
        //-----<Multipart image Upload>------
        
    }
    
    
    
    func uploaddocAPIOLDLogic(documentName:String, documentType:String)
    {
        
       
//        if Connectivity.isConnectedToInternet()
//        {
//
//            let FBAId = UserDefaults.standard.string(forKey: "FBAId")
//
//            //        if UIImageJPEGRepresentation(self.pickedImage,1) != nil {
//            let imageData = pickedImage.jpegData(compressionQuality: 1)
//            if imageData != nil
//            {
//                let parameters = [
//                    "FBAID":FBAId,
//                    "DocType":documentType,
//                    "DocName":documentName,
//                    "DocFile":dataImage
//                ]
//
//                let endUrl = "/api/upload-doc"
//                let url =  FinmartRestClient.baseURLString  + endUrl
//
//                Alamofire.upload(multipartFormData: { (multipartFormData) in
//                    //            multipartFormData.append(UIImageJPEGRepresentation(self.pickedImage.image!, 0.5)!, withName: "photo_path", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                    multipartFormData.append(imageData!, withName: "photo_path", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                    for (key, value) in parameters {
//                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//
//                    }
//                }, to: url)
//                { (result) in
//                    switch result {
//                    case .success(let upload, _, _):
//
//                        upload.uploadProgress(closure: { (Progress) in
//                            print("Upload Progress: \(Progress.fractionCompleted)")
//                        })
//
//                        upload.responseJSON { response in
//                            //self.delegate?.showSuccessAlert()
//                            print(response.request!)  // original URL request
//                            print(response.response!) // URL response
//                            print(response.data!)     // server data
//                            print(response.result)   // result of response serialization
//                            //                        self.showSuccesAlert()
//                            //self.removeImage("frame", fileExtension: "txt")
//                            if let JSON = response.result.value {
//                                print("JSON: \(JSON)")
//                            }
//                        }
//
//                    case .failure(let encodingError):
//                        //self.delegate?.showFailAlert()
//                        print(encodingError)
//                    }
//
//                }
//
//            }
//        }else{
//            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
//            snackbar.show()
//        }
//
        
      
        
    }
    func getmyaccountAPI()
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
        
        let params: [String: AnyObject] = [ "FBAID":FBAId as AnyObject]
        
        let url = "get-my-account"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Designation = (jsonData![0] as AnyObject).value(forKey: "Designation") as AnyObject
            self.designationTf.text! = Designation as! String
            let EditMobiNumb = (jsonData![0] as AnyObject).value(forKey: "EditMobiNumb") as AnyObject
            self.mobilenotoshareTf.text! = EditMobiNumb as! String
            let EditEmailId = (jsonData![0] as AnyObject).value(forKey: "EditEmailId") as AnyObject
            self.emailtoshareTf.text! = EditEmailId as! String
            
            
            let Address_1 = (jsonData![0] as AnyObject).value(forKey: "Address_1") as AnyObject
            self.address1Tf.text! = Address_1 as! String
            let Address_2 = (jsonData![0] as AnyObject).value(forKey: "Address_2") as AnyObject
            self.address2Tf.text! = Address_2 as! String
            let Address_3 = (jsonData![0] as AnyObject).value(forKey: "Address_3") as AnyObject
            self.address3Tf.text! = Address_3 as! String
            let PinCode = (jsonData![0] as AnyObject).value(forKey: "PinCode") as AnyObject
            self.pincodeTf.text! = PinCode as! String
            let City = (jsonData![0] as AnyObject).value(forKey: "City") as AnyObject
            self.cityTf.text! = City as! String
            let StateName = (jsonData![0] as AnyObject).value(forKey: "StateName") as AnyObject
            if (StateName is NSNull){
                self.stateTf.text! = ""
            }else{
                self.stateTf.text! = StateName as! String
            }
            
            
            
            let LoanName = (jsonData![0] as AnyObject).value(forKey: "LoanName") as AnyObject
            self.accountHolderNameTf.text! = LoanName as! String
            let Loan_PAN = (jsonData![0] as AnyObject).value(forKey: "Loan_PAN") as AnyObject
            self.panTf.text! = Loan_PAN as! String
            let Loan_Aadhaar = (jsonData![0] as AnyObject).value(forKey: "Loan_Aadhaar") as AnyObject
            self.addharTf.text! = Loan_Aadhaar as! String
            let Loan_BankAcNo = (jsonData![0] as AnyObject).value(forKey: "Loan_BankAcNo") as AnyObject
            self.bankaccnoTf.text! = Loan_BankAcNo as! String
            let Loan_IFSC = (jsonData![0] as AnyObject).value(forKey: "Loan_IFSC") as AnyObject
            self.ifscCodeTf.text! = Loan_IFSC as! String
            let Loan_MICR = (jsonData![0] as AnyObject).value(forKey: "Loan_MICR") as AnyObject
            self.micrCodeTf.text! = Loan_MICR as! String
            let Loan_BankBranch = (jsonData![0] as AnyObject).value(forKey: "Loan_BankBranch") as AnyObject
            self.bankBranchTf.text! = Loan_BankBranch as! String
            let Loan_BankName = (jsonData![0] as AnyObject).value(forKey: "Loan_BankName") as AnyObject
            self.bankNameTf.text! = Loan_BankName as! String
            let Loan_BankCity = (jsonData![0] as AnyObject).value(forKey: "Loan_BankCity") as AnyObject
            self.bankCityTf.text! = Loan_BankCity as! String
            
            // 05
           let Loan_Account_Type = (jsonData![0] as AnyObject).value(forKey: "Loan_Account_Type") as AnyObject
            
            self.setAccountType(type: Loan_Account_Type as! String)
           
            let POSPNo = (jsonData![0] as AnyObject).value(forKey: "POSPNo") as AnyObject
            self.pospNoLbl.text! = POSPNo as! String
            let FBAID = (jsonData![0] as AnyObject).value(forKey: "FBAID") as AnyObject
            self.fbaIdLbl.text! = FBAID as! String
            
            
            let Gender = (jsonData![0] as AnyObject).value(forKey: "Gender") as AnyObject
            let DOB = (jsonData![0] as AnyObject).value(forKey: "DOB") as AnyObject
            
            let DisplayDesignation = (jsonData![0] as AnyObject).value(forKey: "DisplayDesignation") as AnyObject
            self.pospDesignTf.text! = DisplayDesignation as! String
            let DisplayPhoneNo = (jsonData![0] as AnyObject).value(forKey: "DisplayPhoneNo") as AnyObject
            self.pospMobNumTf.text! = DisplayPhoneNo as! String
            let DisplayEmail = (jsonData![0] as AnyObject).value(forKey: "DisplayEmail") as AnyObject
            self.pospemailTf.text! = DisplayEmail as! String
            let FullName = (jsonData![0] as AnyObject).value(forKey: "FullName") as AnyObject
            self.fbaNameLbl.text! = FullName as! String
            //<user-constant Param>
            let LoginID = UserDefaults.standard.string(forKey: "LoginID")
            let ManagName = UserDefaults.standard.string(forKey: "ManagName")
            let POSP_STATUS = UserDefaults.standard.string(forKey: "POSP_STATUS")
            let MangEmail = UserDefaults.standard.string(forKey: "MangEmail")
            let MangMobile = UserDefaults.standard.string(forKey: "MangMobile")
            let SuppEmail = UserDefaults.standard.string(forKey: "SuppEmail")
            let SuppMobile = UserDefaults.standard.string(forKey: "SuppMobile")

            self.managerNameLbl.text! = ManagName!
            self.loginIdLbl.text! = LoginID!
            self.pospStatusLbl.text! = POSP_STATUS!
            self.abtmeemailLbl.text! = MangEmail!
            self.abtmeMobnoLbl.text! = MangMobile!
            self.spprtMobNoLbl.text! = SuppMobile!
            self.spportEmailLbl.text! = SuppEmail!
            
            self.setWebEnagageUser(mob: DisplayPhoneNo as? String ?? "" , email: DisplayEmail as? String ?? "", gender: Gender as? String ?? "" , dob: DOB as? String ?? "")
            
     /*********************DOC Availabilty From server ***********************************/
          
            let doc = (jsonData![0] as AnyObject).value(forKey: "doc_available") as? NSArray
            
            if(doc?.count ?? 0 > 0){
                
                self.profileDocModel = [pospDoc]()
                for index in 0...(doc?.count ?? 0)-1 {
                    
                    let aObject = doc?[index] as! [String : AnyObject]
                    
                    let DocType = (doc![index] as AnyObject).value(forKey: "DocType") as! Int
                    
                    let FileName = (doc![index] as AnyObject).value(forKey: "FileName") as! String
                
                    self.setupUploadDoc(type : DocType, srUrl: FileName)   // Set the Doc URL
                    
                    
                    let model = pospDoc(DocType:  aObject["DocType"] as! Int ,            // Bind the all doc
                        FileName: aObject["FileName"] as! String,
                        DocName: aObject["DocName"] as! String
                    )
                    
                    self.profileDocModel.append(model)
                }
                

                
            }
            
              /********************* end DOC ***********************************/
            
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
    
    
    func myaccountAPI()
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
        let params: [String: AnyObject] = [
                                            "Type": "0" as AnyObject,
                                           
                                          
                                            "CustID": 0 as AnyObject,
                                         
                                            "FBAID": fbaIdLbl.text! as AnyObject,
                                            "FBALiveID": 0 as AnyObject,
                                            "FBAPan": "" as AnyObject,
                                            "FBAStat": "" as AnyObject,
                                            
                                            ////////**********Profile***********///////
                                            "FBA_Designation": designationTf.text!.trimmingCharacters(in: .whitespaces) as AnyObject,
                                            "Mobile_1": mobilenotoshareTf.text! as AnyObject,
                                             //"Mobile_2": "" as AnyObject,
                                            "EmailId": emailtoshareTf.text! as AnyObject,
                                           
                                             ////////********** POSP ***********///////
            
                                            "DisplayDesignation": pospDesignTf.text!.trimmingCharacters(in: .whitespaces) as AnyObject,
                                            "DisplayEmail":  pospemailTf.text! as AnyObject,
                                            "DisplayPhoneNo": pospMobNumTf.text! as AnyObject,
            
            
                                            ////////**********Designation***********///////
                                            "Address_1": address1Tf.text! as AnyObject,
                                            "Address_2": address2Tf.text! as AnyObject,
                                            "Address_3": address3Tf.text! as AnyObject,
                                            "PinCode": pincodeTf.text! as AnyObject,
                                            "City": cityTf.text! as AnyObject,
                                            "State": stateTf.text! as AnyObject,
                                            "StateID": "" as AnyObject,     //05
            
                                         ////////**********Bank Details ***********///////
            
            
                                            "Loan_FirstName": accountHolderNameTf.text!.trimmingCharacters(in: .whitespaces) as AnyObject,
                                            "Loan_PAN": panTf.text! as AnyObject,
                                            "Loan_Aadhaar": addharTf.text! as AnyObject,
                                            "Loan_BankAcNo": bankaccnoTf.text! as AnyObject,
                                            "Loan_IFSC": ifscCodeTf.text! as AnyObject,
                                            
                                            "Loan_MICR": micrCodeTf.text! as AnyObject,
                                            "Loan_BankName": bankNameTf.text! as AnyObject,
                                            "Loan_BankBranch": bankBranchTf.text! as AnyObject,
                                            "Loan_BankCity": bankCityTf.text! as AnyObject,
                                            "Loan_Account_Type": accountType as AnyObject,
                                            
                                           // "DOB": "" as AnyObject,
                                            
//                                            "AppSource": "" as AnyObject,
//                                            "Bonds": "" as AnyObject,
//                                            "Bonds_Comp": "" as AnyObject,
//                                            "BrokID": 0 as AnyObject,
                                           //  "Loan_LastName": "" as AnyObject,
//                                            "FirstName": "" as AnyObject,
//                                            "GIC_Comp": "" as AnyObject,
//                                            "GIC_Comp_ID": "" as AnyObject,
//                                            "GSTNumb": "" as AnyObject,
//                                            "Gender": "" as AnyObject,
//                                            "Health_Comp": "" as AnyObject,
//                                            "Health_Comp_ID": "" as AnyObject,
//                                            "IsFOC": "" as AnyObject,
//                                            "IsGic": "" as AnyObject,
//                                            "IsHealth": "" as AnyObject,
//                                            "IsLic": "" as AnyObject,
//                                            "LIC_Comp": "" as AnyObject,
//                                            "LIC_Comp_ID": "" as AnyObject,
//                                            "LastName": "" as AnyObject,
//                                            "Link": "null" as AnyObject,
            
//
//                                            "MF": "" as AnyObject,
//                                            "MF_Comp": "" as AnyObject,
//
//                                            "Other_Aadhaar": "" as AnyObject,
//                                            "Other_Account_Type": "" as AnyObject,
//                                            "Other_BankAcNo": "" as AnyObject,
//                                            "Other_BankBranch": "" as AnyObject,
//                                            "Other_BankCity": "" as AnyObject,
//                                            "Other_BankID": 0 as AnyObject,
//                                            "Other_BankName": "" as AnyObject,
//                                            "Other_FirstName": "" as AnyObject,
//                                            "Other_IFSC": "" as AnyObject,
//                                            "Other_LastName": "" as AnyObject,
//                                            "Other_MICR": "" as AnyObject,
//                                            "Other_PAN": "" as AnyObject,
//                                            "POSPID": 0 as AnyObject,
//                                            "ParentId": "0" as AnyObject,
//
//                                            "Posp_Aadhaar": "" as AnyObject,
//                                            "Posp_Account_Type": "" as AnyObject,
//                                            "Posp_Address1": "" as AnyObject,
//                                            "Posp_Address2": "" as AnyObject,
//                                            "Posp_Address3": "" as AnyObject,
//                                            "Posp_BankAcNo": "" as AnyObject,
//                                            "Posp_BankBranch": "" as AnyObject,
//                                            "Posp_BankCity": "" as AnyObject,
//                                            "Posp_BankID": 0 as AnyObject,
//                                            "Posp_BankName": "" as AnyObject,
//                                            "Posp_ChanPartCode": "" as AnyObject,
//                                            "Posp_City": "" as AnyObject,
//                                            "Posp_DOB": "" as AnyObject,
//                                            "Posp_Email": pospemailTf.text! as AnyObject,
//                                            "Posp_FirstName": "" as AnyObject,
//                                            "Posp_Gender": "" as AnyObject,
//                                            "Posp_IFSC": "" as AnyObject,
//                                            "Posp_LastName": "" as AnyObject,
//                                            "Posp_MICR": "" as AnyObject,
//                                            "Posp_Mobile1": pospMobNumTf.text! as AnyObject,
//                                            "Posp_Mobile2": "" as AnyObject,
//                                            "Posp_PAN": "" as AnyObject,
//                                            "Posp_PinCode": "" as AnyObject,
//                                            "Posp_ServiceTaxNo": "" as AnyObject,
//                                            "Posp_StatID": "" as AnyObject,
//                                            "Postal": "" as AnyObject,
//                                            "Postal_Comp": "" as AnyObject,
//                                            "SMID": 0 as AnyObject,
//                                            "SM_Name": "" as AnyObject,
//                                            "StatActi": "" as AnyObject,
//
//                                            "Stock": "" as AnyObject,
//                                            "Stock_Comp": "" as AnyObject,
//
//                                            "VersionCode": Configuration.appVersion as AnyObject,
//                                            "password": "" as AnyObject,
//                                            "referedby_code": "null" as AnyObject
            
                                 ]
        
        let url = "my-account"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            TTGSnackbar.init(message: "Profile updated successfully", duration: .long).show()
            
            
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
    
    
    
    //----<buttonColor>----
    func btnColorChangeBlue(Btn:UIButton)
    {
        let borderColor = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=2.0;
        Btn.layer.borderColor=borderColor.cgColor;
        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
    
    func btnColorChangeGray(Btn:UIButton)
    {
        let borderColr = UIColor.gray
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=2.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func viewColorblue(view:UIView)
    {
        let borderColor = UIColor(red: 0/255, green: 51/255, blue: 91/255, alpha: 1.0)
        view.layer.borderWidth=1.0;
        view.layer.borderColor=borderColor.cgColor;
    }
    
    
    
  
    
}

extension profileVC {
    
    
    func trackMyAccountSubmitEvent(){
        
        var eventAttributes: [String: Any] = [:]
        eventAttributes["Section"] = "My Account"

        // Track the login event using WebEngageHelper
        WebEngageAnaytics.shared.trackEvent("Bank Details Submitted",  eventAttributes)
        
        
    }
    
    func trackDocUploadEvent(strDocType: String) {
        // Create event attributes
        var eventAttributes: [String: Any] = [:]
        eventAttributes["Section"] = "My Account "
        eventAttributes["Document Type"] = strDocType

        // Track the login event using WebEngageHelper
        WebEngageAnaytics.shared.trackEvent("Document Upload Initiated",  eventAttributes)
    }

    func trackDocUploadSuccessEvent(strDocType: String) {
        // Create event attributes
        var eventAttributes: [String: Any] = [:]
        eventAttributes["Section"] = "My Account "
        eventAttributes["Document Type"] = strDocType

        // Track the login event using WebEngageHelper
        WebEngageAnaytics.shared.trackEvent("Document Uploaded Successfully",  eventAttributes)
    }
}
    
