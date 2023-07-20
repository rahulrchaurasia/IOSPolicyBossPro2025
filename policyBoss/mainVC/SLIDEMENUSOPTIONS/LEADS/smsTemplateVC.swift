//
//  smsTemplateVC.swift
//  MagicFinmart
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class smsTemplateVC: UIViewController,UITableViewDelegate,UITableViewDataSource,smscellDelegates {
    
    @IBOutlet var smsTempTV: UITableView!
    var templeteArray = [String]()
    var fbasmsidArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //apiCall
        getcustomerssmstemplateAPI()
        
    }
    

    @IBAction func backBtnCliked(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    //tableViewDatasource+Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templeteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! smsTempTVCell
        
        cell.smscellLbl.text! = templeteArray[indexPath.row]
        
        //--buttonRow--
        cell.smsmdelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func smsBtnTapped(cell: smsTempTVCell)
    {
        let indexPath = self.smsTempTV.indexPath(for: cell)
        let text = self.templeteArray[(indexPath?.row)!]
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        present(vc, animated: true)
        
    }
    

    
    //--<APICALL>--
    func getcustomerssmstemplateAPI()
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
        
        let url = "get-customers-sms-template_pb"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let templete = jsonData!.value(forKey: "templete") as AnyObject
            self.templeteArray = templete as! [String]
            let fba_sms_id = jsonData!.value(forKey: "fba_sms_id") as AnyObject            
            
            self.smsTempTV.reloadData()
            
            
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
