//
//  PendingcasesVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 14/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire

/************************************************************************
// Note : Here Tab menu is Used using "CAPSPageMenu" class
      So for current vc we can add multiple VC. ie pendingcasescapsVC  is added  with customizes
      title and name.
 
**************************************************************************/
class PendingcasesVC: UIViewController {
 
    

    var CAPSMenu : CAPSPageMenu?
    
    @IBOutlet weak var pendingcasesView: UIView!
    
    var CustomerName = [String]()
    var Category = [String]()
    var ApplnStatus = [String]()
    var qatype = [String]()
    var pendingdays = [Int]()
    var pendingDays = [String]()
    var Lead_Id = [String]()
    var BankImage = [String]()
    var iId = [Int]()
    var iID = [String]()
    var iquotetype = [String]()
    
    var lCustomerName = [String]()
    var lCategory = [String]()
    var lApplnStatus = [String]()
    var lqatype = [String]()
    var lpendingdays = [Int]()
    var lpendingDays = [String]()
    var lLead_Id = [String]()
    var lBankImage = [String]()
    var lId = [Int]()
    var lID = [String]()
    var lquotetype = [String]()
    
     var pendingCaseMainObj: PendingCaseMainMasterData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // capsMenu()   //05
        Menu()
        
        //--<apiCall>--
        if Connectivity.isConnectedToInternet()
        {
        pendingcasesinsurenceandloanAPI()  //05
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
          }
        
    }
    
    //-------<capsMenu>--------

    
      
  
    func Menu()
       {
           var controllerArray : [UIViewController] = []
           let storyboardName: String = "Main"
           let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
           
           let controller1: pendingcasescapsVC = storyboard.instantiateViewController(withIdentifier: "stbpendingcasescapsVC") as! pendingcasescapsVC
           
           
           controller1.title = "INSURANCE"
           controller1.lbl = "INSURANCE"
           
           controller1.pendingCaseMainObj = self.pendingCaseMainObj
            /////////
           controller1.customerName = CustomerName
           controller1.category = Category
           controller1.qaatype = qatype
           controller1.ppendingdays = pendingDays
           controller1.bankImage = BankImage
           controller1.ids = iID
           controller1.quoteType = iquotetype
           controller1.ApplnStatusPercntg = ApplnStatus
        
    
           
           ////////////
           
        controllerArray = [controller1]
        
        let parameters : [CAPSPageMenuOption] = [
            
            .scrollMenuBackgroundColor(UIColor(red: CGFloat(0.00 / 255.0), green: CGFloat(51.0 / 255.0), blue: CGFloat(91.0 / 255.0), alpha: CGFloat(1))),
            .viewBackgroundColor(UIColor(red: CGFloat(31.00 / 255.0), green: CGFloat(74.0 / 255.0), blue: CGFloat(132.0 / 255.0), alpha: CGFloat(1))),
            .selectionIndicatorColor(UIColor.white),
            
            .addBottomMenuHairline(true),
            .centerMenuItems(true),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.init(name: "HelveticaNeue", size: 15)!),
            .menuHeight(50.0),
            .menuItemWidth(0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectionIndicatorHeight(4),
            .useMenuLikeSegmentedControl(true),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .hideTopMenuBar(false)
        ]
        
     self.CAPSMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.pendingcasesView.frame.size.width, height: self.pendingcasesView.frame.size.height), pageMenuOptions: parameters)
          
          self.pendingcasesView.addSubview((self.CAPSMenu?.view)!)
           
       }
    func capsMenu()
    {
        var controllerArray : [UIViewController] = []
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let controller1: pendingcasescapsVC = storyboard.instantiateViewController(withIdentifier: "stbpendingcasescapsVC") as! pendingcasescapsVC
        
        
        controller1.title = "INSURANCE"
        controller1.lbl = "INSURANCE"
        
        controller1.pendingCaseMainObj = self.pendingCaseMainObj
         /////////
        controller1.customerName = CustomerName
        controller1.category = Category
        controller1.qaatype = qatype
        controller1.ppendingdays = pendingDays
        controller1.bankImage = BankImage
        controller1.ids = iID
        controller1.quoteType = iquotetype
        controller1.ApplnStatusPercntg = ApplnStatus
      
        ////////////
        
        let controller2: pendingcasescapsVC = storyboard.instantiateViewController(withIdentifier: "stbpendingcasescapsVC") as! pendingcasescapsVC
        controller2.title = "LOAN"
        controller2.lbl = "LOAN"
        controller2.pendingCaseMainObj = self.pendingCaseMainObj
        
        
        controller2.customerName = lCustomerName
        controller2.category = lCategory
        controller2.qaatype = lqatype
        controller2.ppendingdays = lpendingDays
        controller2.bankImage = lBankImage
    
        controller2.ids = lID
        controller2.quoteType = lquotetype
        controller2.ApplnStatusPercntg = lApplnStatus
       
        
        controllerArray = [controller1, controller2]
        
        let parameters : [CAPSPageMenuOption] = [
            
            .scrollMenuBackgroundColor(UIColor(red: CGFloat(0.00 / 255.0), green: CGFloat(51.0 / 255.0), blue: CGFloat(91.0 / 255.0), alpha: CGFloat(1))),
            .viewBackgroundColor(UIColor(red: CGFloat(31.00 / 255.0), green: CGFloat(74.0 / 255.0), blue: CGFloat(132.0 / 255.0), alpha: CGFloat(1))),
            .selectionIndicatorColor(UIColor.white),
            
            .addBottomMenuHairline(true),
            .centerMenuItems(true),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.init(name: "HelveticaNeue", size: 15)!),
            .menuHeight(50.0),
            .menuItemWidth(0),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectionIndicatorHeight(4),
            .useMenuLikeSegmentedControl(true),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .hideTopMenuBar(false)
        ]

        self.CAPSMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.pendingcasesView.frame.size.width, height: self.pendingcasesView.frame.size.height), pageMenuOptions: parameters)
        
        self.pendingcasesView.addSubview((self.CAPSMenu?.view)!)
        
    }
    
    

    @IBAction func pendingcasesBackBtn(_ sender: Any)
    {

        self.remove()
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {

        
          self.remove()
    }

    
//    //---<APICALL>---
//    func pendingcasesinsurenceandloanAPI_OLD()
//    {
//        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
//        if let parentView = self.navigationController?.view
//        {
//            alertView.parentView = parentView
//        }
//        else
//        {
//            alertView.parentView = self.view
//        }
//        alertView.show()
//
//        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
//
//        let params: [String: AnyObject] = ["Type":"0" as AnyObject,
//                                           "count":"0" as AnyObject,
//                                           "FBAID": FBAId as AnyObject]
//
//        let url = "/api/pending-cases-insurence-and-loan"
//
//        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
//            alertView.close()
//
//            self.view.layoutIfNeeded()
//
//            let jsonData = userObject as? NSDictionary
//
//            //<Insurance>
//            let Insurance = jsonData?.value(forKey: "Insurance") as! NSArray
//            for i in 0..<Insurance.count{
//
//                let dict = Insurance[i]
//                let BankImage1 =  (dict as AnyObject).value(forKey:"BankImage") as AnyObject
//                if(BankImage1 is NSNull || BankImage1 as! String == "" || BankImage1 as! String == "0")
//                {
//                    print("null>")
//                    self.BankImage.append("https://pngimage.net/wp-content/uploads/2018/06/white-image-png-3.png" as String)
//                    print("BankImage== ", self.BankImage)
//                }
//                else{
//                    self.BankImage.append(BankImage1 as! String)
//                    print("BankImage== ", self.BankImage)
//                }
//
//
//                let iCustomerName = (dict as AnyObject).value(forKey: "CustomerName") as! String
//                self.CustomerName.append(iCustomerName)
//                let iCategory = (dict as AnyObject).value(forKey: "Category") as! String
//                self.Category.append(iCategory)
//                let iqatype = (dict as AnyObject).value(forKey: "qatype") as! String
//                self.qatype.append(iqatype)
////                let ipendingdays = Insurance.value(forKey: "pendingdays") as AnyObject
////                self.pendingdays = ipendingdays as! [Int]
////                self.pendingDays = self.pendingdays.map { String($0) }
////                print("pendingDays=",self.pendingDays)
//                let ApplnStatus = (dict as AnyObject).value(forKey: "ApplnStatus") as! String
//                self.ApplnStatus.append(ApplnStatus)
//                let iquotetype = (dict as AnyObject).value(forKey: "quotetype") as! String
//                self.iquotetype.append(iquotetype)
////                let iId = Insurance.value(forKey: "Id") as AnyObject
////                self.iId = iId as! [Int]
////                self.iID = self.iId.map { String($0) }
////                print("iID=",self.iID)
//
//            }
//            let ipendingdays = Insurance.value(forKey: "pendingdays") as AnyObject
//            self.pendingdays = ipendingdays as! [Int]
//            self.pendingDays = self.pendingdays.map { String($0) }
//            let iId = Insurance.value(forKey: "Id") as AnyObject
//            self.iId = iId as! [Int]
//            self.iID = self.iId.map { String($0) }
//
//
//            //<Loan>
//            let Loan = jsonData?.value(forKey: "Loan") as! NSArray
//            for i in 0..<Loan.count{
//
//                let dict = Loan[i]
//                let lBankImage2 =  (dict as AnyObject).value(forKey:"BankImage") as AnyObject
//                if(lBankImage2 is NSNull || lBankImage2 as! String == "" || lBankImage2 as! String == "0")
//                {
//                    print("null>")
//                    self.lBankImage.append("https://pngimage.net/wp-content/uploads/2018/06/white-image-png-3.png" as String)
//                    print("lBankImage== ", self.lBankImage)
//                }
//                else{
//                    self.lBankImage.append(lBankImage2 as! String)
//                    print("lBankImage== ", self.lBankImage)
//                }
//
//
//                let lCustomerName = (dict as AnyObject).value(forKey: "CustomerName") as! String
//                self.lCustomerName.append(lCustomerName)
//                let lCategory = (dict as AnyObject).value(forKey: "Category") as! String
//                self.lCategory.append(lCategory)
//                let lqatype = (dict as AnyObject).value(forKey: "qatype") as! String
//                self.lqatype.append(lqatype)
////                let lpendingdays = Loan.value(forKey: "pendingdays") as AnyObject
////                self.lpendingdays = lpendingdays as! [Int]
////                self.lpendingDays = self.lpendingdays.map { String($0) }
////                print("lpendingDays=",self.lpendingDays)
//                let lApplnStatus = (dict as AnyObject).value(forKey: "ApplnStatus") as! String
//                self.lApplnStatus.append(lApplnStatus)
//                let lquotetype = (dict as AnyObject).value(forKey: "quotetype") as! String
//                self.lquotetype.append(lquotetype)
////                let lId = Loan.value(forKey: "Id") as AnyObject
////                self.lId = lId as! [Int]
////                self.lID = self.lId.map { String($0) }
////                print("lID=",self.lID)
//
//            }
//            let lpendingdays = Loan.value(forKey: "pendingdays") as AnyObject
//            self.lpendingdays = lpendingdays as! [Int]
//            self.lpendingDays = self.lpendingdays.map { String($0) }
//            let lId = Loan.value(forKey: "Id") as AnyObject
//            self.lId = lId as! [Int]
//            self.lID = self.lId.map { String($0) }
//
//            self.capsMenu()
//
//        }, onError: { errorData in
//            alertView.close()
//            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
//            snackbar.show()
//        }, onForceUpgrade: {errorData in})
//
//
//    }
//
//
//
    
    ////////////////////////////////////////////
    
    func pendingcasesinsurenceandloanAPI(){
        
        if Connectivity.isConnectedToInternet()
        {
            print("internet is available.")
            
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
            
            let params: [String: AnyObject] = ["Type":"0" as AnyObject,
                                               "count":"0" as AnyObject,
                                               "FBAID": FBAId as AnyObject]
            
            let endUrl = "pending-cases-insurence-and-loan"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            print("parameter= ",params)
            Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                    
                case .success(let value):
                    
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(PendingCaseMainModel.self, from: data)
                        print("pending Case Done", obj)
                        if obj.StatusNo == 0 {
                            
                            self.pendingCaseMainObj = obj.MasterData
                            self.Menu()               //  Load Page Menu
                            
                        }else{
                            
                            let snackbar = TTGSnackbar.init(message: obj.Message , duration: .long)
                            snackbar.show()
                        }

                        
                    } catch let error {
                        print(error)
                        alertView.close()
                        
                        let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                        snackbar.show()
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: error as! String, duration: .long)
                    snackbar.show()
                }
            })
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
    }
    
}



