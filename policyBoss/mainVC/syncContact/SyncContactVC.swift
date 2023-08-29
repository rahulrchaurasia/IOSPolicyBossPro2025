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
    var contactData = [ContactModel]()
    var contactDataNew = [ContactModelRaw]()
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
        setProgressUI()
        
        getContactData()
       
       
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
    
    func setProgressUI(){
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
    }
    
  
    func getContactData(){
        
        
        
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
    
   
    
    //////////////////////
  
//    func retrieveContactsNeeew(completion: @escaping ([ContactModel]?, Error?) -> Void) {
//
//
//        let lock = DispatchQueue(label: "com.policybossPro.SyncContact", qos: .userInitiated)
//
//        var contactData = [ContactModel]()
//        // var error: Error?
//
//
//        lock.async { [weak self]  in
//
//
//            let keys = [CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey,
//
//                        CNContactPhoneNumbersKey,CNContactEmailAddressesKey,
//                        CNContactOrganizationNameKey,
//
//                        CNContactPostalAddressesKey,
//                        CNContactBirthdayKey,
//                        CNContactNoteKey,
//                        CNContactJobTitleKey,
//                        CNContactDepartmentNameKey,
//                        CNContactBirthdayKey,
//                        CNContactRelationsKey,
//                        CNContactNicknameKey
//            ]
//
//
//
//
//            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//            contactData = [ContactModel]()
//
//
//
//            do{
//
//
//                try   self?.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
//
//
//
//                    // initialize contact Model object using Display name
//                    var contactModel = ContactModel(displayName: "\(contact.givenName) \(contact.familyName)")
//
//                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10
//
//                    }.compactMap { $0.value.stringValue.digitOnly}
//
//
//                    var PhoneDataArray = [String]()
//
//
//
//                    tempPhoneData.forEach { element in
//
//                        if(element.count >= 10){
//
//                            let c =   element.suffix(10)
//
//                            PhoneDataArray.append(String(c))
//
//
//                        }
//
//
//                    }
//
//                    contactModel.phone.append(contentsOf: PhoneDataArray)
//
//                    debugPrint("websites" , contact.urlAddresses as? String ?? "")
//                    contactModel.websites.append( contact.urlAddresses as? String ?? "")
//                    contactModel.nickname.append(contact.nickname )
//                    contactModel.note.append(contact.note )
//
//                    for phoneNumber in contact.phoneNumbers {
//
//
//                            let label = phoneNumber.label ?? ""
//                           let value = phoneNumber.value.stringValue
//                            contactModel.phoneNumbers.append(PhoneData(normalizedNumber: "", number: value ,type: label))
//
//                        debugPrint("Phone label" , label )
//                        debugPrint("Phone Value" , value )
//                        }
//
//
//
//                    for emailAddress in contact.emailAddresses {
//
//                        if let emailValue = emailAddress.value  as? String, !emailValue.isEmpty {
//
//                            let emailLabel = emailAddress.label ?? ""
//
//                            contactModel.emails.append(EmailData(address: emailValue , type: emailLabel))
//                        }
//
//                    }
//
//
//
//                    for relation in contact.contactRelations {
//
//                        if let relationName = relation.value.name as? String, !relationName.isEmpty {
//
//                            let relationLabel = relation.label ?? ""
//
//                            contactModel.relations.append(RelationData(relationName: relationName  ,relationLabel: relationLabel))
//                        }
//
//                    }
//
//
//
//                    for postalAddress in contact.postalAddresses {
//
//
//                        let formattedAddress = CNPostalAddressFormatter.string(from: postalAddress.value, style: .mailingAddress)
//
//                        let addressLabel = postalAddress.label ?? ""
//
//                        contactModel.PostalAddress.append( AddressData(formattedAddress: formattedAddress ?? "", type: addressLabel))
//
//                    }
//
//
//
//                    //Nickname: contact.nickname
//
//
//
//
//                })
//
//
//
//                completion(contactData, nil)
//
//                debugPrint("raw Data" , self?.contactData as Any)
//            }catch let err {
//                debugPrint("print to fetch Contact" ,  err)
//
//
//
//                completion(nil, err)
//
//            }
//
//
//
//        }
//
//
//    }
  
    
//
//    func retrieveContactsDemo() {
//
//
//
//         var error: Error?
//
//
//
//
//            let keys = [CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey,
//
//                        CNContactPhoneNumbersKey,CNContactEmailAddressesKey,
//                        CNContactOrganizationNameKey,
//
//                        CNContactPostalAddressesKey,
//                        CNContactBirthdayKey,
//                        CNContactNoteKey,
//                        CNContactJobTitleKey,
//                        CNContactDepartmentNameKey,
//                        CNContactBirthdayKey,
//                        CNContactRelationsKey,
//                        CNContactNicknameKey
//            ]
//
//
//
//
//            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//
//
//            do{
//
//
//                try   self.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
//
//
//
//                    // initialize contact Model object using Display name
//                    var contactModel = ContactModelRaw(displayName: "\(contact.givenName) \(contact.familyName)")
//
//
//                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10
//
//                    }.compactMap { $0.value.stringValue.digitOnly}
//
//
//                    var PhoneDataArray = [String]()
//
//
//
//                    tempPhoneData.forEach { element in
//
//                        if(element.count >= 10){
//
//                            let c =   element.suffix(10)
//
//                            PhoneDataArray.append(String(c))
//
//
//                        }
//
//
//                    }
//
//
//
//
//                    contactModel.phone.append(contentsOf: PhoneDataArray)
//
//                    debugPrint("websites" , contact.urlAddresses as? String ?? "")
//                    contactModel.websites.append( contact.urlAddresses as? String ?? "")
//                    contactModel.nickname.append(contact.nickname as? String ?? "" )
//                   // contactModel.note.append(contact.note )
//
//                    for phoneNumber in contact.phoneNumbers {
//
//
//                            let label = phoneNumber.label ?? ""
//                           let value = phoneNumber.value.stringValue
//                            contactModel.phoneNumbers.append(PhoneData(normalizedNumber: "", number: value ,type: label))
//
//                        debugPrint("Phone label" , label )
//                        debugPrint("Phone Value" , value )
//                        }
//
//
//
//                    for emailAddress in contact.emailAddresses {
//
//                        if let emailValue = emailAddress.value  as? String, !emailValue.isEmpty {
//
//                            let emailLabel = emailAddress.label ?? ""
//
//                            contactModel.emails.append(EmailData(address: emailValue , type: emailLabel))
//                        }
//
//                    }
//
//
////
////                    for relation in contact.contactRelations {
////
////                        if let relationName = relation.value.name as? String, !relationName.isEmpty {
////
////                            let relationLabel = relation.label ?? ""
////
////                            contactModel.relations.append(RelationData(relationName: relationName  ,relationLabel: relationLabel))
////                        }
////
////                    }
////
//
//
//                    for postalAddress in contact.postalAddresses {
//
//
//                        let formattedAddress = CNPostalAddressFormatter.string(from: postalAddress.value, style: .mailingAddress)
//
//                        let addressLabel = postalAddress.label ?? ""
//
//                        contactModel.PostalAddress.append( AddressData(formattedAddress: formattedAddress ?? "", type: addressLabel))
//
//                    }
//
//                   // contactDataNew.append(contactModel)
//
//                    //Nickname: contact.nickname
//
//
//
//
//
//                })
//
//
//
//
//
//                debugPrint("raw Data" ," Done")
//            }catch let err {
//                debugPrint("Error SyncData print to fetch Contact" ,  err)
//
//
//
//
//
//            }
//
//
//
//
//
//
//    }
    
    func retrieveContacts(completion: @escaping ([ContactModel]?, Error?) -> Void) {
        
        
        let lock = DispatchQueue(label: "com.policybossPro.SyncContact", qos: .userInitiated)
        
        var contactData = [ContactModel]()
        // var error: Error?
        
        
        /////////////////////
        
        
        var label : String = ""
        var value : String = ""
        var localizedLabel : String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        
          var PhoneDataArray = [String]()
        
           var phoneNumbersArray: [PhoneData] = []
          
           var emailsArray: [EmailData] = []
           var PostalAddressArray: [AddressData] = []
           var websitesArray: [String] = []
           var relationsArray : [RelationData] = []
         

        ///////////////////////////
        
        lock.async { [weak self]  in
            
            
            let keys = [CNContactGivenNameKey,
                        CNContactPhoneNumbersKey,
                        CNContactFamilyNameKey,
                        CNContactEmailAddressesKey,
                        CNContactPostalAddressesKey,
                        CNContactRelationsKey,
                        CNContactBirthdayKey,
                        CNContactDatesKey,
                       
                        CNContactOrganizationNameKey,
                        CNContactJobTitleKey,
                        CNContactDepartmentNameKey,
                      
                        
                        CNContactNicknameKey
            ]
            

            
            
            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            contactData = [ContactModel]()
            
            
            
            do{

                
                try   self?.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
                    
                    /*******************************/
                    
                    var contactModel = ContactModelRaw()  // Initialize the Object
                    
                    /*******************************/
                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10
                        
                    }.compactMap { $0.value.stringValue.digitOnly}
                    
                    
                     PhoneDataArray = [String]()
                     phoneNumbersArray  = [PhoneData]()
                     emailsArray  = [EmailData]()
                     PostalAddressArray = [AddressData]()
                     websitesArray = [String]()
                     relationsArray  = [RelationData]()
                  
                    
                    
                    tempPhoneData.forEach { element in
                        
                        if(element.count >= 10){
                            
                            let c =   element.suffix(10)
                            
                            PhoneDataArray.append(String(c))
                            
                            
                        }
                        
                        
                    }
                    
                    // debugPrint("Filter Data :", PhoneDataArray)
                    
                    
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
                        
                        
                       
                    }
                    // add  Phone data
                    phoneNumbersArray.append(
                        PhoneData(
                            normalizedNumber: "",
                            number: value,
                            type: localizedLabel
                        ))
                    
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
                        debugPrint("Email Value:", value ?? "")
                        // Do something with label and emailValue
                    }
                    
                    // add  emailAddress data
                    emailsArray.append(
                        EmailData(
                            address: value,
                            type: localizedLabel
                        ))
                    
                    
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

                            value = relationName ?? ""
                            debugPrint("Localized Label:", localizedLabel)
                            debugPrint("Relation Value:", relationName ?? "")
                        }

                    }
                    // add relation Data
                    relationsArray.append(
                        RelationData(
                            relationName : value,
                            relationLabel : localizedLabel
                        ))
                    
                    
                    if let birthday = contact.birthday?.date {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .long

                        let formattedBirthday = dateFormatter.string(from: birthday)
                        debugPrint("Birthday:", formattedBirthday)
                        
                      
                        
                    }
                   
                    
                    debugPrint("*************Dates*************")
                    

                   
                    for dateLabel in contact.dates {
                        let label = CNLabeledValue<NSString>.localizedString(forLabel: dateLabel.label ?? "")
                        let nsDateComponents = dateLabel.value as NSDateComponents

                        // Check if nsDateComponents is not nil and contains valid date information
                        let calendar = Calendar(identifier: .gregorian)
                        if let date = calendar.date(from: nsDateComponents as DateComponents) {
                           
                            let formattedDate = dateFormatter.string(from: date)
                            
                            print("Date Label:", label)
                            print("Formatted Date:", formattedDate)
                        } else {
                            print("Invalid date components for label:", label)
                        }
                    }
                    

                    if !contact.departmentName.isEmpty {
                        print("Company Department:", contact.departmentName)
                    } else {
                        print("No company department available")
                    }

                    if !contact.organizationName.isEmpty {
                        print("Company Name:", contact.organizationName)
                    } else {
                        print("No company name available")
                    }

                    if !contact.jobTitle.isEmpty {
                        print("Company Title:", contact.jobTitle)
                    } else {
                        print("No company title available")
                    }
                    




                    debugPrint("organizationName", contact.organizationName)
                    debugPrint("jobTitle", contact.jobTitle)
                    debugPrint("departmentName", contact.departmentName)
                    
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

                    }
                    
                  
                  
                    
                  
                   
                                             
                    
