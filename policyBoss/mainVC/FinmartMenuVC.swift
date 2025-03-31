//
//  FinmartMenuVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 15/12/18.
//  Copyright © 2018 rahulc . All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import WebKit
//import CobrowseIO
import SafariServices
import SwiftUI

class FinmartMenuVC: UIViewController,UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate,HomeDelegate {
   
    
    
    //UIScrollViewDelegate
    
    @IBOutlet weak var menuTV: UITableView!
    @IBOutlet weak var menuprofileImgView: UIImageView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fbaIdLbl: UILabel!
    @IBOutlet weak var refcodeLbl: UILabel!
    @IBOutlet weak var pospNoLbl: UILabel!
    @IBOutlet weak var erpIdLbl: UILabel!
    
    var addType = ""
    
    
    
    // @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var versionLbl: UILabel!
    // var myFinItems = ["SHARE SCREEN","HOME","MY FINBOX","FINPERKS"]
    var myFinItems = ["HOME"]
    var myFinImages = ["home.png"]
    
    var myaccountItems = ["My Profile","Enrol as POSP","Change Password"]    // 1
    var myaccountImages = ["vector_person.png","posp_enrollment.png","change_password.png"]
    
    
    var myaccountItems2 = ["My Profile","Change Password"]                  // 2
    var myaccountImages2 = ["vector_person.png","change_password.png"]
    
    var mydocumentItems = ["POSP Appointment Letter","POSP Application Form"]
    var mydocumentImges = ["agreemnet.png","agreemnet.png","agreemnet.png"]
    
    var transactionsItems = ["My Insurance Business","Get Policy by CRN"]
    var transactionImges = ["ic_business_name.png","insurance_policy_ic.png"]
    
    var transactionsItems2 = ["Get Policy by CRN"]
    var transactionImges2 = ["insurance_policy_ic.png"]
    
    
    var leadsItems = ["Lead Dashboard"]
    var leadsImges = ["insurance_policy_ic.png"]
    
    
    var loansItems = ["Referral Agreement","Free Credit Report"]
    var loansImges = ["agreemnet.png","agreemnet.png"]
    
    var otherutilitiesItems = ["MY UTILITIES"]
    var otherImges = ["posp_training.png"]
    
    var legalItems = ["Disclosure","Privacy Policy","LOG-OUT"]
    var legalImges = ["posp_training.png","agreemnet.png","logout.png"]
    
    //    var earningtoolsItmes = ["Loan Agreement","Income Calculator","Income Potential"]
    
    
    var earningToolImges = ["mps.png","income_calculator_ic.png","income_potential_ic.png"]
    

    var attendanceItems = ["Add Attendance","My Location","Report"]
    
    
    var pospImges = ["posp_enrollment.png","posp_enrollment.png"]
    var requestImges = ["insurance_policy_ic.png","insurance_policy_ic.png"]
 
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var fromScreen = ""
    var appaccessStatus = ""
    var isfirstLogin = Int()
    var enableenrolasPOSP = ""
    var enable_pro_Addsubuser_url = ""
    var showmyinsurancebusiness = ""
    var FOSStatus = ""
   // var AddPospVisible = ""
    var Menu_addPospVisible = ""
    var MenufosUser = ""
    
   
   
    
    // For AlertDialog
    let alertService = AlertService()
    
    lazy var menuSectionList =  [MenuSection]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
           let indexPath = IndexPath(row: 0, section: 0)
        menuTV.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        //menuTV.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLbl.text =  Configuration.menuappVersion
        
        // MainScrollView.isScrollEnabled = false
        
       
        //--<api>--
       
