//
//  addUsersVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import TTGSnackbar

class addUsersVC: UIViewController {

    @IBOutlet var othrloanProductView: UIView!
    @IBOutlet var othrloanProductViewHeight: NSLayoutConstraint!//500
    @IBOutlet var moreServicesView: UIView!
    @IBOutlet var moreServicesViewHeight: NSLayoutConstraint!//190
    @IBOutlet var moreServicesViewTop: NSLayoutConstraint!//5
    @IBOutlet var myUtilitiesView: UIView!
    @IBOutlet var myUtilitiesViewHeight: NSLayoutConstraint!//308
    @IBOutlet var muUtilitiesViewTop: NSLayoutConstraint!//5
    
    var fromScreen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderClr = UIColor.lightGray
        othrloanProductView.layer.borderWidth=1.0;
        othrloanProductView.layer.borderColor=borderClr.cgColor;
        othrloanProductView.layer.cornerRadius = 4.0
        moreServicesView.layer.borderWidth=1.0;
        moreServicesView.layer.borderColor=borderClr.cgColor;
        moreServicesView.layer.cornerRadius = 4.0
        myUtilitiesView.layer.borderWidth=1.0;
        myUtilitiesView.layer.borderColor=borderClr.cgColor;
        myUtilitiesView.layer.cornerRadius = 4.0
        
        if(fromScreen == "otherloanProduct")
        {
            othrloanProductView.isHidden = false
            othrloanProductViewHeight.constant = 500
            moreServicesView.isHidden = true
            moreServicesViewHeight.constant = 0
            myUtilitiesView.isHidden = true
            myUtilitiesViewHeight.constant = 0
        }
        else if(fromScreen == "moreServices")
        {
            othrloanProductView.isHidden = true
            othrloanProductViewHeight.constant = 0
            moreServicesView.isHidden = false
            moreServicesViewHeight.constant = 190
            moreServicesViewTop.constant = 200
            myUtilitiesView.isHidden = true
            myUtilitiesViewHeight.constant = 0
        }
        else if(fromScreen == "myUtilities")
        {
            othrloanProductView.isHidden = true
            othrloanProductViewHeight.constant = 0
            moreServicesView.isHidden = true
            moreServicesViewHeight.constant = 0
            myUtilitiesView.isHidden = false
            myUtilitiesViewHeight.constant = 308
            muUtilitiesViewTop.constant = 150
        }
        
    }
    
    @IBAction func closeBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        present(KYDrawer, animated: true, completion: nil)
        
         dismiss(animated: false)
    }
    
    @IBAction func moreServCloseBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        present(KYDrawer, animated: true, completion: nil)
        
         dismiss(animated: false)
    }
    
    @IBAction func myUtiliCloseBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        present(KYDrawer, animated: true, completion: nil)
         dismiss(animated: false)
    }
    
    
    
    //<otherloanProductMenus>
    @IBAction func balanceTransferBtnCliked(_ sender: Any)
    {
        //api
    }
    
    @IBAction func freeCreditBtnCliked(_ sender: Any)
    {
       
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "freeCreditCard"
        present(commonWeb, animated: false, completion: nil)
    }
    
    @IBAction func loanMessBtnCliked(_ sender: Any)
    {
      
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "loanonMessanger"
        present(commonWeb, animated: false, completion: nil)
    }
    
    @IBAction func leadSubmiBtnCliked(_ sender: Any)
    {
       
//        let QuickLead : QuickLeadVC = self.storyboard?.instantiateViewController(withIdentifier: "stbQuickLeadVC") as! QuickLeadVC
//        QuickLead.modalPresentationStyle = .fullScreen
//        present(QuickLead, animated: false, completion: nil)
    }
    
    @IBAction func cashLoanBtnCliked(_ sender: Any)
    {
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "cashLoan"
        present(commonWeb, animated: true, completion: nil)
    }
    
    @IBAction func loanAgainstBtnCliked(_ sender: Any)
    {
        //api
    }
    
    @IBAction func rectifyCreditBtnCliked(_ sender: Any)
    {
        
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "rectifyCredit"
        present(commonWeb, animated: false, completion: nil)
    }
    
    //<moreServicesMenus>
    @IBAction func finpeaceBtnCliked(_ sender: Any)
    {
//        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//        commonWeb.webfromScreen = "fin-Peace"
//        present(commonWeb, animated: true, completion: nil)
        
        let snackbar = TTGSnackbar.init(message: "Coming Soon..." , duration: .long)
        snackbar.show()
    }
    
    @IBAction func healthAssureBtnCliked(_ sender: Any)
    {
        
//        let offlineQuotes : offlineQuotesVC = self.storyboard?.instantiateViewController(withIdentifier: "stbofflineQuotesVC") as! offlineQuotesVC
//        offlineQuotes.modalPresentationStyle = .fullScreen
//        offlineQuotes.modalTransitionStyle = .coverVertical
//        present(offlineQuotes, animated: false, completion: nil)
        
    }
    
    //<myUtilitiesMenus>
//    @IBAction func mpsBtnCliked(_ sender: Any)
//    {
//
//        let mpsV : mpsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbmpsVC") as! mpsVC
//        mpsV.modalPresentationStyle = .fullScreen
//        mpsV.modalTransitionStyle = .coverVertical
//        present(mpsV, animated: false, completion: nil)
//    }
//
//    @IBAction func incomeCalBtnCliked(_ sender: Any)
//    {
//       //05      Snackbar
//
//        let snackbar = TTGSnackbar.init(message: "Comming  soon", duration: .middle )
//        snackbar.show()
//    }
    
    @IBAction func myTrainingBtnCliked(_ sender: Any)
    {
       
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.modalTransitionStyle = .coverVertical
        commonWeb.webfromScreen = "Training"
        present(commonWeb, animated: false, completion: nil)
    }
    
    @IBAction func helpnFeedbckBtnCliked(_ sender: Any)
    {
      
        let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
        helpnfeedback.modalPresentationStyle = .fullScreen
        helpnfeedback.modalTransitionStyle = .coverVertical
        present(helpnfeedback, animated: false, completion: nil)
       
    }
    
    
    
}
