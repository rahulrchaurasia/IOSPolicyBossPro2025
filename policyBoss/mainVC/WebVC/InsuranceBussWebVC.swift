//
//  InsuranceBussWebVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 03/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import WebKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire


class InsuranceBussWebVC: UIViewController ,WKNavigationDelegate {
    
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
     var webfromScreen = ""
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// For Orientation///////////
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        /////////////////////////
        
        
        // add activity
        self.webView.addSubview(self.indicatorView)
        self.indicatorView.startAnimating()
        self.webView.navigationDelegate = self
        self.indicatorView.hidesWhenStopped = true
        
        
        
        if(webfromScreen == "InsuranceBusiness")
        {
            insurancebusinessAPI()
        }
    }
    
    
    // Default Loading
    /********************************************************/
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
    /********************************************************/
    
    
    func insurancebusinessAPI()
    {
        
        if Connectivity.isConnectedToInternet()
        {
            print("Yes! internet is available.")
            
            
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
            
            let ERPID = UserDefaults.standard.string(forKey: "ERPID")
            let fba_uid = UserDefaults.standard.string(forKey: "fba_uid")
            let fba_campaign_id = UserDefaults.standard.string(forKey: "fba_campaign_id")
            let fba_campaign_name = UserDefaults.standard.string(forKey: "fba_campaign_name")
            
            
            let params: [String: AnyObject] = ["Id": ERPID as AnyObject,
                                               "fba_uid": fba_uid as AnyObject,
                                               "fba_campaign_id": fba_campaign_id as AnyObject,
                                               "fba_campaign_name": fba_campaign_name as AnyObject,]
            
            let url = "/LeadCollection.svc/GetEncryptedErpId"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let Url = userObject as! String
                print("INSURANCE Url=",Url)
                let value = UIInterfaceOrientation.landscapeLeft.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                self.lbltitle.text! = "MY BUSINESS"
                self.webView.load(URLRequest(url: URL(string: Url)!))
                
                
            }, onError: { errorData in
                alertView.close()
                //            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
                //            snackbar.show()
            }, onForceUpgrade: {errorData in},checkStatus: true)
            
        }else{
            let snackbar = TTGSnackbar.init(message: "No Internet Access Avaible", duration: .long)
            snackbar.show()
        }
        
    }
    
    
  

    @IBAction func homeBtnClicked(_ sender: Any) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
          UIViewController.attemptRotationToDeviceOrientation()
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
           self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func webBackBtnClicked(_ sender: Any) {
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
          self.dismiss(animated: false, completion: nil)
        
    }
    
    
  //////////////////////  Method For Orientation   ////////////////////////////
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    /**********************************************************************/
  
}



//extension UINavigationController {
//
//    override open var shouldAutorotate: Bool {
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.shouldAutorotate
//            }
//            return super.shouldAutorotate
//        }
//    }
//
//    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.preferredInterfaceOrientationForPresentation
//            }
//            return super.preferredInterfaceOrientationForPresentation
//        }
//    }
//
//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.supportedInterfaceOrientations
//            }
//            return super.supportedInterfaceOrientations
//        }
//    }}
