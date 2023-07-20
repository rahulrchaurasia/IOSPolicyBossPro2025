//
//  transctionHistoryVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class transctionHistoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var transctnTV: UITableView!
    
    var ProductNameArray = [String]()
    var EntryNoArray = [String]()
    var PremiumArray = [String]()
    var InsCompanyArray = [String]()
    var EntryDateArray = [String]()
    var Total_ODArray = [String]()
    var intTotal_ODArray = [Int]()
    var intPremiumArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //--<apiCall>--
        gettransactionhistoryAPI()
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
//        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//        KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
       
          self.dismiss(animated: false, completion: nil)
    }
    
    //--<tableView Datasource+Delegate Method>--
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! transctnHisTVCell
        
        cell.trantitleLbl.text! = ProductNameArray[indexPath.row].uppercased()
        cell.tranentryNameLbl.text! = EntryNoArray[indexPath.row]
        cell.traninsurerLbl.text! = InsCompanyArray[indexPath.row]
        cell.tranpremiumLbl.text! = PremiumArray[indexPath.row]
        cell.trantotalOdLbl.text! = Total_ODArray[indexPath.row]
        cell.tranentryDateLbl.text! = EntryDateArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
    //--<APICALL>--
    func gettransactionhistoryAPI()
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
        
        let params: [String: AnyObject] = ["pageno":"1" as AnyObject,
                                           "fbaid":FBAId as AnyObject]
        
        let url = "get-transaction-history"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let ProductName = jsonData?.value(forKey: "ProductName") as AnyObject
            self.ProductNameArray = ProductName as! [String]
            let EntryNo = jsonData?.value(forKey: "EntryNo") as AnyObject
            self.EntryNoArray = EntryNo as! [String]
            let InsCompany = jsonData?.value(forKey: "InsCompany") as AnyObject
            self.InsCompanyArray = InsCompany as! [String]
            let Premium = jsonData?.value(forKey: "Premium") as AnyObject
            self.intPremiumArray = Premium as! [Int]
            self.PremiumArray = self.intPremiumArray.map { String($0) }
            let EntryDate = jsonData?.value(forKey: "EntryDate") as AnyObject
            self.EntryDateArray = EntryDate as! [String]
            let Total_OD = jsonData?.value(forKey: "Total_OD") as AnyObject
            self.intTotal_ODArray = Total_OD as! [Int]
            self.Total_ODArray = self.intTotal_ODArray.map { String($0) }
            
            self.transctnTV.reloadData()
            
            
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
