//
//  DashBoardVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 01/11/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import UIKit

import CustomIOSAlertView
import TTGSnackbar
import SwiftyJSON
import Alamofire
import SDWebImage
import MessageUI
import StoreKit

/*
 
 Round Cornoer:
 https://fluffy.es/rounded-corner-shadow/
 
 */

class DashBoardVC: UIViewController {
    
    
    var dynamicDashboardModel = [DynamicDashboardModel]()
    var loanModel = [DynamicDashboardModel]()
    var moreServiceModel = [DynamicDashboardModel]()
    
     var userDashboardModel = [UserConstDashboarddModel]()
    var callingDashboardModel = [CallingDashboardModel]()     // For Calling
    // For AlertDialog
     let alertService = AlertService()
    
    var MobileNoArray = [String]()
    var EmailIdArry = [String]()
    var EmployeeNameArray = [String]()
    var DesignationArray = [String]()
    var managerName = ""
    var mobNo = ""
    
    @IBOutlet weak var cvSalesmaterial: SCView!
    
    @IBOutlet weak var cvKnowledgeGuru: SCView!
   
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // FOr Hiding Navigation Bar
        self.navigationController?.isNavigationBarHidden = true;
        
        //--<api>--
       // getLoanStaticDashboard()
     
        self.userconstantAPI()
        self.getdynamicappAPI()
        self.getDeviceDetails()
        
        
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.width/2
        imgUserProfile.clipsToBounds = true
        
//            let borderColor = UIColor.black
//            cvSalesmaterial.layer.cornerRadius = 10
//            cvSalesmaterial.clipsToBounds = true
//
//            cvKnowledgeGuru.layer.cornerRadius = 10
//            cvSalesmaterial.clipsToBounds = true
        
        cvSalesmaterial.shadowCorner(radius: 12, color: .black, offset: CGSize(width: 10, height: 10), opacity: 0.7, cornerRadius: 15)
        
        cvKnowledgeGuru.shadowCorner(radius: 12, color: .black, offset: CGSize(width: 10, height: 10), opacity: 0.7, cornerRadius: 15)
       
//
//
        
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
     
