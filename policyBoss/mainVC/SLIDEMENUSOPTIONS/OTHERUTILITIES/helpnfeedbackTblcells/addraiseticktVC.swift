//
//  addraiseticktVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import MobileCoreServices

class addraiseticktVC: UIViewController,getPickerDataDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate
 {

    @IBOutlet weak var browseBtnView: UIView!
    @IBOutlet weak var cetegoryLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var classifictnLbl: UILabel!
    @IBOutlet weak var fileattchmentLbl: UILabel!
    @IBOutlet weak var enterMsgTf: ACFloatingTextfield!
    
    var classificationArray = [String]()
    var CateCodeArray = [String]()
    var categoryArray = [String]()
    
    var subCategoryArray1 = [String]()
    var subCategoryArray2 = [String]()
    var subCategoryArray3 = [String]()
    var subCategoryArray4 = [String]()
    var subCategoryArray5 = [String]()
    var subCategoryArray6 = [String]()
    
    var classifictnArray1 = [String]()
    var classifictnArray2 = [String]()
    var classifictnArray3 = [String]()
    var classifictnArray4 = [String]()
    var classifictnArray5 = [String]()
    var classifictnArray6 = [String]()
    var classifictnArray7 = [String]()
    var classifictnArray8 = [String]()
    var classifictnArray9 = [String]()
    var classifictnArray10 = [String]()
    var classifictnArray11 = [String]()
    var classifictnArray12 = [String]()
    var classifictnArray13 = [String]()
    var classifictnArray14 = [String]()
    var classifictnArray15 = [String]()
    var classifictnArray16 = [String]()
    var classifictnArray17 = [String]()
    
    var subcateCodeArray1 = [String]()
    var subcateCodeArray2 = [String]()
    var subcateCodeArray3 = [String]()
    var subcateCodeArray4 = [String]()
    var subcateCodeArray5 = [String]()
    var subcateCodeArray6 = [String]()
    
    var classicodeArray1 = [String]()
    var classicodeArray2 = [String]()
    var classicodeArray3 = [String]()
    var classicodeArray4 = [String]()
    var classicodeArray5 = [String]()
    var classicodeArray6 = [String]()
    var classicodeArray7 = [String]()
    var classicodeArray8 = [String]()
    var classicodeArray9 = [String]()
    var classicodeArray10 = [String]()
    var classicodeArray11 = [String]()
    var classicodeArray12 = [String]()
    var classicodeArray13 = [String]()
    var classicodeArray14 = [String]()
    var classicodeArray15 = [String]()
    var classicodeArray16 = [String]()
    var classicodeArray17 = [String]()
    
    var CateCode = String()
    var categoryId = ""
    var subcateId = ""
    var classifictnId = ""
    var QuerID = Int()
    
    var QuerID1 = Int()
    var QuerID2 = Int()
    var QuerID3 = Int()
    var QuerID4 = Int()
    var QuerID5 = Int()
    var QuerID6 = Int()
    var QuerID7 = Int()
    var QuerID8 = Int()
    var QuerID9 = Int()
    var QuerID10 = Int()
    var QuerID11 = Int()
    var QuerID12 = Int()
    var QuerID13 = Int()
    var QuerID14 = Int()
    var QuerID15 = Int()
    var QuerID16 = Int()
    var QuerID17 = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        browseBtnView.layer.cornerRadius=2.0;
        browseBtnView.layer.borderWidth=2.0;
        browseBtnView.layer.borderColor=borderColr.cgColor;
        
        //--<apiCall>--
        getticketcategoriesAPI()
        
    }
    

    @IBAction func bckBtnCliked(_ sender: Any)
    {
        let hnfraiseTickt : hnfraiseTicktVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfraiseTicktVC") as! hnfraiseTicktVC
         hnfraiseTickt.modalPresentationStyle = .fullScreen
        present(hnfraiseTickt, animated: true, completion: nil)
    }
    
    
    @IBAction func selctCategryBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
        Picker.fromScreen = "category"
        Picker.pickerData = ["Select"]+categoryArray
        Picker.pickerIdData = [""]+CateCodeArray
        self.addChild(Picker)
        self.view.addSubview(Picker.view)
        Picker.pickerdelegate = self
    }
    
    @IBAction func selctsubCategryBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        if(cetegoryLbl.text! != "Select Category" && cetegoryLbl.text! != "Select")
        {
            let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
            Picker.fromScreen = "subCategory"
            if(self.cetegoryLbl.text! == "FBA App")
            {
                Picker.pickerData = ["Select"]+subCategoryArray1
                Picker.pickerIdData = [""]+subcateCodeArray1
            }
            else if(self.cetegoryLbl.text! == "Training App")
            {
                Picker.pickerData = ["Select"]+subCategoryArray2
                Picker.pickerIdData = [""]+subcateCodeArray2
            }
            else if(self.cetegoryLbl.text! == "Product")
            {
                Picker.pickerData = ["Select"]+subCategoryArray3
                Picker.pickerIdData = [""]+subcateCodeArray3
            }
            else if(self.cetegoryLbl.text! == "Insurance Claims Related")
            {
                Picker.pickerData = ["Select"]+subCategoryArray4
                Picker.pickerIdData = [""]+subcateCodeArray4
            }
            else if(self.cetegoryLbl.text! == "My Finmart Account Related")
            {
                Picker.pickerData = ["Select"]+subCategoryArray5
                Picker.pickerIdData = [""]+subcateCodeArray5
            }
            else if(self.cetegoryLbl.text! == "Product Related")
            {
                Picker.pickerData = ["Select"]+subCategoryArray6
                Picker.pickerIdData = [""]+subcateCodeArray6
            }
            
            self.addChild(Picker)
            self.view.addSubview(Picker.view)
            Picker.pickerdelegate = self
        }
        else{
            TTGSnackbar.init(message: "Select Category", duration: .long).show()
        }
        
    }
    
    @IBAction func selctClassifctnBtnCliked(_ sender: Any)
    {
        self.view.endEditing(true)
        if(cetegoryLbl.text! != "Select Category" && cetegoryLbl.text! != "Select")
        {
            if(subCategoryLbl.text! != "Select Sub Category" && subCategoryLbl.text! != "Select")
            {
                let Picker : PickerViewVC! = storyboard?.instantiateViewController(withIdentifier: "stbPickerViewVC") as? PickerViewVC
                Picker.fromScreen = "classification"
                if(self.QuerID1 == 21)
                {
                    Picker.pickerData = ["Select"]+classifictnArray1
                    Picker.pickerIdData = [""]+classicodeArray1
                }
                else if(self.QuerID2 == 22)
                {
                    Picker.pickerData = ["Select"]+classifictnArray2
                    Picker.pickerIdData = [""]+classicodeArray2
                }
                else if(self.QuerID3 == 30)
                {
                    Picker.pickerData = ["Select"]+classifictnArray3
                    Picker.pickerIdData = [""]+classicodeArray3
                }
                else if(self.QuerID4 == 31)
                {
                    Picker.pickerData = ["Select"]+classifictnArray4
                    Picker.pickerIdData = [""]+classicodeArray4
                }
                else if(self.QuerID5 == 32)
                {
                    Picker.pickerData = ["Select"]+classifictnArray5
                    Picker.pickerIdData = [""]+classicodeArray5
                }
                else if(self.QuerID6 == 33)
                {
                    Picker.pickerData = ["Select"]+classifictnArray6
                    Picker.pickerIdData = [""]+classicodeArray6
                }
                else if(self.QuerID7 == 34)
                {
                    Picker.pickerData = ["Select"]+classifictnArray7
                    Picker.pickerIdData = [""]+classicodeArray7
                }
                else if(self.QuerID8 == 35)
                {
                    Picker.pickerData = ["Select"]+classifictnArray8
                    Picker.pickerIdData = [""]+classicodeArray8
                }
                else if(self.QuerID9 == 36)
                {
                    Picker.pickerData = ["Select"]+classifictnArray9
                    Picker.pickerIdData = [""]+classicodeArray9
                }
                else if(self.QuerID10 == 37)
                {
                    Picker.pickerData = ["Select"]+classifictnArray10
                    Picker.pickerIdData = [""]+classicodeArray10
                }
                else if(self.QuerID11 == 38)
                {
                    Picker.pickerData = ["Select"]+classifictnArray11
                    Picker.pickerIdData = [""]+classicodeArray11
                }
                else if(self.QuerID12 == 39)
                {
                    Picker.pickerData = ["Select"]+classifictnArray12
                    Picker.pickerIdData = [""]+classicodeArray12
                }
                else if(self.QuerID13 == 40)
                {
                    Picker.pickerData = ["Select"]+classifictnArray13
                    Picker.pickerIdData = [""]+classicodeArray13
                }
                else if(self.QuerID14 == 41)
                {
                    Picker.pickerData = ["Select"]+classifictnArray14
                    Picker.pickerIdData = [""]+classicodeArray14
                }
                else if(self.QuerID15 == 42)
                {
                    Picker.pickerData = ["Select"]+classifictnArray15
                    Picker.pickerIdData = [""]+classicodeArray15
                }
                else if(self.QuerID16 == 43)
                {
                    Picker.pickerData = ["Select"]+classifictnArray16
                    Picker.pickerIdData = [""]+classicodeArray16
                }
                else if(self.QuerID17 == 44)
                {
                    Picker.pickerData = ["Select"]+classifictnArray17
                    Picker.pickerIdData = [""]+classicodeArray17
                }
                
                self.addChild(Picker)
                self.view.addSubview(Picker.view)
                Picker.pickerdelegate = self
            }
            else{
                TTGSnackbar.init(message: "Select SubCategory", duration: .long).show()
            }
        }
        else{
            TTGSnackbar.init(message: "Select Category", duration: .long).show()
        }
    }
    
    func getPickerDataValue(pickerSelectedData: String, fromScreen: String, pickerSelectedId: String) {
        switch fromScreen
        {
        case "category":
            self.cetegoryLbl.text = pickerSelectedData
            self.categoryId = pickerSelectedId
            break
        case "subCategory":
            self.subCategoryLbl.text = pickerSelectedData
            self.subcateId = pickerSelectedId
            break
        case "classification":
            self.classifictnLbl.text = pickerSelectedData
            self.classifictnId = pickerSelectedId
            break
        default:
            break
        }
        
    }
    
    @IBAction func browseBtnCliked(_ sender: Any)
    {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    //--<document Delgates method>--
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
    }
    
    
    func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitBtnCliked(_ sender: Any)
    {
        if(cetegoryLbl.text! != "Select Category" && cetegoryLbl.text! != "Select")
        {
            if(subCategoryLbl.text! != "Select Sub Category" && subCategoryLbl.text! != "Select")
            {
                if(classifictnLbl.text! != "Select Classifications" && classifictnLbl.text! != "Select")
                {
                    createticketAPI()
                }
                else{
                    TTGSnackbar.init(message: "Select Classification", duration: .long).show()
                }
            }
            else{
                TTGSnackbar.init(message: "Select SubCategory", duration: .long).show()
            }
        }
        else{
            TTGSnackbar.init(message: "Select Category", duration: .long).show()
        }
        
        
    }
    
    //--<APICALL>--
    func getticketcategoriesAPI()
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
        
        let url = "get-ticket-categories"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSDictionary
            
            //category
            let category = jsonData!.value(forKey: "category") as AnyObject
            let CateName = category.value(forKey: "CateName") as AnyObject
            self.categoryArray = CateName as! [String]
            let CateCode = category.value(forKey: "CateCode") as AnyObject
            print ("CateCode",CateCode)
            let subCateCodeid = CateCode as! [String]
            self.CateCodeArray = subCateCodeid.map { String($0) }

            
            //subcategory
            let subcategory = jsonData!.value(forKey: "subcategory") as! NSArray
            print ("subcategory",subcategory)
            for i in 0..<subcategory.count {
                
                let dict = subcategory[i]
                
//                self.CateCode =  (((dict as AnyObject).value(forKey:"CateCode") as AnyObject) as! String)
//                print("CateCode== ", self.CateCode)
                let CateCodes = (dict as AnyObject).value(forKey: "CateCode") as! Int
                self.CateCode = String(CateCodes)
                
                if(self.CateCode == "1")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray1.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray1.append(subCateCodeid)
////                    let subCateCodeid = QuerID as! [String]
//                    self.subcateCodeArray1.append(QuerID as! String)
//                    print("subcateCodeArray1= ", self.subcateCodeArray1)
//                    let subCateCodeid = QuerID as! [String]
//                    let subCateCodeA = subCateCodeid.map { String($0) }
//                    print("subCateCodeA= ", subCateCodeA)
                }
                if(self.CateCode == "2")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray2.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray2.append(subCateCodeid)
