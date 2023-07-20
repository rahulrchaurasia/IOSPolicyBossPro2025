//
//  getmpsNowVC.swift
//  MagicFinmart
//
//  Created by Admin on 17/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class getmpsNowVC: UIViewController {

    @IBOutlet var whtisplatinumSubsView: UIView!
    @IBOutlet var whtisplatinumSubsViewHeight: NSLayoutConstraint!//520
    @IBOutlet var ourmagicplatiSubsView: UIView!
    @IBOutlet var ourmagicplatSubsViewHeight: NSLayoutConstraint!//450
    @IBOutlet var ourmagicplatiSubsViewTop: NSLayoutConstraint!
    @IBOutlet var promoCodeView: UIView!
    @IBOutlet var promoCodeViewheight: NSLayoutConstraint!//60
    @IBOutlet var amountContentLbl: UILabel!
    @IBOutlet var prodctBeniftView: UIView!
    @IBOutlet var visualmagicproView: UIView!
    @IBOutlet var tabmagicView: UIView!
    @IBOutlet var mobmagicgynView: UIView!
    @IBOutlet var mobhealthmagicView: UIView!
    @IBOutlet var getmpsBtn: UIButton!
    @IBOutlet var maybeltrBtn: UIButton!
    @IBOutlet var magicpltnumView: UIView!
    @IBOutlet var gstView: UIView!
    @IBOutlet var totalpayView: UIView!
    @IBOutlet var applyBtn: UIButton!
    @IBOutlet var chckboxBtn: UIButton!
    @IBOutlet var termncoditnBtn: UIButton!
    @IBOutlet var payBtn: UIButton!
    @IBOutlet var mrpLbl: UILabel!
    @IBOutlet var serbTxAmtLbl: UILabel!
    @IBOutlet var totalPayLbl: UILabel!
    @IBOutlet var gstLbl: UILabel!
    @IBOutlet var promoCodeTf: ACFloatingTextfield!
    @IBOutlet var havePromocodeBtn: UIButton!
    @IBOutlet var promoSuccessfulLbl: UILabel!
    @IBOutlet var promoSuccssLblHeight: NSLayoutConstraint!
    @IBOutlet var havepromoBtnHeight: NSLayoutConstraint!//30
    @IBOutlet var promosuccessLblTop: NSLayoutConstraint!
    @IBOutlet var TnCpopUpView: UIView!
    
    var fromScreen = ""
    var amountValue = ""
    var paymentURL = ""
    var checkbox = "unClick"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //changecolor
        viewColorGray(view: prodctBeniftView)
        viewColorGray(view: visualmagicproView)
        viewColorGray(view: tabmagicView)
        viewColorGray(view: mobmagicgynView)
        viewColorGray(view: mobhealthmagicView)
        viewColorGray(view: magicpltnumView)
        viewColorGray(view: gstView)
        viewColorGray(view: totalpayView)
        btnColorChangeBlue(Btn: getmpsBtn)
        btnColorChangeBlue(Btn: maybeltrBtn)
        btnColorChangeBlue(Btn: applyBtn)
        
        if(fromScreen == "knowMoreMPS")
        {
            whtisplatinumSubsView.isHidden = false
            whtisplatinumSubsViewHeight.constant = 520
            ourmagicplatiSubsView.isHidden = true
            ourmagicplatSubsViewHeight.constant = 0
        }
        else if(fromScreen == "getMPS")
        {
            whtisplatinumSubsView.isHidden = true
            whtisplatinumSubsViewHeight.constant = 0
            ourmagicplatiSubsView.isHidden = false
            ourmagicplatSubsViewHeight.constant = 450
            ourmagicplatiSubsViewTop.constant = 5
            promoCodeView.isHidden = true
            promoCodeViewheight.constant = 0
            promoSuccessfulLbl.isHidden = true
            promoSuccssLblHeight.constant = 0
        }

        //-<apiCall>-
        getmpsdataAPI()
        
    }
    
   
    @IBAction func backBtnCliked(_ sender: Any)
    {

       //  self.moveToHome()
          self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
        // self.moveToHome()
        self.dismissAll(animated: false)
    }
    
    
    @IBAction func getmpsNowBtnCliked(_ sender: Any)
    {
        let getmpsNow : getmpsNowVC = self.storyboard?.instantiateViewController(withIdentifier: "stbgetmpsNowVC") as! getmpsNowVC
        getmpsNow.fromScreen = "getMPS"
        getmpsNow.modalPresentationStyle = .fullScreen
        present(getmpsNow, animated: true, completion: nil)
    }
    
    @IBAction func maybeLtrBtnCliked(_ sender: Any)
    {
        
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
       //  self.moveToHome()
          self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func hvpromocodeBtnCliked(_ sender: Any)
    {
        promoCodeView.isHidden = false
        promoCodeViewheight.constant = 60
    }
    
    @IBAction func applyBtnCliked(_ sender: Any)
    {
        if(promoCodeTf.text! != ""){
            validatedcuponcodeAPI()
        }
        else{
            TTGSnackbar.init(message: "Enter Promocode", duration: .long).show()
        }
    }
    
    @IBAction func termscnditnBtnCliked(_ sender: Any)
    {
//        TnCpopUpView.isHidden = false
        let getmpsTnC : getmpsTnCVC! = storyboard?.instantiateViewController(withIdentifier: "stbgetmpsTnCVC") as? getmpsTnCVC
        self.addChild(getmpsTnC)
        self.view.addSubview(getmpsTnC.view)
    }
    
    @IBAction func TnCbackCloseBtnCliked(_ sender: Any)
    {
        TnCpopUpView.isHidden = true
    }
    
    @IBAction func chckboxBtnCliked(_ sender: Any)
    {
        if(chckboxBtn.tag == 0){
            chckboxBtn.setImage(UIImage(named: "black-check-box-with-white-check (2).png"), for: .normal)
            payBtn.backgroundColor = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
            payBtn.setTitleColor(UIColor.white, for: .normal)
            chckboxBtn.tag = 1
            checkbox = "Click"
        }
        else if(chckboxBtn.tag == 1){
            chckboxBtn.setImage(UIImage(named: "check-box-empty.png"), for: .normal)
            payBtn.backgroundColor = UIColor.lightGray
            payBtn.setTitleColor(UIColor.black, for: .normal)
            chckboxBtn.tag = 0
            checkbox = "unClick"
        }
        
    }
    
    @IBAction func payBtnCliked(_ sender: Any)
    {
        if(checkbox == "Click")
        {
            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.webfromScreen = "payforgetMPS"
            commonWeb.PaymentURL = paymentURL
            present(commonWeb, animated: true, completion: nil)
        }
        
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
            self.amountValue = Amount as! String
            let VATAmt = jsonData?.value(forKey: "VATAmt") as AnyObject
            let MRP = jsonData?.value(forKey: "MRP") as AnyObject
            let ServTaxAmt = jsonData?.value(forKey: "ServTaxAmt") as AnyObject
            let TotalAmt = jsonData?.value(forKey: "TotalAmt") as AnyObject
            self.gstLbl.text! = "G.S.T "+(VATAmt as! String)+"%"
            self.mrpLbl.text! = "₹ " + (MRP as! String)
            self.serbTxAmtLbl.text! = "₹ " + (ServTaxAmt as! String)
            self.totalPayLbl.text! = "₹ " + (TotalAmt as! String)
            self.payBtn.titleLabel?.text! = "PAY ₹ "+(TotalAmt as! String)
            
            self.amountContentLbl.text! = "Magic Platinum Subscription(MPS) is an exclusive offer from Datacomp,available to Finmart Business Associates only. In this subscription you pay ₹"+self.amountValue+" to use Datacomp's following four premium applications FREE:"
            
            self.paymentURL = (jsonData?.value(forKey: "PaymentURL") as AnyObject) as! String
            
            
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
    
    
    func validatedcuponcodeAPI()
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
        
        let params: [String: AnyObject] = ["FBAID":FBAId as AnyObject,
                                           "PromoCode": promoCodeTf.text! as AnyObject]
        
        let url = "validated-cupon-code"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            let Amount = jsonData?.value(forKey: "Amount") as AnyObject
            self.amountValue = Amount as! String
            let VATAmt = jsonData?.value(forKey: "VATAmt") as AnyObject
            let MRP = jsonData?.value(forKey: "MRP") as AnyObject
            let ServTaxAmt = jsonData?.value(forKey: "ServTaxAmt") as AnyObject
            let TotalAmt = jsonData?.value(forKey: "TotalAmt") as AnyObject
            self.gstLbl.text! = "G.S.T "+(VATAmt as! String)+"%"
            self.mrpLbl.text! = "₹ " + (MRP as! String)
            self.serbTxAmtLbl.text! = "₹ " + (ServTaxAmt as! String)
            self.totalPayLbl.text! = "₹ " + (TotalAmt as! String)
            self.payBtn.titleLabel?.text! = "PAY ₹ "+(TotalAmt as! String)
            
            self.amountContentLbl.text! = "Magic Platinum Subscription(MPS) is an exclusive offer from Datacomp,available to Finmart Business Associates only. In this subscription you pay ₹"+self.amountValue+" to use Datacomp's following four premium applications FREE:"
            
            self.paymentURL = (jsonData?.value(forKey: "PaymentURL") as AnyObject) as! String

            self.promoCodeView.isHidden = true
            self.promoCodeViewheight.constant = 0
            self.havePromocodeBtn.isHidden = true
            self.havepromoBtnHeight.constant = 0
            self.promoSuccessfulLbl.isHidden = false
            self.promoSuccssLblHeight.constant = 25
            self.promosuccessLblTop.constant = 0
            
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
    
    
    //----<buttonColor>----
    func btnColorChangeBlue(Btn:UIButton)
    {
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        Btn.layer.cornerRadius=2.0;
        Btn.layer.borderWidth=1.0;
        Btn.layer.borderColor=borderColr.cgColor;
        Btn.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)
    }
   
    func viewColorGray(view:UIView)
    {
        let borderColr = UIColor.lightGray
        view.layer.cornerRadius=2.0;
        view.layer.borderWidth=0.5;
        view.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
}
