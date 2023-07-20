//
//  addSubUserVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 15/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class addSubUserVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var subuserTV: UITableView!
    var cfullNameArray = [String]()
    var cfbaIDArray = [String]()
    var cmobNoArray = [String]()
    var cemailIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getchildfbaAPI()
        

        
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {


          self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {

          self.dismiss(animated: false, completion: nil)
    }
    

    //---<tableview Datasource + delegates methods>---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cfullNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! addSubUserTVCell
        
        cell.celltitleLbl.text! = " " + cfullNameArray[indexPath.row]
        cell.fbaIdLbl.text! = cfbaIDArray[indexPath.row]
        cell.adsmobNoLbl.text! = cmobNoArray[indexPath.row]
        cell.adsemailIdLbl.text! = cemailIDArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    @IBAction func addSubUserBtnCliked(_ sender: Any)
    {
        let newaddSubUser : newaddSubUserVC = self.storyboard?.instantiateViewController(withIdentifier: "stbnewaddSubUserVC") as! newaddSubUserVC
        newaddSubUser.modalPresentationStyle = .fullScreen
        newaddSubUser.modalTransitionStyle = .coverVertical
        present(newaddSubUser, animated: false, completion: nil)
        
      
    }
    
    
    //--<APICALL>--
    func getchildfbaAPI()
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
        
        let params: [String: AnyObject] = ["FBAID": FBAId as AnyObject]
        
        let url = "get-child-fba"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let FBAID = jsonData?.value(forKey: "FBAID") as AnyObject
            let FullName = jsonData?.value(forKey: "FullName") as AnyObject
            let MobiNumb1 = jsonData?.value(forKey: "MobiNumb1") as AnyObject
            let EmailID = jsonData?.value(forKey: "EmailID") as AnyObject
            
            self.cfullNameArray = FullName as! [String]
            let stringArray = FBAID as! [Int]
            self.cfbaIDArray = stringArray.map { String($0) }
            
            self.cmobNoArray = MobiNumb1 as! [String]
            self.cemailIDArray = EmailID as! [String]
            
            self.subuserTV.reloadData()
            
            
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
