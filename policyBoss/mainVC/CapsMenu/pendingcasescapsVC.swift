//
//  pendingcasescapsVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 17/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import SDWebImage
import MessageUI
import Alamofire





class pendingcasescapsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MyCellDelegate , MFMessageComposeViewControllerDelegate {
    
    
   
    
    @IBOutlet weak var pendingTV: UITableView!
    
    var customerName = [String]()
    var category = [String]()
    var applnStatus = [String]()
    var qaatype = [String]()
    var ppendingdays = [String]()
    var bankImage = [String]()
    var lead_Id = [String]()
    var lbl = ""
    var ids = [String]()
    var indexID = ""
    var quoteType = [String]()
    var quttype = ""
    var Message = ""
    var ApplnStatusPercntg = [String]()
        var leadID = ""
    
     var pendingCaseMainObj: PendingCaseMainMasterData? = nil
    
    
    
    ///////////////////  Added ////////////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ids",ids)

        self.title = "INSURANCE"
        self.lbl = "INSURANCE"
        
        if Connectivity.isConnectedToInternet()
        {
            pendingcasesinsurenceandloanAPI(type: "")
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    

    @IBAction func backBtnClicked(_ sender: Any) {
        
        self.remove()
    }
    
    
    //6. Implement Delegate Method
    func btnDeleteTapped(cell: pendingcaseTVCell)
    {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.pendingTV.indexPath(for: cell)
        var ID = "0"
        var Quotetype = ""
        if(lbl == "INSURANCE"){
            ID =  String((pendingCaseMainObj?.Insurance[indexPath!.row].Id)!)
            Quotetype =  (pendingCaseMainObj?.Insurance[indexPath!.row].quotetype)!
            
        }else{
            ID =   String((pendingCaseMainObj?.Loan[indexPath!.row].Id)!)
            Quotetype =  (pendingCaseMainObj?.Loan[indexPath!.row].quotetype)!
        }
        
     pendingcasesDeleteAPI(ID: ID, Quotetype: Quotetype)  //05 temp comment
        

        
        
        
//        indexID = ids[indexPath!.row]
//        quttype = quoteType[indexPath!.row]
//        deletependingcasesAPI()
//        if(indexID != "")
//        {
//            customerName.remove(at: (indexPath?.row)!)
//            category.remove(at: (indexPath?.row)!)
//            ppendingdays.remove(at: (indexPath?.row)!)
//            qaatype.remove(at: (indexPath?.row)!)
//            ApplnStatusPercntg.remove(at: (indexPath?.row)!)
////            self.pendingTV!.reloadData()
//
//        }
        
    }
    
 
      //---callleadHistoryView--
    func leadHistoryTapped(cell: pendingcaseTVCell) {
        
        // commented
        
        /*
          //Get the indexpath of cell where button was tapped
        let indexPath = self.pendingTV.indexPath(for: cell)
        var leadID = "0"
        if(lbl == "INSURANCE"){
            
            if(pendingCaseMainObj?.Insurance[indexPath!.row].Category == "Credit Card"){
                 leadID =  (pendingCaseMainObj?.Insurance[indexPath!.row].qatype)!
            }else{
                   leadID =  (pendingCaseMainObj?.Insurance[indexPath!.row].ApplicationNo)!
            }
           
            
            
        }else{
            if(pendingCaseMainObj?.Insurance[indexPath!.row].Category == "Credit Card"){
                leadID =  (pendingCaseMainObj?.Loan[indexPath!.row].qatype)!
            }else{
                leadID =  (pendingCaseMainObj?.Loan[indexPath!.row].ApplicationNo)!
            }
        }
    
        let loanleadHistory : loanleadHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "stbloanleadHistoryVC") as! loanleadHistoryVC
        loanleadHistory.leadIDString = String(leadID)
        
        loanleadHistory.modalPresentationStyle = .overFullScreen
        loanleadHistory.modalTransitionStyle = .crossDissolve
        self.present(loanleadHistory, animated: true)
        
        */
    }

 
    private func callNumber(phoneNumber:String) {
        
       if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    
    // Default overide for MessageDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true)
    }
    
    func displayMessageInterface(strMobile : String) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [strMobile]
        composeVC.body = "Finmart"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }

