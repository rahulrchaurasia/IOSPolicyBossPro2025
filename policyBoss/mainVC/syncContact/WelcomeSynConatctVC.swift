//
//  WelcomeSynConatctVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 14/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit
import Contacts
import TTGSnackbar
import CustomIOSAlertView

class WelcomeSynConatctVC: UIViewController {

    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var imgchkTerm1: UIImageView!
    @IBOutlet weak var imgchkTerm2: UIImageView!
    @IBOutlet weak var imgchkTerm3: UIImageView!
    
    @IBOutlet weak var ClickHere: UIStackView!
    
    var isTermSMS = false
    var  isTermCALL = false
    var isTermAggremet = false
    var isAuthorized = false
    let store = CNContactStore()
    let syContactViewModel  = SyncContactViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        ScrollView.layoutIfNeeded()
       
        //self.ScrollView.scrollToBottom(animated: true)
        btnGetStarted.alpha = 0.40
    
        btnGetStarted.layer.cornerRadius = 15
        btnGetStarted.layer.masksToBounds = true // This line is important to make sure the button stays within its bounds
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))


        self.ClickHere.addGestureRecognizer(gesture)
        
       
        if Connectivity.isConnectedToInternet(){
            
            fetchSyncAgreementDetails()
        }else{
            
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
            
      
        
        // Do any additional setup after loading the view.
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {

        let objVC = SyncMoreDetailsVC.shareInstance()

        self.present(objVC, animated: true)
       
        btnGetStarted.alpha = 1
     }

    
    func verifyAllCondition() -> Bool{
        
        if( self.isTermAggremet ){
            
            btnGetStarted.alpha = 1
            return true
        }else{
            btnGetStarted.alpha = 0.4
            return false
        }
       
    }
    
    func getSyncAgreemet(isSms : String, isCall : String){
        
        if(isSms == "yes"){
            self.isTermSMS = true
            imgchkTerm1.image = UIImage(named: "black-check-box-with-white-check (2).png")
        }else{
            self.isTermSMS = false
            imgchkTerm1.image = UIImage(named: "check-box-empty.png")
            
        }
        
        
        if(isCall == "yes"){
            
            self.isTermCALL = true
            imgchkTerm2.image = UIImage(named: "black-check-box-with-white-check (2).png")
        }else{
            self.isTermCALL = false
            imgchkTerm2.image = UIImage(named: "check-box-empty.png")
            
        }
        
        
        
    }
    @IBAction func btnBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnTermsCondition(_ sender: Any) {
        

        moveToWeb(screeName: ScreenName.SYNC_TERMS, screenTitle: "Terms & Conditions")
    }
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        

        moveToWeb(screeName: ScreenName.SYNC_PRIVACY, screenTitle: "Privacy-Policy")
      
    }
    
    @IBAction func btnTerms1(_ sender: Any) {
        
        self.isTermSMS.toggle()
        
       
        if(self.isTermSMS){
            imgchkTerm1.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm1.image = UIImage(named: "check-box-empty.png")
           
        }
        
        
       // verifyAllCondition()
    }
    
    @IBAction func btnTerms2(_ sender: Any) {
        self.isTermCALL.toggle()
        if(self.isTermCALL){
            imgchkTerm2.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm2.image = UIImage(named: "check-box-empty.png")
           
        }
        
       // verifyAllCondition()
    }
    
    @IBAction func btnTerms3(_ sender: Any) {
        
        self.isTermAggremet.toggle()
        if(self.isTermAggremet){
            imgchkTerm3.image = UIImage(named: "black-check-box-with-white-check (2).png")
           
        }else{
            imgchkTerm3.image = UIImage(named: "check-box-empty.png")
           
        }
        
      verifyAllCondition()
        
    }
    
    @IBAction func btnStarted(_ sender: Any) {
        
        if Connectivity.isConnectedToInternet(){
            
            if( verifyAllCondition()){


                self.contactAuthorizedReq()

                if(isAuthorized){
                    
                    saveSyncContAgreementData(isCall: self.isTermCALL, isSms: self.isTermSMS)
                  
                }


            }
            
         
        }else{
            
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
    }
    
    
    func fetchSyncAgreementDetails(){
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

                let response = try await syContactViewModel.fetchSyncAgreement()

                alertView.close()
                
                if(response.status == "0"){
                   
                    if let agreemnetRes = response.response{
                        
                        
                        let index =  agreemnetRes.Msg.count - 1
      
                        print("Sync Agreement Response: \(String(describing: agreemnetRes))")
                        
                        getSyncAgreemet(isSms: agreemnetRes.Msg[index].is_sms, isCall: agreemnetRes.Msg[index].is_call)
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
    func saveSyncContAgreementData(isCall : Bool , isSms : Bool)
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
            Task{
                
                do{
                    let response = try await syContactViewModel.saveSyncAgreement(isCall: isCall, isSMS: isSms)
                    
            print("Sync save Agreement Response: \(String(describing: response))")
                    
                    alertView.close()
                    
                    if(response.lowercased() == "success"){
                        navigationController?.pushViewController( SyncContactVC.shareInstance(), animated: false)
                    }else{
                        
                        let snackbar = TTGSnackbar.init(message: Constant.NoDataFound, duration: .middle )
                        snackbar.show()
                    }
                    
                        
                 
                }catch{
                    alertView.close()
                    print("Request failed with error: \(error)")
                }
            }
            
        }
        
    

    
    func contactAuthorizedReq(){
        
        
        
        // Do any additional setup after loading the view.
        
      
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        
        // 2
        if authorizationStatus == .notDetermined {
            // 3
            store.requestAccess(for: .contacts) { [weak self] didAuthorize,
                error in
                if didAuthorize {
                     self?.isAuthorized = true
                    
                    DispatchQueue.main.async {
                        self?.navigationController?.pushViewController( SyncContactVC.shareInstance(), animated: false)
                    }
                  
                }
            }
        }
        else if authorizationStatus == .denied {
            debugPrint("Status : denied")
            self.isAuthorized = false
            checkPermissionAlert( _title: Constant.contactTitle,_message: Constant.contactReq)
        }else if authorizationStatus == .restricted {
            self.isAuthorized = false
            debugPrint("Status : restricted")
            checkPermissionAlert( _title: Constant.contactTitle,_message: Constant.contactReq)
        }else if authorizationStatus == .authorized {
            
            self.isAuthorized = true
            
        }
        
    }
   
    func checkPermissionAlert(_title : String , _message : String){
        
        
        let alertController = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
       
    }

    

    
    func moveToWeb(screeName : String, screenTitle : String ){
        
        let storyboard = UIStoryboard(name: storyBoardName.Main, bundle: .main)
    let commonWeb : commonWebVC = storyboard.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.addType = Screen.navigateBack
        commonWeb.webTitle = screenTitle
        commonWeb.webfromScreen = screeName
        navigationController?.pushViewController( commonWeb, animated: false)
    }
   
}
extension WelcomeSynConatctVC {
    
    static func shareInstance() -> WelcomeSynConatctVC
    {
        return WelcomeSynConatctVC.initiateFromStoryboard(name: storyBoardName.SyncContact)
    }
}