//                    contactData.append(
//                        ContactModel(
//                            Name :"\(contact.givenName) \(contact.familyName)",
//                            
//
//                            //                        PhoneNumbers: contact.phoneNumbers.compactMap {           $0.value.stringValue.removeSpecialCharactersWithoutSpace},
//
//                            PhoneNumbers: PhoneDataArray,
//
//
//                            EmailAddresses: contact.emailAddresses.compactMap{$0.value as String },
//
//
//                            OrganizationName:  contact.organizationName,
//
//
//
//                            PostalAddress: contact.postalAddresses.compactMap{
//
//                                return  "\($0.value.street) \($0.value.city) \($0.value.postalCode) "
//
//
//                            },
//
//                            Nickname: contact.nickname
//
//                            // Note: contact.note,
//
//                        ))
                    
                    
                    
                    
                })
                
                
                
                completion(contactData, nil)
                
                debugPrint("raw Data" , self?.contactData as Any)
            }catch let err {
                debugPrint("print to fetch Contact" ,  err)
                
                
                
                completion(nil, err)
                
            }
            
            
            
        }
        
        
    }
  
//    func retrieveContacts1(completion: @escaping ([ContactModel]?, Error?) -> Void) {
//
//
//        let lock = DispatchQueue(label: "com.policybossPro.SyncContact", qos: .userInitiated)
//
//        var contactData = [ContactModel]()
//        // var error: Error?
//
//
//        /////////////////////
//
//
//        var label : String = ""
//        var localizedLabel : String = ""
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//
//        ///////////////////////////
//
//        lock.async { [weak self]  in
//
//
//            let keys = [CNContactGivenNameKey,
//                        CNContactPhoneNumbersKey,
//                        CNContactFamilyNameKey,
//                        CNContactEmailAddressesKey,
//                        CNContactPostalAddressesKey,
//                        CNContactRelationsKey,
//                        CNContactBirthdayKey,
//                        CNContactDatesKey,
//
//                        CNContactOrganizationNameKey,
//                        CNContactJobTitleKey,
//                        CNContactDepartmentNameKey,
//
//
//                        CNContactNicknameKey
//            ]
//
//
//
//
//            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//            contactData = [ContactModel]()
//
//
//
//            do{
//
//
//                try   self?.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
//
//
//                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10
//
//                    }.compactMap { $0.value.stringValue.digitOnly}
//
//
//                    var PhoneDataArray = [String]()
//
//
//
//                    tempPhoneData.forEach { element in
//
//                        if(element.count >= 10){
//
//                            let c =   element.suffix(10)
//
//                            PhoneDataArray.append(String(c))
//
//
//                        }
//
//
//                    }
//
//                    // debugPrint("Filter Data :", PhoneDataArray)
//
//
//                      if let pnote = contact.nickname as?  String, !pnote.isEmpty {
//
//                        debugPrint("nick name :", pnote )
//                        }
//
//                    for phoneNumber in contact.phoneNumbers {
//
//
//                        let label = phoneNumber.label ?? ""
//
//                        if !label.isEmpty   {
//                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
//                        } else {
//                            localizedLabel = ""  // Provide a default label here
//                        }
//
//
//                        let value = phoneNumber.value.stringValue
//
//
//                        debugPrint("Phone label" , localizedLabel )
//                        debugPrint("Phone Value" , value )
//                    }
//                    //
//
//                    for emailAddress in contact.emailAddresses {
//
//                        label = emailAddress.label ?? ""
//
//
//                        if !label.isEmpty   {
//                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
//                        } else {
//                            localizedLabel = ""  // Provide a default label here
//                        }
//
//                        let emailValue = emailAddress.value as? String
//
//                        debugPrint("Localized Label:", localizedLabel)
//                        debugPrint("Email Value:", emailValue ?? "")
//                        // Do something with label and emailValue
//                    }
//
//
//                    debugPrint("*************Relation*************")
//
//                    for relation in contact.contactRelations {
//
//
//                        label = relation.label ?? ""
//
//
//                        if !label.isEmpty   {
//                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
//                        } else {
//                            localizedLabel = ""  // Provide a default label here
//                        }
//
//                        if let relationName = relation.value.name as? String {
//
//                            debugPrint("Localized Label:", localizedLabel)
//                            debugPrint("Relation Value:", relationName ?? "")
//                        }
//
//
//
//                    }
//
//
//                    if let birthday = contact.birthday?.date {
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateStyle = .long
//
//                        let formattedBirthday = dateFormatter.string(from: birthday)
//                        debugPrint("Birthday:", formattedBirthday)
//                    }
//
//                    debugPrint("*************Dates*************")
//
//
//
//                    for dateLabel in contact.dates {
//                        let label = CNLabeledValue<NSString>.localizedString(forLabel: dateLabel.label ?? "")
//                        let nsDateComponents = dateLabel.value as NSDateComponents
//
//                        // Check if nsDateComponents is not nil and contains valid date information
//                        let calendar = Calendar(identifier: .gregorian)
//                        if let date = calendar.date(from: nsDateComponents as DateComponents) {
//
//                            let formattedDate = dateFormatter.string(from: date)
//
//                            print("Date Label:", label)
//                            print("Formatted Date:", formattedDate)
//                        } else {
//                            print("Invalid date components for label:", label)
//                        }
//                    }
//
//
//                    if !contact.departmentName.isEmpty {
//                        print("Company Department:", contact.departmentName)
//                    } else {
//                        print("No company department available")
//                    }
//
//                    if !contact.organizationName.isEmpty {
//                        print("Company Name:", contact.organizationName)
//                    } else {
//                        print("No company name available")
//                    }
//
//                    if !contact.jobTitle.isEmpty {
//                        print("Company Title:", contact.jobTitle)
//                    } else {
//                        print("No company title available")
//                    }
//
//
//
//
//
//                    debugPrint("organizationName", contact.organizationName)
//                    debugPrint("jobTitle", contact.jobTitle)
//                    debugPrint("departmentName", contact.departmentName)
//
//                    debugPrint("*************Address*************")
//                    for postalAddress in contact.postalAddresses {
//
//
//
//                        label = postalAddress.label ?? ""
//
//
//                        if !label.isEmpty   {
//                            localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
//                        } else {
//                            localizedLabel = ""  // Provide a default label here
//                        }
//
//                        let formattedAddress = CNPostalAddressFormatter.string(from: postalAddress.value, style: .mailingAddress) as? String
//
//
//                        debugPrint("Localized Label:", localizedLabel)
//                        debugPrint("Address Value:", formattedAddress ?? "")
//
//                    }
//
//                    contactData.append(
//                        ContactModel(
//                            Name :"\(contact.givenName) \(contact.familyName)",
//
//
//                            //                        PhoneNumbers: contact.phoneNumbers.compactMap {           $0.value.stringValue.removeSpecialCharactersWithoutSpace},
//
//                            PhoneNumbers: PhoneDataArray,
//
//
//                            EmailAddresses: contact.emailAddresses.compactMap{$0.value as String },
//
//
//                            OrganizationName:  contact.organizationName,
//
//
//
//                            PostalAddress: contact.postalAddresses.compactMap{
//
//                                return  "\($0.value.street) \($0.value.city) \($0.value.postalCode) "
//
//
//                            },
//
//                            Nickname: contact.nickname
//
//                            // Note: contact.note,
//
//                        ))
//
//
//
//
//                })
//
//
//
//                completion(contactData, nil)
//
//                debugPrint("raw Data" , self?.contactData as Any)
//            }catch let err {
//                debugPrint("print to fetch Contact" ,  err)
//
//
//
//                completion(nil, err)
//
//            }
//
//
//
//        }
//
//
//    }


