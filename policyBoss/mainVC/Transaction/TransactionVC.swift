//
//  TransactionVC.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 07/11/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class TransactionVC: UIViewController  ,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    
    var transationHistorList = [TransationHistoryData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchTransactionHistory()
    }
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func   fetchTransactionHistory() {
        
        
        // getshortLink
        if Connectivity.isConnectedToInternet(){
            
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
            
            
            
            APIManger.shareInstance.getTransactionHistory()
            { (result) in
                
                alertView.close()
                switch result {
                    
                case .success(let objResponse):
                    
                    let transationHistoryResponse = objResponse as! TransationHistoryResponse
                    
                    self.transationHistorList = transationHistoryResponse.MasterData!
                    self.transactionTableView.reloadData()
                    
                    
                case .failure(.custom(message: let error)):
                    let snackbar = TTGSnackbar.init(message: error, duration: .middle )
                    snackbar.show()
                }
            }
        }
        else{
            
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transationHistorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TranscationHistoryCell
        
        
      //  cell.configureCell(menu: transationHistorList[indexPath.section].menuModel[indexPath.row])
        
        cell.configureCell(transactionData:
                            transationHistorList[indexPath.row])
        return cell
    }
    



}