        bindMenuData()
       
        
        
    }
    
   
    
    
    
    
    func deSelectDashboard(){
        
        if let index = menuTV.indexPathForSelectedRow{
            self.menuTV.deselectRow(at: index, animated: true)
        }
    }
    
    
    
    
    @IBAction func menuViewBtnCliked(_ sender: Any)
    {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    //--<roundImageView>--
    override func viewDidLayoutSubviews()
    {
        menuprofileImgView.layer.cornerRadius = menuprofileImgView.frame.size.width/2
        menuprofileImgView.clipsToBounds = true
    }
    
    @IBAction func knowUrFinmartBtnCliked(_ sender: Any)
    {
        
        
        let url = UserDefaults.standard.string(forKey: "notificationpopupurl")
        
        guard let popupUrl = url else {
            return
        }
        let alertWebVC = self.alertService.alertWebView(webURL: popupUrl)
        self.present(alertWebVC, animated: true)
        
    }
    
    @IBAction func menuhomeBtnCliked(_ sender: Any)
    {
        
        // self.moveToHome()
        
    }
    
    @IBAction func myFinboxBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "myFinbox"
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.modalTransitionStyle = .coverVertical
        
        present(commonWeb, animated: false, completion: nil)
        
        
    }
    
    @IBAction func myFinperksBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.webfromScreen = "Finperks"
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.modalTransitionStyle = .coverVertical
        present(commonWeb, animated: false, completion: nil)
    }
    
    
    //-----<tableView Datasource+Deleagtes>-----
    func numberOfSections(in tableView: UITableView) -> Int {
        //        if(self.appaccessStatus == "Active"){
        //            return 7
        //        }
        //        else{
        //            return 6
        //        }
        
        return menuSectionList.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //region commented
//        if(section == 0){
//            return myFinItems.count
//        }else if(section == 1){
//            if(self.enableenrolasPOSP == "1"){
//                return myaccountItems.count
//            }
//            else if(self.enableenrolasPOSP == "0"){
//                return myaccountItems2.count
//            }
//            return myaccountItems2.count
//        }
//        else if(section == 2){
//            return mydocumentItems.count
//        }
//        else if(section == 3){
//
//            if(self.showmyinsurancebusiness == "1"){
//                return transactionsItems.count
//            }
//            else if(self.showmyinsurancebusiness == "0"){
//                return transactionsItems2.count
//            }
//            return transactionsItems2.count
//        }
//        else if(section == 4){
//            return leadsItems.count
//        }
//
//        else if(section == 5){
//            return otherutilitiesItems.count
//        }
//        else if(section == 6){
//
//            return legalItems.count
//        }
//        return 0
        
        //endregion
        
       // print("MENU COUNT \(menuSectionList.count) ")
        return menuSectionList[section].menuModel.count

        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! finmartMenuCell
        cell.textLabel?.textColor = UIColor.gray
        
        cell.configureCell(menu: menuSectionList[indexPath.section].menuModel[indexPath.row])
       
     

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    //    override func updateViewConstraints() {
    //        tableHeightConstraint.constant = tableView.contentSize.height
    //        super.updateViewConstraints()
    //
    //    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView =  UIView()
        headerView.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 10, width: 200, height: 30)
        
        label.text = menuSectionList[section].section
       

        
        //        label.font = UIFont().futuraPTMediumFont(16) // my custom font
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //        label.textColor = UIColor.charcolBlackColour() // my custom colour
        label.textColor = UIColor.gray
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:UIView =  UIView()
        footerView.backgroundColor = UIColor.lightGray
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // close the drawer
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: false)
        }
        
        
        if (!Connectivity.isConnectedToInternet()) {
           
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
             snackbar.show()

            return
        }
            
        switch menuSectionList[indexPath.section].menuModel[indexPath.row].mId
        {
        
        /***************************** Home SECTION ******************************/
        case "nav_home" :
            
                           NotificationCenter.default.post(name: .NotifyMyAccountProfile, object: nil)
                          
                          print("NNN : Notification start")
                          
                          self.dismissAll(animated: false)
            
    
//        case "nav_attendance" :
//
//
//            let mySwiftUIView = UIHostingController(rootView: LocationAttendanceNew())
//
//            mySwiftUIView.modalPresentationStyle = .fullScreen
//           // mySwiftUIView.modalTransitionStyle = .coverVertical
//
//            present(mySwiftUIView, animated: false, completion: nil)
            
        case "nav_authToken":
            
            
            
            NotificationCenter.default.post(name: .NotifyLoginToken, object: nil)
           
           print("NNN : Notification start")
           
           self.dismissAll(animated: false)
            
         
        /*****************************  MY ACCOUNT SECTION ******************************/
        case "nav_MyProfile" :
            
            let profile : profileVC = self.storyboard?.instantiateViewController(withIdentifier: "stbprofileVC") as! profileVC
                           profile.modalPresentationStyle = .fullScreen
                           profile.modalTransitionStyle = .coverVertical
                           present(profile, animated: false, completion: nil)
        
      
        case "nav_EnrolPosp" :
            
           
            
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = ScreenName.pospEnrollment
            present(commonWeb, animated: false, completion: nil)
          
       
        case "nav_AddSubUser" :
            
            
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = ScreenName.addSubUser
            present(commonWeb, animated: false, completion: nil)

            
            
        case "nav_RaisedTicket" :
        
//            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//            commonWeb.modalPresentationStyle = .fullScreen
//            commonWeb.modalTransitionStyle = .coverVertical
//            commonWeb.webfromScreen = ScreenName.RaiseTicket
//            present(commonWeb, animated: false, completion: nil)
          
            
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = ScreenName.RaiseTicket
            present(commonWeb, animated: false, completion: nil)
            
        case "nav_ChangePwd" :
            
            let changePasswrd : changePasswrdVC = self.storyboard?.instantiateViewController(withIdentifier: "stbchangePasswrdVC") as! changePasswrdVC
                               changePasswrd.modalPresentationStyle = .fullScreen
                               changePasswrd.modalTransitionStyle = .coverVertical
                               present(changePasswrd, animated: false, completion: nil)
         
        /*****************************  MY DOCUMENT SECTION ******************************/
        case "nav_PospAppointmentLetter" :
           
            let incmCalculatr : incmCalculatrVC = self.storyboard?.instantiateViewController(withIdentifier: "stbincmCalculatrVC") as! incmCalculatrVC
            incmCalculatr.modalPresentationStyle = .fullScreen
            incmCalculatr.modalTransitionStyle = .coverVertical
            incmCalculatr.fromScreen = "appoinLetter"
            present(incmCalculatr, animated: false, completion: nil)
            
            
        case "nav_PospAppointmentForm" :
           
            let incmCalculatr : incmCalculatrVC = self.storyboard?.instantiateViewController(withIdentifier: "stbincmCalculatrVC") as! incmCalculatrVC
            incmCalculatr.modalPresentationStyle = .fullScreen
            incmCalculatr.modalTransitionStyle = .coverVertical
            incmCalculatr.fromScreen = "ApplictnForm"
            present(incmCalculatr, animated: false, completion: nil)
            
         
        /*****************************  MY TRANSACTION SECTION ******************************/
        case "nav_MyInsuranceBusiness" :
            
            let commonWeb : InsuranceBussWebVC = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceBussWebVC") as! InsuranceBussWebVC
                               commonWeb.modalPresentationStyle = .fullScreen
                               commonWeb.modalTransitionStyle = .coverVertical
                               commonWeb.webfromScreen = "InsuranceBusiness"
                               present(commonWeb, animated: false, completion: nil)
            
        case "nav_MyTransaction" :
             print("nav_MyTransaction")
          
            let transactionVC : TransactionVC = storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
            transactionVC.modalPresentationStyle = .fullScreen
            transactionVC.modalTransitionStyle = .coverVertical
            present(transactionVC, animated: false, completion: nil)
        case "nav_LeadDashboard" :
            
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = "leadDashboard"
            present(commonWeb, animated: false, completion: nil)
          
        case "nav_SmsTemp" :
            
            print("nav_MyTransaction")
         
           let smsTemplateVC : smsTemplateVC = storyboard?.instantiateViewController(withIdentifier: "stbsmsTemplateVC") as! smsTemplateVC
            smsTemplateVC.modalPresentationStyle = .fullScreen
            smsTemplateVC.modalTransitionStyle = .coverVertical
            present(smsTemplateVC, animated: false, completion: nil)
         
        case "nav_MyUtilities" :
            
            WebEngageAnaytics.shared.trackEvent("Clicked My Utilities on Options Menu")


            let addUsersV : addUsersVC = storyboard?.instantiateViewController(withIdentifier: "stbaddUsersVC") as! addUsersVC
            addUsersV.modalPresentationStyle = .fullScreen
            addUsersV.modalTransitionStyle = .coverVertical
            addUsersV.fromScreen = "myUtilities"
            present(addUsersV, animated: false, completion: nil)
            
        case "nav_Disclosure" :
           
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = "DISCLOSURE"
            present(commonWeb, animated: false, completion: nil)

            
        case "nav_PrivacyPolicy" :
            
            WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.PrivacyScreen)

         
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.modalTransitionStyle = .coverVertical
            commonWeb.webfromScreen = "PrivacyPolicy"
            present(commonWeb, animated: false, completion: nil)

            
        case "nav_Logout" :
            
            callAlertView()
            
        default:
            print("Default")
        }
        
        
        
    }
    //-----<end tableView Datasource+Deleagtes>-----
    
    
    
  
    
    //---<APICALL>---
    func CheckAppAccessAPI()
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
            
            let iosuid = UserDefaults.standard.string(forKey: "iosuid")
            //        print("iosuid=",iosuid!)
            let deviceID = Configuration.deviceID
            
            let params: [String: AnyObject] = ["uid": iosuid as AnyObject,
                                               "DeviceId": deviceID as AnyObject,
                                               "DeviceToken":"t2" as AnyObject]
            
            let url = "/AttendanceDetails.svc/CheckAppAccess_IOS"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSDictionary
                
                let empstatus = jsonData?.value(forKey: "empstatus") as AnyObject
                self.appaccessStatus = empstatus as! String
                let isfirstlogin = jsonData?.value(forKey: "isfirstlogin") as AnyObject
                self.isfirstLogin = isfirstlogin as! Int
                // let lat = jsonData?.value(forKey: "lat") as AnyObject
                // let lng = jsonData?.value(forKey: "lng") as AnyObject
                let hrmsid = jsonData?.value(forKey: "hrmsid") as AnyObject
                UserDefaults.standard.set(String(describing: hrmsid), forKey: "hrmsid")
                
                self.menuTV.reloadData()
                
            }, onError: { errorData in
                alertView.close()
                let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                snackbar.show()
            }, onForceUpgrade: {errorData in},service: true)
            
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    func bindMenuData(){
        
        
        if(UserDefaults.exists(key: "enableenrolasposp") == false) {
            
            userconstantAPI()
            print("User Constant Called")
        }else{
            
            getUserData()
        }
        
    }
    
  
    
    func getUserData(){
        
        
       
        

        
      //Mark:   actually it get value from horizon dsa api
        let FBAId = UserDefaults.standard.string(forKey: "FBAId") ?? "0"
        
           
        let loansendname = UserDefaults.standard.string(forKey: "FullName") ?? ""
        
        let POSPNo = UserDefaults.standard.string(forKey: "POSPNo") ?? "0"
        let ERPID = UserDefaults.standard.string(forKey: "ERPID") ?? "0"
        let loanselfphoto = UserDefaults.standard.string(forKey: "loanselfphoto") as AnyObject
        let referer_code = UserDefaults.standard.string(forKey: "referer_code") ?? "0"
        
        let userType = Core.shared.getUserType()
        
        let enableenrolasposp = UserDefaults.standard.string(forKey: "enableenrolasposp") as AnyObject
        let showmyinsurancebusiness = UserDefaults.standard.string(forKey: "showmyinsurancebusiness") as AnyObject
        
       
       
        
        
     //   self.AddPospVisible = UserDefaults.standard.string(forKey: Constant.AddsubuserUrl)  ?? ""
        
        
        self.enableenrolasPOSP = enableenrolasposp as! String
        
        self.enable_pro_Addsubuser_url = UserDefaults.standard.string(forKey: Constant.AddsubuserUrl) ?? ""
        
       // self.showmyinsurancebusiness = showmyinsurancebusiness as! String
       

        //self.FOSStatus = UserDefaults.standard.string(forKey: "FOS_USER_AUTHENTICATIONN") ?? ""
       
        UserDefaults.standard.set(String(describing: ERPID), forKey: "ERPID")
        
        
        //Mark: For SubUser Data, we added here 2025
        if( UserDefaultsManager.shared.getSubUserSsId() != "0") {
            
            self.fullNameLbl.text = UserDefaultsManager.shared.getSubUserName()
            self.fbaIdLbl.text! = UserDefaultsManager.shared.getSubUserSubFbaId() ?? ""
            
            self.refcodeLbl.text! =  ""
            

            let userEmail = UserDefaultsManager.shared.getSubUserEmail() ?? ""
            
            WebEngageAnaytics.shared.getWEGUser().login(userEmail)

        }
        else {
            
            self.fullNameLbl.text! = loansendname.uppercased()
            self.fbaIdLbl.text! = FBAId
            self.refcodeLbl.text! = referer_code as? String ?? ""
        }
        
        self.pospNoLbl.text! = POSPNo
        //self.erpIdLbl.text! = ERPID
        self.erpIdLbl.text = (ERPID == "0" || ERPID.isEmpty) ? "" : ERPID
      

        
//        if(loanselfphoto as! String != ""){
//            //loadimages
//            let imgURL = NSURL(string: loanselfphoto as! String)
//            if imgURL != nil {
//                //let data = NSData(contentsOf: (imgURL as URL?)!)
//                
//                self.menuprofileImgView.sd_setImage(with: imgURL as URL?)
//             
//            }
//        }
        
        // 005
        menuSectionList =  MenuDb.shareInstance.getMenuSection(
            isenableenrolasPOSP: self.enableenrolasPOSP ,
            isshowmyinsurancebusiness: self.showmyinsurancebusiness ,
            addSubUserUrl: self.enable_pro_Addsubuser_url,
            fosUser: self.FOSStatus,
            ErpID: ERPID,
            userType: userType
        )
        
        self.menuTV.reloadData()
        
        
    }
    
    func userconstantAPI()
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
            
            let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
            
              let url = "user-constant-pb"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSDictionary
                
               // let loansendname = jsonData?.value(forKey: "loansendname") as AnyObject
               // let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
               // let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
               // let ERPID = jsonData?.value(forKey: "ERPID") as AnyObject
              //  let loanselfphoto = jsonData?.value(forKey: "loanselfphoto") as AnyObject
                
                //005 doubt
                let referer_code = UserDefaults.standard.string(forKey: "referer_code")
                
                let enableenrolasposp = jsonData?.value(forKey: "enableenrolasposp") as AnyObject
                
                let showmyinsurancebusiness = jsonData?.value(forKey: "showmyinsurancebusiness") as AnyObject
                
               // let addPospVisible  = jsonData?.value(forKey: "AddPospVisible") as AnyObject
                
               
              
                self.enableenrolasPOSP = enableenrolasposp as! String
                self.showmyinsurancebusiness = showmyinsurancebusiness as! String
               // self.AddPospVisible = addPospVisible as! String
                
                
                //For Horizon :
                let POSPNo = UserDefaults.standard.string(forKey: "POSPNo") ?? "0"
                let ERPID = UserDefaults.standard.string(forKey: "ERPID") ?? "0"
                let userType = Core.shared.getUserType()
                
                //let loanselfphoto = UserDefaults.standard.string(forKey: "loanselfphoto") ?? ""
              
                   
               let  loansendname = UserDefaults.standard.string(forKey: "FullName") as AnyObject
                
                //for handling subuser : New Added Functinality mar 2025
                if let enableProAddSubUserUrl = jsonData?.value(forKey: "enable_pro_Addsubuser_url") as? String,
                   !enableProAddSubUserUrl.isEmpty {
                    
                    self.enable_pro_Addsubuser_url = enableProAddSubUserUrl
                    UserDefaults.standard.set(enableProAddSubUserUrl, forKey: Constant.AddsubuserUrl)
                } else {
       
                    // Provide a default value (could be an empty string or a preset default)
                    UserDefaults.standard.set("", forKey: DefaultKey.AddsubuserUrl)
                }
                
               // UserDefaults.standard.set(String(describing: ERPID), forKey: "ERPID")
    
                //0005 added here 2025
                self.fullNameLbl.text! = loansendname.uppercased
                self.fbaIdLbl.text! = FBAId ?? ""
                self.pospNoLbl.text! = POSPNo
                self.erpIdLbl.text! = ERPID
                self.refcodeLbl.text! = referer_code ?? ""
                
