//
//  mpsVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class mpsVC: UIViewController {

    @IBOutlet weak var MPSView: UIView!
    @IBOutlet weak var getMPSnowBtn: UIButton!
    @IBOutlet weak var maybeLaterBtn: UIButton!
    @IBOutlet var mpsContentLbl: UILabel!
    
    var amountValuetxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 65/255.0, green: 65/255.0, blue: 65/255.0, alpha: 1)
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        getMPSnowBtn.layer.borderWidth=1.0;
        getMPSnowBtn.layer.borderColor=borderColor.cgColor;
        maybeLaterBtn.layer.borderWidth=1.0;
        maybeLaterBtn.layer.borderColor=borderColor.cgColor;
        
        //<apiCall>
        getmpsdataAPI()
        
    }
    
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func knowmoreMPSBtnCliked(_ sender: Any)
    {
        let getmpsNow : getmpsNowVC = self.storyboard?.instantiateViewController(withIdentifier: "stbgetmpsNowVC") as! getmpsNowVC
        getmpsNow.modalPresentationStyle = .fullScreen
        getmpsNow.fromScreen = "knowMoreMPS"
        present(getmpsNow, animated: true, completion: nil)
    }
    
    @IBAction func getMPSnowBtnCliked(_ sender: Any)
    {
        let getmpsNow : getmpsNowVC = self.storyboard?.instantiateViewController(withIdentifier: "stbgetmpsNowVC") as! getmpsNowVC
        getmpsNow.modalPresentationStyle = .fullScreen
        getmpsNow.modalTransitionStyle = .coverVertical
        getmpsNow.fromScreen = "getMPS"
        present(getmpsNow, animated: true, completion: nil)
    }
    
    @IBAction func maybeLaterBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
          self.dismiss(animated: false, completion: nil)
      
    }
    
    
    //--<APICALL>--
    func getmpsdataAPI()
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
        
        let params: [String: AnyObject] = ["FBAID":FBAId as AnyObject]
        
        let url = "get-mps-data"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Amount = jsonData?.value(forKey: "Amount") as AnyObject
            self.amountValuetxt = Amount as! String
            
            self.mpsContentLbl.text! = "Congratulations and welcome to the PolicyBoss Family. As our privileged assciate, you are eligible to an exclusive magic Platinum Subscription(MPS) for ₹"+self.amountValuetxt+"/- (Incl. GST)) only"
            
            
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
