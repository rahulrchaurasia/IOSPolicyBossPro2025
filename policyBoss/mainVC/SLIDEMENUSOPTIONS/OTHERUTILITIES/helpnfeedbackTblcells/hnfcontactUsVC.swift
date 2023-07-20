//
//  hnfcontactUsVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import MessageUI

class hnfcontactUsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,mycelDelegate ,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var conctusTblView: UITableView!
    
    var headerArray = [String]()
    var websiteArray = [String]()
    var emailArray = [String]()
    var phoneNoArray = [String]()
    var displayTitleArray = [String]()
    
    var indexS = Int()
    var webSite = ""
    var phoneNo = ""
    var emailID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //--<apiCall>--
        contactusAPI()
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
        helpnfeedback.modalPresentationStyle = .fullScreen
        present(helpnfeedback, animated: true, completion: nil)
    }
    
    //--<tableViewDatasource+Delegates>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! hnfcontctTVCell
        
        cell.displayTitlLbl.text! = displayTitleArray[indexPath.row]
        cell.titleLbl.text! = headerArray[indexPath.row]
        cell.phoneNoLbl.text! = phoneNoArray[indexPath.row]
        cell.emailLbl.text! = emailArray[indexPath.row]
        cell.websiteLbl.text! = websiteArray[indexPath.row]
        
        //--contctSites--
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexS = indexPath.row
        
    }
    
    //--<call third party url>--
    func btnWebsiteTapped(cell: hnfcontctTVCell)
    {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.conctusTblView.indexPath(for: cell)
        webSite = websiteArray[indexPath!.row]
        let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as!commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.webfromScreen = "contactWebsites"
        commonWeb.fromcontctWebsite = webSite
        present(commonWeb, animated: true, completion: nil)
    }
    
    func btnEmailTapped(cell: hnfcontctTVCell) {
     
        let indexPath = self.conctusTblView.indexPath(for: cell)
        emailID = emailArray[indexPath!.row]
        sendEmail(strReceipt: emailID)
    }
    
    func btnPhonenoTapped(cell: hnfcontctTVCell) {
        let indexPath = self.conctusTblView.indexPath(for: cell)
        phoneNo = phoneNoArray[indexPath!.row]
        callNumber(phoneNumber: phoneNo)
    }
    
    
    func sendEmail(strReceipt : String ) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([strReceipt])
            mail.setSubject("v")
            mail.setMessageBody("<p>Dear Sir/Madam,</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //--<APICALL>--
    func contactusAPI()
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
        
        let params: [String: AnyObject] = [:]
        
        let url = "contact-us-PB"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            print("jsonData=",jsonData!)
            let Header = jsonData!.value(forKey: "Header") as AnyObject
            self.headerArray = Header as! [String]
            let Email = jsonData!.value(forKey: "Email") as AnyObject
            self.emailArray = Email as! [String]
            let PhoneNo = jsonData!.value(forKey: "PhoneNo") as AnyObject
            self.phoneNoArray = PhoneNo as! [String]
            let Website = jsonData!.value(forKey: "Website") as AnyObject
            self.websiteArray = Website as! [String]
            let DisplayTitle = jsonData!.value(forKey: "DisplayTitle") as AnyObject
            self.displayTitleArray = DisplayTitle as! [String]
            
            self.conctusTblView.reloadData()
            
            
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
