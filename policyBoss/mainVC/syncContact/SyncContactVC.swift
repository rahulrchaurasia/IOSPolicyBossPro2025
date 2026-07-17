//
//  SyncContactVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit
import TTGSnackbar
import Contacts

class SyncContactVC: UIViewController {

    
   
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lblTotalCount: UILabel!
    
    @IBOutlet weak var lblResult: UILabel!
    var contactMainData = [ContactMainModel]()
    var contactData = [ContactModelRaw]()
   // var contactDataNew = [ContactModelRaw]()
   // var addressData = [AddressModel]()
    //Mark: contactUploadStep decide the  quantity of data which is uploaded to server at one time
    let contactUploadStep = 500
    let initialProgress = 0.25
    let syncContactQueue = DispatchQueue(label: "com.policybosspro.syncqueue"  )
    // For AlertDialog
    let alertService = AlertService()

    let store = CNContactStore()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

       
        initData()
       // setProgressUI()
        
        getContactData()
       
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setProgressUI()
    }
    
    func initData(){
        
        imgBack.isHidden = true
        btnBack.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        self.progressView.setProgress(Float(initialProgress), animated: true)
        
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

    

    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    

    
   
    private func setProgressUI() {

           let radius = progressView.bounds.height / 2

           progressView.layer.cornerRadius = radius
           progressView.clipsToBounds = true

           for subview in progressView.subviews {
               subview.layer.cornerRadius = radius
               subview.clipsToBounds = true
           }
       }
  
    func getContactData() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .notDetermined:
            // Request access
            store.requestAccess(for: .contacts) { [weak self] didAuthorize, error in
                if didAuthorize {
                    DispatchQueue.main.async {
                        self?.handlingData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.checkPermissionAlert(_title: Constant.contactTitle, _message: Constant.contactReq)
                    }
                }
            }
            
        case .authorized, .limited:  // Handle both authorized and limited access the same way
            // Proceed with retrieving contacts
            /******** Retreive All the data *******/
            
            handlingData()
            
        case .denied, .restricted:
            debugPrint("Status: \(authorizationStatus == .denied ? "denied" : "restricted")")
            checkPermissionAlert(_title: Constant.contactTitle, _message: Constant.contactReq)
            
        @unknown default:
            debugPrint("Unknown authorization status")
            checkPermissionAlert(_title: Constant.contactTitle, _message: "Unknown permission status. Please check your settings.")
        }
    }
    
    func getContactData1(){
        
        
        
        // Do any additional setup after loading the view.
        
       
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        
        // 2
        if authorizationStatus == .notDetermined {
            // 3
            store.requestAccess(for: .contacts) { [weak self] didAuthorize,
                error in
                if didAuthorize {
                    
                    self?.handlingData()
                }
            }
        }
        else if authorizationStatus == .denied {
            debugPrint("Status : denied")
            checkPermissionAlert( _title: Constant.contactTitle,_message: Constant.contactReq)
        }else if authorizationStatus == .restricted {
            debugPrint("Status : restricted")
            checkPermissionAlert( _title: Constant.contactTitle,_message: Constant.contactReq)
        }else if authorizationStatus == .authorized {
            
            
            /******** Retreive All the data *******/
            
            
           handlingData()
            
           // retrieveContactsDemo()
            
        }
        
    }
    
   
    

    
    func retrieveContacts(completion: @escaping ([ContactModelRaw]?, Error?) -> Void) {
        
        
        let lock = DispatchQueue(label: "com.policybossPro.SyncContact", qos: .userInitiated)
        
       // var contactData = [ContactModelRaw]()
        var contactData : [ContactModelRaw] = []
        // var error: Error?
        
        
        /////////////////////
        
        
        var label : String = ""
        var value : String = ""
        var localizedLabel : String = ""
        
        var normalizedNumber = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let calendar = Calendar(identifier: .gregorian)
        
          var PhoneDataArray = [String]()
        
           var phoneNumbersArray: [PhoneData] = []
          
           var emailsArray: [EmailData] = []
           var addressArray: [AddressData] = []
           var websitesArray: [String] = []
           var relationsArray : [RelationData] = []
        
           var eventArray : [EventData] = []
         

        ///////////////////////////
        
        lock.async { [weak self]  in
            
            
            let keys = [CNContactGivenNameKey,
                        CNContactPhoneNumbersKey,
                        CNContactFamilyNameKey,
                        CNContactMiddleNameKey,
                        
                        CNContactEmailAddressesKey,
                        CNContactPostalAddressesKey,
                        CNContactRelationsKey,
                        CNContactBirthdayKey,
                        CNContactDatesKey,
                       
                        CNContactOrganizationNameKey,
                        CNContactJobTitleKey,
                        CNContactDepartmentNameKey,
                        CNContactUrlAddressesKey,
                    
                        CNContactNicknameKey
            ]
            

            
            
            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
            
            do{

                
                try   self?.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
                    
                    
                      label  = ""
                      value  = ""
                      localizedLabel  = ""
                      PhoneDataArray = [String]()
                  
                      phoneNumbersArray = []
                    
                      emailsArray = []
                      addressArray = []
                      websitesArray = []
                      relationsArray  = []
                  
                      eventArray  = []
                    
                    /*******************************/
                    
                    var contactModel = ContactModelRaw()  // Initialize the Object
                    
                    /*******************************/
 
                
                    
                     // NickName
                      if let pnote = contact.nickname as?  String, !pnote.isEmpty {

                          contactModel.nickname = pnote
                          debugPrint("nick name :", pnote )
                          
                        }
                    
                    // Phone Number
                    for phoneNumber in contact.phoneNumbers {
                        
                        
                        let label = phoneNumber.label ?? ""
                        
                        if !label.isEmpty   {
                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
                        } else {
                            localizedLabel = ""  // Provide a default label here
                        }
                        
                        
                        value = phoneNumber.value.stringValue
                       
                        
                        debugPrint("Phone label" , localizedLabel )
                        debugPrint("Phone Value" , value )
                        
                        
                        let filteredValue = value.digitOnly
                        normalizedNumber = ""
                        if(filteredValue.count >= 10){
                              
                            normalizedNumber = String(filteredValue.suffix(10))
                            PhoneDataArray.append(normalizedNumber)
                            
                        }
                        
                        // add  Phone data
                        phoneNumbersArray.append(
                            PhoneData(
                                normalizedNumber: normalizedNumber,
                                number: value,
                                type: localizedLabel
                            ))
                        

                       
                    }
                                        
                    // emailAddress
                    for emailAddress in contact.emailAddresses {
                        
                        label = emailAddress.label ?? ""
                        
                        
                        if !label.isEmpty   {
                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
                        } else {
                            localizedLabel = ""  // Provide a default label here
                        }
                        
                        value = emailAddress.value as? String ?? ""
                        
                        debugPrint("Localized Label:", localizedLabel)
                        debugPrint("Email Value:", value)
                        // Do something with label and emailValue
                        
                        // add  emailAddress data
                        emailsArray.append(
                            EmailData(
                                address: value,
                                type: localizedLabel
                            ))

                    }
                    
                    // websites
                    
                    for urlAddress in contact.urlAddresses {
                        if let urlString = urlAddress.value as? String {
                            contactModel.websites.append(urlString)
                            debugPrint("websites:", urlString )
                        }
                    }
                        

                    
                 
                    debugPrint("*************Relation*************")
                    
                    //// relation
                    for relation in contact.contactRelations {


                        label = relation.label ?? ""


                        if !label.isEmpty   {
                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
                        } else {
                            localizedLabel = ""  // Provide a default label here
                        }

                        if let relationName = relation.value.name as? String {

                            value = relationName
                            debugPrint("Localized Label:", localizedLabel)
                            debugPrint("Relation Value:", relationName )
                            
                            
                            // add relation Data
                            relationsArray.append(
                                RelationData(
                                    relationName : value,
                                    relationLabel : localizedLabel
                                ))
                        }

                    }
                   
                    
                    
                    if let birthday = contact.birthday?.date {
                       // let dateFormatter = DateFormatter()
                       // dateFormatter.dateStyle = .long

                        let formattedBirthday = dateFormatter.string(from: birthday)
                        debugPrint("Birthday:", formattedBirthday)
                        
                      
                        eventArray.append(EventData(startDate: formattedBirthday, type: "Birthday")
                            
                        )

                    }
                   
                    
                    debugPrint("*************Dates*************")
                    

                   
                    for dateLabel in contact.dates {
                        let label = CNLabeledValue<NSString>.localizedString(forLabel: dateLabel.label ?? "")
                        let nsDateComponents = dateLabel.value as NSDateComponents

                        // Check if nsDateComponents is not nil and contains valid date information
                       // let calendar = Calendar(identifier: .gregorian)
                        if let date = calendar.date(from: nsDateComponents as DateComponents) {
                           
                            let formattedDate = dateFormatter.string(from: date)
                            
                            debugPrint("Date Label:", label)
                            debugPrint("Formatted Date:", formattedDate)
                            
                           
                            eventArray.append(
                                
                                EventData(startDate: formattedDate,
                                          type: label)
                                
                            )
                        }
                    }
                    
                    
                    

                   
                    if !contact.departmentName.isEmpty {
                        debugPrint("Company Department:", contact.departmentName)
                        contactModel.companyDepartment = contact.departmentName
                    }

                    if !contact.organizationName.isEmpty {
                        debugPrint("Company Name:", contact.organizationName)
                        contactModel.companyName = contact.organizationName
                    }

                    if !contact.jobTitle.isEmpty {
                        debugPrint("Company Title:", contact.jobTitle)
                      
                        contactModel.companyTitle = contact.jobTitle
                    }
                    


                    
                    contactModel.displayName = "\(contact.givenName) \(contact.familyName)"
                    
                    contactModel.familyName = contact.familyName
                
                    contactModel.givenName = contact.givenName
                    
                    contactModel.middleName = contact.middleName
                   
                   
                  //
                    debugPrint("*************Address*************")
                    for postalAddress in contact.postalAddresses {
                        
                        label = postalAddress.label ?? ""
                        
                        
                        if !label.isEmpty   {
                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
                        } else {
                            localizedLabel = ""  // Provide a default label here
                        }
                        
                        let formattedAddress = CNPostalAddressFormatter.string(from: postalAddress.value, style: .mailingAddress) as? String
                        
                        
                        debugPrint("Localized Label:", localizedLabel)
                        debugPrint("Address Value:", formattedAddress ?? "")
                        
                        addressArray.append(
                            AddressData(formattedAddress: formattedAddress ?? "", type: localizedLabel)
                        )
                    }
                    
                    contactModel.phone = PhoneDataArray
                    contactModel.phoneNumbers = phoneNumbersArray
                    contactModel.addresses = addressArray
                    contactModel.relations = relationsArray
                    contactModel.events = eventArray
                    contactModel.emails = emailsArray
                    contactModel.websites = websitesArray
                        
                    
                    contactData.append( contactModel)    // add raw data to List
                    
                })
                
                
           
                //debugPrint("raw Data" , contactData as Any)
                completion(contactData, nil)
                
              
            }catch let err {
                debugPrint("print to fetch Contact" ,  err)
                
                
                
                completion(nil, err)
                
            }
            
            
            
        }
        
        
    }
  


    func handlingData(){
        
        
      
        //Mark: ****  retrieve all the Contact *********************
        /***************************************************/
        retrieveContacts { contactData, error in
            if let error = error {
                    print("Error", error)
                } else if let contactData = contactData {
                   
                    DispatchQueue.main.async {
                        
                        self.contactData = contactData
                        
                        debugPrint("Contact Data Size", self.contactData.count)
                        
                        self.processData()
                    }
                  
                }
        }
        
      
       
        
      
    }
    
    func processData(){
        
        self.contactMainData = [ContactMainModel]()
       
        var index = 0
        for contact in self.contactData{
           
           
            let mobilenoList = contact.phone.map{$0}
            let name = contact.displayName
           
            if(mobilenoList.count > 0){
                for mobile in mobilenoList {
                    
                    index += 1
                    self.contactMainData.append(
                        
                        ContactMainModel(id:index, name: name, mobileno: mobile)
                        
                    )
                }
                
            }
                
            //Mark  *** Use enumerated when we required index
               // also in iteration of loop ****/
//                            for (index, mobile) in mobilenoList.enumerated() {
//                                self.contactMainData.append(
//                                    ContactMainModel(id:index + 1, name: name, mobileno: mobile)
//
//                                )
//                            }
                
                

         
          
        }
            
        debugPrint("mainData", self.contactMainData)
        
        do{
            
            //Mark :****** comment  For Showing contactMainData Details****
            
            
            let encodedData = try JSONEncoder().encode(self.contactData)
            let jsonString = String(data: encodedData, encoding: .utf8)

            var rawData = ""
            if let mdata = jsonString {

                rawData =  mdata.replacingOccurrences(of: "\\", with: "")
               
              
            }else{
                
                rawData = ""
            }
          
                debugPrint("rawData", rawData)
            
                
            let ContactMainList = self.contactMainData
                var   maxProgress = ContactMainList.count / contactUploadStep

            let   remainderProgress = ContactMainList.count % contactUploadStep
                     
                
                if (remainderProgress > 0) {
                    
                    maxProgress = maxProgress + 1
                    
                }
                // **Due To Addition OF Default Initial Progress remove 1 step : ****
                    if(maxProgress > 1){
                        maxProgress = maxProgress - 1
                    }
                
                //var  currentProgress  = 1.0 / Float(maxProgress)
              //  let progressValue =   1.0 / Float(maxProgress)
            
            let progressValue: Float =
                maxProgress > 0 ? (1.0 / Float(maxProgress)) : 1.0
           
                // stride : Used for Step in For Loop
                for index in stride(from: 0, to: ContactMainList.count, by: contactUploadStep) {
                    
                   
                    let subContactList = ContactMainList.filter{$0.id > index && $0.id <= (contactUploadStep + index)}

                    let step = (index / contactUploadStep) + 1
                    
                    //"Filter List ",subContactList
                    debugPrint("STEP BY", step)
                    debugPrint("MAX Progress", maxProgress)
                    // Mark : called api
                    /******** API For Sync Contact Data *******/
                    
                  
                    
                    SyncContactViewModel.shareInstance.fetchDataFromApi(subContactList: subContactList,rawData: rawData ) { [weak self] result in
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                        {
                            
                            switch result {
                            
                            case .success(let objResponse):
                                let syncObj = objResponse as! SyncContactResponse
                                
                                 print("SYNCDATA",syncObj.Message ?? "Default message")
                                self?.progressView.progress += progressValue
                                self?.progressView.setProgress(self?.progressView.progress ?? 0.0, animated: true)
                                
                                if(maxProgress == step){
                                    
                                    print("Success Done and MaxProgress",maxProgress)
                                    self?.lblResult.text = syncObj.Message
                                    self?.progressView.setProgress(1.0, animated: true)

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1)  // delay in 1sec
                                    {
                                        self?.successMessage()
                                    }
                                  
                                }
                                
                            case .failure(.custom(message: let error)):
                                let snackbar = TTGSnackbar.init(message: error, duration: .middle )
                                snackbar.show()
                                
                                self?.activityIndicator.isHidden = true
                                self?.activityIndicator.stopAnimating()
                            
                            }
                        }

                      
                    }
                    
                 
                   
                    
                }
                
          
            
        
            
        }
        catch let error {
            print("Error: ", error)
        }
        
    }
    
    func successMessage(){
        
        trackSyncContactEvent()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
      
        guard let ssid = (UserDefaults.standard.string(forKey: "POSPNo"))
                else{ return }
        let alertSyncDashboard = self.alertService.alertSyncDashboard(alertSSID: ssid)
        
        alertSyncDashboard.syncDashboardCompletion  = {[weak self] dict in
            /********************************************/
            //Mark : called when childVC is dismiss
            /********************************************/
           
            DispatchQueue.main.async {
                let data = dict["DASHBOARD"] as! String
                debugPrint("Result", data)  // NOT IN USED : Only For Callback
                
                self?.moveToWeb(screeName: "leadDashboard")
            }
            
            
            
        }
    
        self.present(alertSyncDashboard, animated: true)

      
    }
    
   
    func moveToWeb(screeName : String ){
        
        
        let storyboard = UIStoryboard(name: storyBoardName.Main, bundle: .main)
        let commonWeb : commonWebVC = storyboard.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
        commonWeb.modalPresentationStyle = .fullScreen
        commonWeb.modalTransitionStyle = .coverVertical
        commonWeb.addType = Screen.navigateRoot
        commonWeb.webfromScreen = screeName
        //present(commonWeb, animated: false, completion: nil)
        navigationController?.pushViewController( commonWeb, animated: false)
    }

}
extension SyncContactVC {
    
    static func shareInstance() -> SyncContactVC
    {
        return SyncContactVC.initiateFromStoryboard(name: storyBoardName.SyncContact)
    }
    
     func trackSyncContactEvent() {
         
      WebEngageAnaytics.shared.trackEvent("Sync Contacts completed")
      }
}






