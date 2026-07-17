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
import Combine

class hnfcontactUsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,mycelDelegate ,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var conctusTblView: UITableView!
    
//    var headerArray = [String]()
//    var websiteArray = [String]()
//    var emailArray = [String]()
//    var phoneNoArray = [String]()
//    var displayTitleArray = [String]()
    
    var indexS = Int()
    var webSite = ""
    var phoneNo = ""
    var emailID = ""
    
    private var viewModel: HomeViewModel!
    
    private var cancellables = Set<AnyCancellable>()
    
    private var loaderView: UIView?
    
    
    
    var contactUsData: [ContactUsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.ContactUsScreen)
        //--<apiCall>--
       // contactusAPI()
        
        setupViewModel()
        bindViewModel()
        loadData()
        
    }
    
    private func loadData(){

        Task {
          
            await viewModel.fetchContactUsData ()
        }
    }
    private func setupViewModel(){
        
        viewModel = HomeViewModel(
            repository: HomeRepository(apiService:  APIService()))
    }
    
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        
        dismiss(animated: false)
//        let helpnfeedback : helpnfeedbackVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhelpnfeedbackVC") as! helpnfeedbackVC
//        helpnfeedback.modalPresentationStyle = .fullScreen
//        present(helpnfeedback, animated: true, completion: nil)
    }
    
    //--<tableViewDatasource+Delegates>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactUsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! hnfcontctTVCell
        
        let contact = contactUsData[indexPath.row]
        
        cell.displayTitlLbl.text = contact.DisplayTitle
        cell.titleLbl.text = contact.Header
        cell.phoneNoLbl.text = contact.PhoneNo
        cell.emailLbl.text = contact.Email
        cell.websiteLbl.text = contact.Website
        
        
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

        guard let indexPath = conctusTblView.indexPath(for: cell) else { return }
            let website = contactUsData[indexPath.row].Website
            
            let commonWeb = storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
            commonWeb.modalPresentationStyle = .fullScreen
            commonWeb.webfromScreen = "contactWebsites"
            commonWeb.fromcontctWebsite = website
            present(commonWeb, animated: true)
    }
    
    func btnEmailTapped(cell: hnfcontctTVCell) {
    
        guard let indexPath = conctusTblView.indexPath(for: cell) else { return }
            let email = contactUsData[indexPath.row].Email
            sendEmail(strReceipt: email)
    }
    
    func btnPhonenoTapped(cell: hnfcontctTVCell) {

        guard let indexPath = conctusTblView.indexPath(for: cell) else { return }
           let phone = contactUsData[indexPath.row].PhoneNo
           callNumber(phoneNumber: phone)
    }
    
    
    func sendEmail(strReceipt : String ) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([strReceipt])
            mail.setSubject("Contact Support")
            mail.setMessageBody("<p>Dear Sir/Madam,</p><p>I would like to...</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // Show alert if Mail is not configured
            let alert = UIAlertController(
                title: "Mail Not Configured",
                message: "Please set up a Mail account in the Mail app to send emails.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
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
    

}

  
extension hnfcontactUsVC {
    
    private func bindViewModel() {
        
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoader() : self?.hideLoader()
            }
            .store(in: &cancellables)
        
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                self?.showError(message: message)
            }
            .store(in: &cancellables)
        


        viewModel.$contactUsResponse
            .receive(on: RunLoop.main)
            .sink { [weak self] newData in
                guard let self = self else { return }
                
                // Safely assign data or empty array
                self.contactUsData = newData?.MasterData ?? []
               
                print("📞 ContactUs received count: \(self.contactUsData.count)")
                self.conctusTblView.reloadData()  // ✅ refresh table

            }
            .store(in: &cancellables)
        
    
    }
}

extension hnfcontactUsVC {
    
   

    private func showLoader() {
        guard loaderView == nil else { return }

        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = overlay.center
        spinner.startAnimating()

        overlay.addSubview(spinner)
        view.addSubview(overlay)

        loaderView = overlay
    }
    
    private func hideLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
    
    private func showError(message : String){
        
        let snackbar = TTGSnackbar.init(message: message, duration: .long)
        snackbar.show()
    }
    
    
}