//                    let subCateCodeid = QuerID as! [String]
//                    self.subcateCodeArray2 = subCateCodeid.map { String($0) }
//                    print("subcateCodeArray2= ", self.subcateCodeArray2)
                }
                if(self.CateCode == "3")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray3.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray3.append(subCateCodeid)
//                    let subCateCodeid = QuerID as! [String]
//                    self.subcateCodeArray3 = subCateCodeid.map { String($0) }
//                    print("subcateCodeArray3= ", self.subcateCodeArray3)
                }
                if(self.CateCode == "4")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray4.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray4.append(subCateCodeid)
                    //                    let subCateCodeid = QuerID as! [String]
                    //                    self.subcateCodeArray3 = subCateCodeid.map { String($0) }
                    //                    print("subcateCodeArray3= ", self.subcateCodeArray3)
                }
                if(self.CateCode == "5")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray5.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray5.append(subCateCodeid)
                    //                    let subCateCodeid = QuerID as! [String]
                    //                    self.subcateCodeArray3 = subCateCodeid.map { String($0) }
                    //                    print("subcateCodeArray3= ", self.subcateCodeArray3)
                }
                if(self.CateCode == "6")
                {
                    let QuerType =  (dict as AnyObject).value(forKey:"QuerType") as! String
                    self.subCategoryArray6.append(QuerType)
                    let QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                    let subCateCodeid = String(QuerID)
                    self.subcateCodeArray6.append(subCateCodeid)
                    //                    let subCateCodeid = QuerID as! [String]
                    //                    self.subcateCodeArray3 = subCateCodeid.map { String($0) }
                    //                    print("subcateCodeArray3= ", self.subcateCodeArray3)
                }
                
            
            }
            
          
            //classification
            let classification = jsonData!.value(forKey: "classification") as! NSArray
            print("classification= ", classification)
            
            for i in 0..<classification.count {
                
                let dict = classification[i]
                print("dict=",dict)
                
                self.QuerID =  (dict as AnyObject).value(forKey:"QuerID") as! Int
                print("QuerID== ", self.QuerID)
                
                
                if(self.QuerID == 21)
                {
                    self.QuerID1 = 21
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray1.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray1.append(subCateCodeid)
                    
                }
                if(self.QuerID == 22)
                {
                    self.QuerID2 = 22
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray2.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray2.append(subCateCodeid)
                    
                }
                if(self.QuerID == 30)
                {
                    self.QuerID3 = 30
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray3.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray3.append(subCateCodeid)
                    
                }
                if(self.QuerID == 31)
                {
                    self.QuerID4 = 31
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray4.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray4.append(subCateCodeid)
                }
                if(self.QuerID == 32)
                {
                    self.QuerID5 = 32
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray5.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray5.append(subCateCodeid)
                }
                if(self.QuerID == 33)
                {
                    self.QuerID6 = 33
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray6.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray6.append(subCateCodeid)
                }
                if(self.QuerID == 34)
                {
                    self.QuerID7 = 34
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray7.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray7.append(subCateCodeid)
                }
                if(self.QuerID == 35)
                {
                    self.QuerID8 = 35
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray8.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray8.append(subCateCodeid)
                }
                if(self.QuerID == 36)
                {
                    self.QuerID9 = 36
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray9.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray9.append(subCateCodeid)
                }
                if(self.QuerID == 37)
                {
                    self.QuerID10 = 37
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray10.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray10.append(subCateCodeid)
                }
                if(self.QuerID == 38)
                {
                    self.QuerID11 = 38
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray11.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray11.append(subCateCodeid)
                }
                if(self.QuerID == 39)
                {
                    self.QuerID12 = 39
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray12.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray12.append(subCateCodeid)
                }
                if(self.QuerID == 40)
                {
                    self.QuerID13 = 40
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray13.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray13.append(subCateCodeid)
                }
                if(self.QuerID == 41)
                {
                    self.QuerID14 = 41
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray14.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray14.append(subCateCodeid)
                }
                if(self.QuerID == 42)
                {
                    self.QuerID15 = 42
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray15.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray15.append(subCateCodeid)
                }
                if(self.QuerID == 43)
                {
                    self.QuerID16 = 43
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray16.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray16.append(subCateCodeid)
                }
                if(self.QuerID == 44)
                {
                    self.QuerID17 = 44
                    let Description =  (dict as AnyObject).value(forKey:"Description") as! String
                    self.classifictnArray17.append(Description)
                    let ID =  (dict as AnyObject).value(forKey:"ID") as! Int
                    let subCateCodeid = String(ID)
                    self.classicodeArray17.append(subCateCodeid)
                }
               
                
            }
         
            
            
            
            
            /*
            //subcategory
            let subcategory = jsonData!.value(forKey: "subcategory") as AnyObject
            print("subcategory= ", subcategory)
            let QuerType = subcategory.value(forKey: "QuerType") as AnyObject
            print("QuerType= ", QuerType)
            self.subCategoryArray = QuerType as! [String]
            let subCateCode = subcategory.value(forKey: "CateCode") as AnyObject
            print("subCateCode= ", subCateCode)
            
            let subCateCodeid = subCateCode as! [String]
            let subCateCodeA = subCateCodeid.map { String($0) }
            print("subCateCodeA= ", subCateCodeA)
            */
//            //classification
//            let classification = jsonData!.value(forKey: "classification") as AnyObject
//            print("classification= ", classification)
//            let Description = classification.value(forKey: "Description") as AnyObject
//            print("Description= ", Description)
//            self.classifictnArray1 = Description as! [String]
//            let QuerID = classification.value(forKey: "QuerID") as AnyObject
//            print("QuerID= ", QuerID)
 
           
            
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
    
    func createticketAPI()
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
        
        let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject,
                                           "CategoryId": categoryId as AnyObject,
                                           "Message": enterMsgTf.text! as AnyObject,
                                           "SubCategoryId": subcateId as AnyObject,
                                           "classification": classifictnId as AnyObject]
        
        print("params",params)
        
        let url = "/api/create-ticket"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            print("jsonData=",jsonData!)
            let Message = jsonData!.value(forKey: "Message") as AnyObject
            print("Message= ", Message)
            
            TTGSnackbar.init(message: "Ticket raised successfully", duration: .long).show()
            
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
