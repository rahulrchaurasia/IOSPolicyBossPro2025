//
//  EulaVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 24/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import WebKit

class EulaVC: UIViewController , WKNavigationDelegate,UIScrollViewDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnDisAgree: UIButton!
    @IBOutlet weak var btnAgree: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.EulaScreen)

        addIndicator()
        
         setData(btn: btnAgree)
         setData(btn: btnDisAgree)
        bindHTMLData()
    }
    
    func addIndicator(){
        self.webView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.webView.navigationDelegate = self
        self.activityIndicator.hidesWhenStopped = true
    }

    func setData( btn : UIButton){
        
        
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        btn.layer.cornerRadius=2.0;
        btn.layer.borderWidth=2.0;
        btn.layer.borderColor=borderColr.cgColor;
        
        btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
        
        
       
    }
    func bindHTMLData(){
        
        if let resourceURL = Bundle.main.url(forResource: "eula", withExtension: "html") {
            
            let urlRequest  = URLRequest.init(url: resourceURL)
            
            webView.load(urlRequest)
        }
    }
  
 
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
     
        scrollView.pinchGestureRecognizer?.isEnabled = true

    }
    
    
    @IBAction func didTapAgreeButton(_ sender: Any) {
        
        trackEvent(strStatus: "I Agree")
        Core.shared.setNewUser()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let loginPage = storyboard.instantiateViewController(withIdentifier: "stbLoginVC") as!  LoginVC
        loginPage.modalPresentationStyle = .fullScreen
        self.present(loginPage, animated: false)
        
    }
    
    @IBAction func didTapADisAgreeButton(_ sender: Any) {
        // self.dismiss(animated: false)
        
      //  exit (0);
        trackEvent(strStatus: "I Disagree")
        warningAlert()

    
    }
    
    func warningAlert()
       {
           // Create the alert controller
           let alertController = UIAlertController(title: "WARNING", message: "To Continue, You must accept terms and conditions", preferredStyle: .alert)
           // Create the actions
           let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
               UIAlertAction in
              // NSLog("OK Pressed")
               
           }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}

extension EulaVC {
    
    func trackEvent(strStatus : String){
        
        let agreementAcknowledgementAttributes: [String:Any]  = [
            "Staus": strStatus,
        ]

        WebEngageAnaytics.shared.trackEvent("Agreement Acknowledgement", agreementAcknowledgementAttributes)
    }
    
}