        self.cvSalesmaterial.addGestureRecognizer(gesture1)
        self.cvKnowledgeGuru.addGestureRecognizer(gesture2)
       

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        debugPrint("DashBoard Appear")
    }
    
    override func viewDidLayoutSubviews(){
            
            
    }
    
    
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
    }

    @objc func clickAction(sender : UITapGestureRecognizer) {
        
      
        switch sender.view {
          case cvSalesmaterial:
              debugPrint("tapped Image View 1") //add your actions here
            showAlert(message: "tapped Header View 1")
//            let objVC = ScrollDemoVC.shareInstance()
//
//            navigationController?.pushViewController(objVC, animated: true)
          case cvKnowledgeGuru:
            debugPrint("tapped Image View 2") //add your actions here
              showAlert(message: "tapped Header View 2")
     
          default:
              print("Tap not detected")
          
           
          }
        
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnSupportClick(_ sender: Any) {
        
        //showAlert(message: "Support")
        callAlertView()
    }
    
    @IBAction func btnKnowPolicyBoss(_ sender: Any) {
        
        showAlert(message: "Know Your PolicyBosspro")
        
    }
    
    @IBAction func btnSeeAllClick(_ sender: Any) {
        
        showAlert(message: "See All Click")
    }
    
   
    func callAlertView()
    {
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: "Do you really want to logout?", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Logout", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            self.dismissAll(animated: false)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Login : LoginVC = storyboard.instantiateViewController(withIdentifier: "stbLoginVC") as! LoginVC
            Login.resetDefaults()
            
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
        Core.shared.setNewUser()
        
    }
    
    func userconstantAPI()
    
    {
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")

            if(UserDefaults.exists(key: "FBAId") == true) {
                
                let FBAId = UserDefaults.standard.string(forKey: "FBAId")
                
                let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
                
                let url = "user-constant-pb"
                
                FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                    
                    // alertView.close()
                    
                    self.view.layoutIfNeeded()
                    
                    let jsonData = userObject as? NSDictionary
                    
                    guard let jsonString = jsonData else { return }
                    
                    let DashboardArray = jsonData?.value(forKey: "dashboardarray") as! NSArray
                    print("USERCONSTANT DATA",DashboardArray)
                    
                    if(DashboardArray.count > 0){
                        for index in 0...(DashboardArray.count)-1 {
                            let aObject = DashboardArray[index] as! [String : AnyObject]
                            
                            let model = UserConstDashboarddModel(
                                ProdId: aObject["ProdId"] as! String, url: aObject["url"] as! String)
                            
                            self.userDashboardModel.append(model)
                        }
                    }
                    
                    
                    
                    UserDefaults.standard.set(jsonString, forKey: "USERCONSTANT")     // set the data
                    
                    //            let dictData  =  UserDefaults.standard.dictionary(forKey: "USERCONSTANT") as? NSDictionary  // retreive the data
                    //
                    //            let muUID =  dictData?.value(forKey: "uid") as AnyObject
                    //            print("Fetchung Data" ,muUID)
                    
                    let uid = jsonData?.value(forKey: "uid") as AnyObject
                    let iosuid = jsonData?.value(forKey: "iosuid") as AnyObject
                    let emplat = jsonData?.value(forKey: "emplat") as AnyObject
                    let emplng = jsonData?.value(forKey: "emplng") as AnyObject
                    let loanselfemail = jsonData?.value(forKey: "loanselfemail") as AnyObject
                    let loanselfmobile = jsonData?.value(forKey: "loanselfmobile") as AnyObject
                    let loansendname = jsonData?.value(forKey: "loansendname") as AnyObject
                    let LoginID = jsonData?.value(forKey: "LoginID") as AnyObject
                    let ManagName = jsonData?.value(forKey: "ManagName") as AnyObject
                    self.managerName = ManagName as! String
                    let POSP_STATUS = jsonData?.value(forKey: "POSP_STATUS") as AnyObject
                    let MangEmail = jsonData?.value(forKey: "MangEmail") as AnyObject
                    let MangMobile = jsonData?.value(forKey: "MangMobile") as AnyObject
                    let SuppEmail = jsonData?.value(forKey: "SuppEmail") as AnyObject
                    let SuppMobile = jsonData?.value(forKey: "SuppMobile") as AnyObject
                    let FBAId = jsonData?.value(forKey: "FBAId") as AnyObject
                    let loanselfid = jsonData?.value(forKey: "loanselfid") as AnyObject
                    let loansendid = jsonData?.value(forKey: "loansendid") as AnyObject
                    let POSPNo = jsonData?.value(forKey: "POSPNo") as AnyObject
                    let ERPID = jsonData?.value(forKey: "ERPID") as AnyObject
                    let loanselfphoto = jsonData?.value(forKey: "loanselfphoto") as AnyObject
                    let TwoWheelerUrl = jsonData?.value(forKey: "TwoWheelerUrl") as AnyObject
                    let FourWheelerUrl = jsonData?.value(forKey: "FourWheelerUrl") as AnyObject
                    
                    let healthurl = jsonData?.value(forKey: "healthurl") as AnyObject
                    let CVUrl = jsonData?.value(forKey: "CVUrl") as AnyObject
                    let notificationpopupurl = jsonData?.value(forKey: "notificationpopupurl") as AnyObject
                    
                    /// posp
                    let pospsendname = jsonData?.value(forKey: "pospsendname") as AnyObject
                    let pospsendemail = jsonData?.value(forKey: "pospsendemail") as AnyObject
                    let pospsendmobile = jsonData?.value(forKey: "pospsendmobile") as AnyObject
                    let pospsenddesignation = jsonData?.value(forKey: "pospsenddesignation") as AnyObject
                    let pospsendphoto = jsonData?.value(forKey: "pospsendphoto") as AnyObject
                    
                    
                    /// loan
                    
                    let loansendemail = jsonData?.value(forKey: "loansendemail") as AnyObject
                    let loansendmobile = jsonData?.value(forKey: "loansendmobile") as AnyObject
                    let loansenddesignation = jsonData?.value(forKey: "loansenddesignation") as AnyObject
                    let loansendphoto = jsonData?.value(forKey: "loansendphoto") as AnyObject
                    
                    
                    let finperkurl = jsonData?.value(forKey: "finperkurl") as AnyObject
                    let finboxurl = jsonData?.value(forKey: "finboxurl") as AnyObject
                    let PBByCrnSearch = jsonData?.value(forKey: "PBByCrnSearch") as AnyObject
                    let LeadDashUrl = jsonData?.value(forKey: "LeadDashUrl") as AnyObject
                    let enableenrolasposp = jsonData?.value(forKey: "enableenrolasposp") as AnyObject
                    let showmyinsurancebusiness = jsonData?.value(forKey: "showmyinsurancebusiness") as AnyObject
                    
                    let fba_uid = jsonData?.value(forKey: "fba_uid") as AnyObject
                    let fba_campaign_id = jsonData?.value(forKey: "fba_campaign_id") as AnyObject
                    let fba_campaign_name = jsonData?.value(forKey: "fba_campaign_name") as AnyObject
                    
                    let iosversion = jsonData?.value(forKey: "iosversion") as AnyObject
                    
                    let referer_code = UserDefaults.standard.string(forKey: "referer_code") as AnyObject
                    
                    let androidproattendanceEnable = UserDefaults.standard.string(forKey: getSharPrefernce.attendanceEnable) as AnyObject
                    
                    
                    
                    UserDefaults.standard.set(String(describing: uid), forKey: "uid")
                    UserDefaults.standard.set(String(describing: iosuid), forKey: "iosuid")
                    UserDefaults.standard.set(String(describing: emplat), forKey: "emplat")
                    UserDefaults.standard.set(String(describing: emplng), forKey: "emplng")
                    UserDefaults.standard.set(String(describing: loanselfemail), forKey: "loanselfemail")
                    UserDefaults.standard.set(String(describing: loanselfmobile), forKey: "loanselfmobile")
                    
                    UserDefaults.standard.set(String(describing: LoginID), forKey: "LoginID")
                    UserDefaults.standard.set(String(describing: ManagName), forKey: "ManagName")
                    UserDefaults.standard.set(String(describing: POSP_STATUS), forKey: "POSP_STATUS")
                    UserDefaults.standard.set(String(describing: MangEmail), forKey: "MangEmail")
                    UserDefaults.standard.set(String(describing: MangMobile), forKey: "MangMobile")
                    UserDefaults.standard.set(String(describing: SuppEmail), forKey: "SuppEmail")
                    UserDefaults.standard.set(String(describing: SuppMobile), forKey: "SuppMobile")
                    UserDefaults.standard.set(String(describing: FBAId), forKey: "FBAId")
                    UserDefaults.standard.set(String(describing: loanselfid), forKey: "loanselfid")
                    UserDefaults.standard.set(String(describing: loansendid), forKey: "loansendid")
                    UserDefaults.standard.set(String(describing: POSPNo), forKey: "POSPNo")
                    UserDefaults.standard.set(String(describing: ERPID), forKey: "ERPID")
                    UserDefaults.standard.set(String(describing: loanselfphoto), forKey: "loanselfphoto")
                    UserDefaults.standard.set(String(describing: TwoWheelerUrl), forKey: "TwoWheelerUrl")
                    UserDefaults.standard.set(String(describing: FourWheelerUrl), forKey: "FourWheelerUrl")
                    
                    UserDefaults.standard.set(String(describing: healthurl), forKey: "healthurl")
                    UserDefaults.standard.set(String(describing: CVUrl), forKey: "CVUrl")
                    UserDefaults.standard.set(String(describing: notificationpopupurl), forKey: "notificationpopupurl")
                    
                    UserDefaults.standard.set(String(describing: pospsendname), forKey: "pospsendname")
                    UserDefaults.standard.set(String(describing: pospsendemail), forKey: "pospsendemail")
                    UserDefaults.standard.set(String(describing: pospsendmobile), forKey: "pospsendmobile")
                    UserDefaults.standard.set(String(describing: pospsenddesignation), forKey: "pospsenddesignation")
                    UserDefaults.standard.set(String(describing: pospsendphoto), forKey: "pospsendphoto")
                    
                    UserDefaults.standard.set(String(describing: loansendname), forKey: "loansendname")
                    UserDefaults.standard.set(String(describing: loansendemail), forKey: "loansendemail")
                    UserDefaults.standard.set(String(describing: loansendmobile), forKey: "loansendmobile")
                    UserDefaults.standard.set(String(describing: loansenddesignation), forKey: "loansenddesignation")
                    UserDefaults.standard.set(String(describing: loansendphoto), forKey: "loansendphoto")
                    
                    UserDefaults.standard.set(String(describing: finperkurl), forKey: "finperkurl")
                    UserDefaults.standard.set(String(describing: finboxurl), forKey: "finboxurl")
                    UserDefaults.standard.set(String(describing: PBByCrnSearch), forKey: "PBByCrnSearch")
                    UserDefaults.standard.set(String(describing: LeadDashUrl), forKey: "LeadDashUrl")
                    UserDefaults.standard.set(String(describing: enableenrolasposp), forKey: "enableenrolasposp")
                    UserDefaults.standard.set(String(describing: showmyinsurancebusiness), forKey: "showmyinsurancebusiness")
                    
                    UserDefaults.standard.set(String(describing: fba_uid), forKey: "fba_uid")
                    UserDefaults.standard.set(String(describing: fba_campaign_id), forKey: "fba_campaign_id")
                    UserDefaults.standard.set(String(describing: fba_campaign_name), forKey: "fba_campaign_name")
                    
                    UserDefaults.standard.set(String(describing: iosversion), forKey: "iosversion")
                    
                    UserDefaults.standard.set(String(describing: referer_code), forKey: "referer_code")
                    
                    UserDefaults.standard.set(String(describing: androidproattendanceEnable), forKey: getSharPrefernce.attendanceEnable)
                   
                     
                          ///////////////////////////      Verify  Build Version to  Server    /////////////////////////////////////////////////////////
                                            
                              // self.verifyVersion()
                                          
                           ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          
                          
                  
                    
                }, onError: { errorData in
                    // alertView.close()
                    //            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                    //            snackbar.show()
                }, onForceUpgrade: {errorData in})
                
            }else{
                //            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
                //            snackbar.show()
            }
            
        }
        
    }
   
    
    func getdynamicappAPI()
    
    {
        
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
            if(UserDefaults.exists(key: "FBAId") == true) {
                
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
                
              
                let url = "get-dynamic-app-pb"
                
                FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                    alertView.close()
                    
                    
                    self.view.layoutIfNeeded()
                    
                    
                    self.dynamicDashboardModel = [DynamicDashboardModel]()
                    
                    let jsonData = userObject as? NSDictionary
                    let Dashboard = jsonData?.value(forKey: "Dashboard") as! NSArray
                    
                    
                    print("MY DATA",Dashboard)
                    
                    for index in 0...(Dashboard.count)-1 {
                        let aObject = Dashboard[index] as! [String : AnyObject]
                        
                        
                        if(aObject["ProdId"] as! String != "16" && aObject["ProdId"] as! String != "18"  ){
                            
                            
                            if(aObject["dashboard_type"] as! String == "1"){
                                
                                let model = DynamicDashboardModel(menuid: aObject["menuid"] as! Int, menuname: aObject["menuname"] as! String,
                                                                  link: aObject["link"] as! String, iconimage:  aObject["iconimage"] as! String,
                                                                  isActive: aObject["isActive"] as! Int, dashdescription: aObject["description"] as! String,
                                                                  modalType: "INSURANCE" , dashboard_type: aObject["dashboard_type"] as! String,
                                                                  
                                                                  ProdId: aObject["ProdId"] as! String,
                                                                  ProdName: aObject["menuname"] as! String,
                                                                  ProductNameFontColor: aObject["ProductNameFontColor"] as! String, ProductDetailsFontColor: aObject["ProductDetailsFontColor"] as! String,
                                                                  ProductBackgroundColor: aObject["ProductBackgroundColor"] as! String,
                                                                  IsExclusive: aObject["IsExclusive"] as! String,
                                                                  IsNewprdClickable: aObject["IsNewprdClickable"] as! String,
                                                                  IsSharable: aObject["IsSharable"] as! String,
                                                                  popupmsg: aObject["popupmsg"] as! String,
                                                                  title: aObject["title"] as! String,
                                                                  info: aObject["info"] as! String)
                                
                                
                               
                                self.dynamicDashboardModel.append(model)
                                
                            }
                            /*   More Service Commented ...
                            else if(aObject["dashboard_type"] as! String == "3" ){
                                
                                let model = DynamicDashboardModel(menuid: aObject["menuid"] as! Int, menuname: aObject["menuname"] as! String,
                                                                  link: aObject["link"] as! String, iconimage:  aObject["iconimage"] as! String,
                                                                  isActive: aObject["isActive"] as! Int, dashdescription: aObject["description"] as! String,
                                                                  modalType: "MORESERVICE" , dashboard_type: aObject["dashboard_type"] as! String,
                                                                  
                                                                  ProdId: aObject["ProdId"] as! String, ProductNameFontColor: aObject["ProductNameFontColor"] as! String, ProductDetailsFontColor: aObject["ProductDetailsFontColor"] as! String,
                                                                  ProductBackgroundColor: aObject["ProductBackgroundColor"] as! String,
                                                                  IsExclusive: aObject["IsExclusive"] as! String,
                                                                  IsNewprdClickable: aObject["IsNewprdClickable"] as! String,
                                                                  IsSharable: aObject["IsSharable"] as! String,
                                                                  popupmsg: aObject["popupmsg"] as! String,
                                                                  title: aObject["title"] as! String,
                                                                  info: aObject["info"] as! String)
                                
                                
                                self.moreServiceModel.append(model)
                            }
                            */
                            
                            
                            
                            
                        }
                        
                        
                
                        
//                        DispatchQueue.main.async {
//                            self.mainTV.isHidden = false
//                            self.mainTV.reloadData()
//                        }
                        
                        
                    }
                    
                    
                }, onError: { errorData in
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                    snackbar.show()
                }, onForceUpgrade: {errorData in})
                
            }
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
    }
    
    
    
    func getDeviceDetails(){
        
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
            
            let POSPNo = UserDefaults.standard.string(forKey: "POSPNo") as AnyObject
            
            let parameter  :[String: AnyObject] = [
                
                "ss_id": POSPNo as AnyObject,
                "device_id": getDeviceID() as AnyObject,
                "device_name": getDeviceName() as AnyObject,
                "os_detail": getDeviceOS() as AnyObject,
                "action_type": "active" as AnyObject,
                "App_Version":"PolicyBossPro-"as AnyObject,
                "device_info" : "" as AnyObject
                
            ]
            let endUrl = "app_visitor/save_device_details"
            let url =  FinmartRestClient.baseURLROOT  + endUrl
    
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
                        let obj = try decoder.decode(DeviceDetailModel.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        
                        
                        if obj.status.elementsEqual("SUCCESS") {
                            
                            self.showAlert(message: "Done")
                            
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: "No nData founx" , duration: .long)
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

}
