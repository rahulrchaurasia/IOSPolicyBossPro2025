//
//  incmCalculatrVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import SafariServices

class incmCalculatrVC: UIViewController {

    @IBOutlet var titleLbl: UILabel!
    var fromScreen = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(fromScreen == "appoinLetter"){
            titleLbl.text! = "POSP APPOINTMENT LETTER"
            type = "1"
        }
        else if(fromScreen == "ApplictnForm"){
            titleLbl.text! = "POSP APPLICATION FORM"
            type = "0"
        }
    }
    

    @IBAction func backBtnCliked(_ sender: Any)
    {

        
         dismiss(animated: false)
    }
    
    @IBAction func sendviaEmailBtnCliked(_ sender: Any)
    {
        pospappointmentemailAPI()
    }
    
    @IBAction func viewnDownloadBtnCliked(_ sender: Any)
    {
        GetPospAppointmentLetterAPI()
    }
    
    //---<APICALL>---
    func pospappointmentemailAPI()
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
        
        let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject,
                                           "url":"" as AnyObject,
                                           "type":type as AnyObject]
        
        let url = "posp-appointment-email"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            
            TTGSnackbar.init(message: "Send successfully.", duration: .long).show()
            
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
    
    func GetPospAppointmentLetterAPI()
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
        
        let SSID = UserDefaults.standard.string(forKey: "POSPNo")
        
        let params: [String: AnyObject] = ["SS_ID": SSID as AnyObject,
                                           "Type":type as AnyObject]
        
        let url = "GetPospAppointmentLetter"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject
            let Url = NSURL(string: jsonData as! String)
            let svc = SFSafariViewController(url: Url! as URL)
            svc.modalPresentationStyle =  .fullScreen
            self.present(svc, animated: true, completion: nil)

            
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
