//
//  AlertWebViewController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 08/04/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import WebKit


class AlertWebViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate {
    
    
    @IBOutlet weak var WebView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
   
    var strURL : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //For Web View Loading Only.
        
        // add activity
        self.WebView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.WebView.navigationDelegate = self
        self.activityIndicator.hidesWhenStopped = true
        
        
        
       // let myUrl  = URL(string:"http://qa.mgfm.in/images/rbasalesmaterial/testpagenew.html")
        
        guard let webURL = strURL else{
            return
        }
         let myUrl  = URL(string:webURL)
        
        let request =  URLRequest(url: myUrl!)
        
        WebView.load(request)
    }
    
   
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = true
    }
    

    @IBAction func btnCloseClick(_ sender: Any) {
        
          dismiss(animated: true)
    }
    
 

}
