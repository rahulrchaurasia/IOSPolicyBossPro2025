//
//  hnfraiseTicktVC.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class hnfraiseTicktVC: UIViewController,UITableViewDataSource,UITableViewDelegate,raiseCmntDelegate {

    @IBOutlet weak var raiseTicktTV: UITableView!
    
    var ticktIDS = [Int]()
    var ticktIdArray = [String]()
    var ticktStatusArray = [String]()
    var categoryArray = [String]()
    var discriptionArray = [String]()
    var commentArray = [String]()
    
    var reqTicktidIndex = ""
    var statusidIndex = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //--<apiCall>--
        getticketrequestAPI()
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticktIdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! hnfraiseticktTVCell
        
        cell.ticktIdLbl.text! = ticktIdArray[indexPath.row]
        cell.ticktStatusLbl.text! = ticktStatusArray[indexPath.row]
        cell.ticktCategryLbl.text! = categoryArray[indexPath.row]
//        cell.discrptionLbl.text! = discriptionArray[indexPath.row]
        
        cell.raiseticktDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    

    func getCmntBtnTapped(cell: hnfraiseticktTVCell) {
        print("comnt")
        let indexPath = self.raiseTicktTV.indexPath(for: cell)
        reqTicktidIndex = ticktIdArray[indexPath!.row]
        statusidIndex = ticktStatusArray[indexPath!.row]
        
        getticketcommentsAPI()

    }
    
    func addCmntBtnTapped(cell: hnfraiseticktTVCell) {
        print("addcmnt")
        let indexPath = self.raiseTicktTV.indexPath(for: cell)
        reqTicktidIndex = ticktIdArray[indexPath!.row]
        statusidIndex = ticktStatusArray[indexPath!.row]
        
        let viewCommentnAdd : viewCommentnAddVC = self.storyboard?.instantiateViewController(withIdentifier: "stbviewCommentnAddVC") as! viewCommentnAddVC
         viewCommentnAdd.modalPresentationStyle = .fullScreen
        viewCommentnAdd.fromScreen = "addComment"
        viewCommentnAdd.ticktreqId = self.reqTicktidIndex
        viewCommentnAdd.statusId = self.statusidIndex
        self.addChild(viewCommentnAdd)
        self.view.addSubview(viewCommentnAdd.view)
        
    }
    
    
    //--<addTicktCliked>--
    @IBAction func addTicktBtnCliked(_ sender: Any)
    {
        let addraisetickt : addraiseticktVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddraiseticktVC") as! addraiseticktVC
         addraisetickt.modalPresentationStyle = .fullScreen
        present(addraisetickt, animated: true, completion: nil)
    }
    
    @IBAction func addBtnCliked(_ sender: Any)
    {
        let addraisetickt : addraiseticktVC = self.storyboard?.instantiateViewController(withIdentifier: "stbaddraiseticktVC") as! addraiseticktVC
         addraisetickt.modalPresentationStyle = .fullScreen
        present(addraisetickt, animated: true, completion: nil)
    }
    
    
    //--<APICALL>--
    func getticketrequestAPI()
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

        let params: [String: AnyObject] = ["fbaid":FBAId as AnyObject]
        
        let url = "get-ticket-request"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let TicketRequestId = jsonData!.value(forKey: "TicketRequestId") as AnyObject
            self.ticktIDS = TicketRequestId as! [Int]
            self.ticktIdArray = self.ticktIDS.map { String($0) }
            let Status = jsonData!.value(forKey: "Status") as AnyObject
            self.ticktStatusArray = Status as! [String]
            let Description = jsonData!.value(forKey: "Description") as AnyObject
//            if(Description is NSNull)
//            {
//                self.discriptionArray = [""]
//            }
//            else{
//                self.discriptionArray = Description as! [String]
//
//            }
            let CateName = jsonData!.value(forKey: "CateName") as AnyObject
            self.categoryArray = CateName as! [String]
            
            self.raiseTicktTV.reloadData()
            
            
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
    
    
    func getticketcommentsAPI()
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
        
        let params: [String: AnyObject] = ["ticket_req_id": reqTicktidIndex as AnyObject]
        
        let url = "get-ticket-comments"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let comment = jsonData!.value(forKey: "comment") as AnyObject
            
                self.commentArray = comment as! [String]
                
                let viewCommentnAdd : viewCommentnAddVC = self.storyboard?.instantiateViewController(withIdentifier: "stbviewCommentnAddVC") as! viewCommentnAddVC
                viewCommentnAdd.modalPresentationStyle = .fullScreen
                viewCommentnAdd.fromScreen = "viewComment"
                viewCommentnAdd.commentListArray = self.commentArray
                viewCommentnAdd.ticktreqId = self.reqTicktidIndex
                viewCommentnAdd.statusId = self.statusidIndex
                self.addChild(viewCommentnAdd)
                self.view.addSubview(viewCommentnAdd.view)
            
            
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