//                if(loanselfphoto as! String != ""){
//                    //loadimages
//                    let imgURL = NSURL(string: loanselfphoto as! String)
//                    if imgURL != nil {
//
//                        DispatchQueue.main.async {
//                            let data = NSData(contentsOf: (imgURL as URL?)!)
//
//                            self.menuprofileImgView.sd_setImage(with: imgURL as URL?)
//                        }
//
//                    }
//                }
                
                self.FOSStatus = UserDefaults.standard.string(forKey: "FOS_USER_AUTHENTICATIONN") ?? ""
                
               
                self.menuSectionList =  MenuDb.shareInstance.getMenuSection(
                    isenableenrolasPOSP: self.enableenrolasPOSP ,
                    isshowmyinsurancebusiness: self.showmyinsurancebusiness,
                    addSubUserUrl: self.enable_pro_Addsubuser_url  ,
                    fosUser: self.FOSStatus,
                    ErpID: ERPID ,
                    userType: userType)
                
                
               
                
                self.menuTV.reloadData()
                
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
    
   
  
    
    //--<callAlert>--
    
    //Mark: Handle Logout Alert
    func callAlertView()
    {
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: "Do you really want to logout?", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Logout", style: UIAlertAction.Style.default) {
            
            UIAlertAction in
            NSLog("OK Pressed")
            WebEngageAnaytics.shared.getWEGUser().logout()
            self.dismissAll(animated: false)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let Login : LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
            Login.resetDefaults()
            UserDefaultsManager.shared.clearAllUserDefaults() // Clears UserDefaultsManager

            
            Login.modalPresentationStyle = .fullScreen
            
            appDelegate?.window?.rootViewController = Login
            self.present(Login, animated: true, completion: nil)
            
            
          
            //              self.resetDefaults()
            //             UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            //
            
            //  In Swift 5.3: When we use stack Navigation
            //self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        // let dictionary = defaults.dictionaryRepresentation()
        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
        
        // Ensure it's saved
        defaults.synchronize()
        Core.shared.setNewUser()
        
    }
    
    
    func callbackHomeDelegate() {
        
        print("TTT  Call back to Parent ")
        self.userconstantAPI()
       // self.getdynamicappAPI()
        
    }
}