   //---<tableViewDatasource+Delegtes>---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return customerName.count
        
        if(lbl == "INSURANCE"){
            
            return  pendingCaseMainObj?.Insurance.count ?? 0
        }else{
            
           return  pendingCaseMainObj?.Loan.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! pendingcaseTVCell
        let borderColor = UIColor.gray
        cell.pendingcaseTVCellView.layer.cornerRadius=4.0;
        cell.pendingcaseTVCellView.layer.borderWidth=1.0;
        cell.pendingcaseTVCellView.layer.borderColor=borderColor.cgColor;

//        cell.pendingtitleLbl.text! = customerName[indexPath.row]
//        cell.categoryLbl.text! = category[indexPath.row]
//        cell.pendingdyLbl.text! = ppendingdays[indexPath.row]
//        cell.percentageLbl.text! = ApplnStatusPercntg[indexPath.row]+"%"
        //--<loadData>--
        
        
       
     
        let borderClr = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        if(lbl == "LOAN"){
            cell.qtypecirclLbl.isHidden = true
            cell.qtypeLbl.layer.borderWidth=1.0;
            cell.qtypeLbl.layer.borderColor=borderClr.cgColor;
            cell.qtypeLbl.layer.cornerRadius = 2.0
            cell.qtypeLbl.text! = pendingCaseMainObj?.Loan[indexPath.row].qatype ?? ""
          
            cell.qtypecirclLbl.text! = pendingCaseMainObj?.Loan[indexPath.row].qatype ?? ""
            cell.pendingtitleLbl.text! = pendingCaseMainObj?.Loan[indexPath.row].CustomerName ?? ""
            cell.categoryLbl.text! =     pendingCaseMainObj?.Loan[indexPath.row].Category ?? ""
            cell.pendingdyLbl.text! =    String(pendingCaseMainObj?.Loan[indexPath.row].pendingdays ?? 0)
            let percet =   pendingCaseMainObj?.Loan[indexPath.row].ApplnStatus ?? "0"
            cell.percentageLbl.text! =   percet + "%"
            if let imgURL = URL(string: pendingCaseMainObj?.Loan[indexPath.row].BankImage ?? ""){


                    cell.pImageView.sd_setImage(with: imgURL)
            }
            
            //--<show percentage on progressView>--
            let counter:Int = 0
            let value = pendingCaseMainObj?.Loan[indexPath.row].ApplnStatus ?? "0"
            let value1:Float = Float(value)!/100.0
            let animated = counter != 0
            cell.progressView.setProgress(value1, animated: animated)
            
            // 05
            cell.tapPhonePending = {
                
                let mobile =  self.pendingCaseMainObj?.Loan[indexPath.row].mobile ?? ""
                
                self.callNumber(phoneNumber: mobile)
            }
            
            ////displayMessageInterface
            cell.tapMessagePending = {
                
                let mobile =  self.pendingCaseMainObj?.Loan[indexPath.row].mobile ?? ""
                
                self.displayMessageInterface(strMobile: mobile)
            }

        }
        else if(lbl == "INSURANCE"){
            cell.qtypeLbl.isHidden = true
            cell.qtypecirclLbl.layer.borderWidth=1.0;
            cell.qtypecirclLbl.layer.borderColor=borderClr.cgColor;
          
            cell.qtypecirclLbl.layer.cornerRadius = cell.qtypecirclLbl.frame.size.width/2
            cell.qtypecirclLbl.clipsToBounds = true
            
            cell.qtypecirclLbl.text! = pendingCaseMainObj?.Insurance[indexPath.row].qatype ?? ""
       
            
            cell.qtypeLbl.text! = pendingCaseMainObj?.Insurance[indexPath.row].qatype ?? ""
            
            cell.pendingtitleLbl.text! = pendingCaseMainObj?.Insurance[indexPath.row].CustomerName ?? ""
            cell.categoryLbl.text! =     pendingCaseMainObj?.Insurance[indexPath.row].Category ?? ""
            cell.pendingdyLbl.text! =    String(pendingCaseMainObj?.Insurance[indexPath.row].pendingdays ?? 0)
            let percet =   pendingCaseMainObj?.Insurance[indexPath.row].ApplnStatus ?? "0"
            cell.percentageLbl.text! =   percet + "%"
            
            if let imgURL = URL(string: pendingCaseMainObj?.Insurance[indexPath.row].BankImage ?? ""){
                
                
                cell.pImageView.sd_setImage(with: imgURL)
            }
            
            //--<show percentage on progressView>--
            let counter:Int = 0
            let value = pendingCaseMainObj?.Insurance[indexPath.row].ApplnStatus ?? "0"
            let value1:Float = Float(value)!/100.0
            let animated = counter != 0
            cell.progressView.setProgress(value1, animated: animated)
            
            cell.tapPhonePending = {
                
                let mobile =  self.pendingCaseMainObj?.Insurance[indexPath.row].mobile ?? ""
                
                self.callNumber(phoneNumber: mobile)
            }
            
            cell.tapMessagePending = {
                
                let mobile =  self.pendingCaseMainObj?.Loan[indexPath.row].mobile ?? ""
                
                self.displayMessageInterface(strMobile: mobile)
            }

        }
        
      
        //--deleteRow--
        cell.delegate = self
     
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    //---<APICALL>---
    func deletependingcasesAPI()
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
        
        let params: [String: AnyObject] = ["id":indexID as AnyObject,
                                           "quotetype":quttype as AnyObject]
        
        let url = "delete-pending-cases"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            self.Message = ((jsonData![0] as AnyObject).value(forKey: "Message") as AnyObject) as! String
            
            
            DispatchQueue.main.async(execute: { () -> Void in
                // Present Alert Controller
                 self.pendingTV.reloadData()
            })
            
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

   
    
    func calledParentLoad(){
        
         let Pendingcases : PendingcasesVC = self.storyboard?.instantiateViewController(withIdentifier: "stbPendingcasesVC") as! PendingcasesVC
         Pendingcases.modalPresentationStyle = .fullScreen
          present(Pendingcases, animated: true, completion: nil)
          self.showToast(controller: Pendingcases, message: "Data Deleted Successfully...", seconds: 3)
    }
  
    func pendingcasesDeleteAPI(ID : String, Quotetype : String){
        
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
            
            
           
            
            let params: [String: AnyObject] = ["id": ID as AnyObject,
                                               "quotetype": Quotetype as AnyObject
                                              ]
            
            let endUrl = "delete-pending-cases"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            print("parameter= ",params)
            Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    


                case .success(let value):
                    
                    alertView.close()
                    
                 
                    
                    self.pendingcasesinsurenceandloanAPI(type: "DEL")  // load again
                    
                    
                case .failure(let error):
                    //  print(error)
                    alertView.close()
                    let snackbar = TTGSnackbar.init(message: "Failure", duration: .long)
                    snackbar.show()
                    
                   
                    
                }
            })
            
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
        
    }
    
    
    
    func pendingcasesinsurenceandloanAPI(type : String){
        
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
                            
                            
                            
                            if(type == "DEL"){
                                  self.showToast(controller: self, message: "Data Deleted Successfully...", seconds: 3)
                            }
                           
                            DispatchQueue.main.async(execute: { () -> Void in
                                // Present Alert Controller
                                if(self.pendingCaseMainObj?.Insurance.count ?? 0 > 0){
                                    
                                      self.pendingTV.reloadData()
                                }else{
                                    
                                    let snackbar = TTGSnackbar.init(message: "No Data Found ...", duration:.short)
                                    snackbar.show()
                                    
                                }
                              
                            })
                        
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