//    func retrieveContactsold(completion: @escaping ([ContactModel]?, Error?) -> Void) {
//
//        let dispatchGroup = DispatchGroup()
//            var contactData = [ContactModel]()
//           // var error: Error?
//
//
//        DispatchQueue.global(qos: .userInteractive).async { [weak self]  in
//
//
//            let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactEmailAddressesKey,
//                CNContactOrganizationNameKey,
//
//                CNContactPostalAddressesKey,
//                //CNContactBirthdayKey,
//                //CNContactNoteKey,
//                CNContactNicknameKey
//                ]
//
//
//
//
//            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//           contactData = [ContactModel]()
//
//
//
//            do{
//
//
//
//                try   self?.store.enumerateContacts(with: request, usingBlock: {   contact, stop in
//
//                    dispatchGroup.enter()
//
//
//                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10
//
//                    }.compactMap { $0.value.stringValue.digitOnly}
//
//
//                    var PhoneDataArray = [String]()
//
//
//
//                    tempPhoneData.forEach { element in
//
//                        if(element.count >= 10){
//
//                            let c =   element.suffix(10)
//
//                            PhoneDataArray.append(String(c))
//
//
//                        }
//
//
//                    }
//
//                    // debugPrint("Filter Data :", PhoneDataArray)
//
//                    contactData.append(
//                        ContactModel(
//                            Name :"\(contact.givenName) \(contact.familyName)",
//
//
//                            //                        PhoneNumbers: contact.phoneNumbers.compactMap {           $0.value.stringValue.removeSpecialCharactersWithoutSpace},
//
//                            PhoneNumbers: PhoneDataArray,
//
//                            EmailAddresses: contact.emailAddresses.compactMap{$0.value as String },
//
//                            OrganizationName:  contact.organizationName,
//
//
//                            PostalAddress: contact.postalAddresses.compactMap{
//
//                                return  "\($0.value.street) \($0.value.city) \($0.value.postalCode) "
//
//
//                            },
//
//                            Nickname: contact.nickname
//
//                            // Note: contact.note,
//
//                        ))
//
//                    dispatchGroup.leave()
//
//
//
//
//
//
//
//                })
//
//
//
//
//
//                dispatchGroup.notify(queue: .main) {
//                              completion(contactData, nil)
//                          }
//
//                 //print(self.contactData)
//            }catch let err {
//                debugPrint("print to fetch Contact" ,  err)
//
//
//
//                    completion(nil, err)
//
//            }
//
//
//
//        }
//
//
//    }


    func handlingData(){
        
        
      
        //Mark: ****  retrieve all the Contact *********************
        /***************************************************/
        retrieveContacts { contactData, error in
            if let error = error {
                    print("Error", error)
                } else if let contactData = contactData {
                   
                    DispatchQueue.main.async {
                        
                        self.contactData = contactData
                        
                        print("Contact Data Size", self.contactData.count)
                       // self.processData()     // 005 temp commnted
                    }
                  
                }
        }
        
      
       
        
      
    }
    
    func processData(){
        
        
        var index = 0
        for contact in self.contactData{
           
            let mobilenoList = contact.PhoneNumbers.map{$0}
            let name = contact.Name
           
            if(mobilenoList.count > 0){
                for mobile in mobilenoList {
                 
                    index += 1
                    self.contactMainData.append(
                        ContactMainModel(id:index, name: name, mobileno: mobile)

                    )
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
            
        }
        
        do{
            
            //Mark :****** comment  For Showing contactMainData Details****
            
            
            let encodedData = try JSONEncoder().encode(contactData)
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
                let progressValue =   1.0 / Float(maxProgress)
           
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
      
        let alertSyncDashboard = self.alertService.alertSyncDashboard()
        
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






