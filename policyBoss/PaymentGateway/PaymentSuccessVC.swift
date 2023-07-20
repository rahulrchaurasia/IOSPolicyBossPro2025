//
//  PaymentSuccessVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 12/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar
import Alamofire

class PaymentSuccessVC: UIViewController {

    
    
      var CustId = ""
      var paymentID  = ""
   

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         initialize()

        if(paymentID != ""){
            
             addRazorData()
        }
        
        
    }
    
    
    func initialize()
    {
        lblMessage.text = ""
        
        cardView.backgroundColor = .white
        
        cardView.layer.cornerRadius = 10.0
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        cardView.layer.shadowRadius = 6.0
        
        cardView.layer.shadowOpacity = 0.7
        
        
        
        
    }
    
    
    @IBAction func btnContinueClick(_ sender: Any) {
        

        
         self.dismissAll(animated: false)
    }
    
    
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        
        self.dismissAll(animated: false)
    }
    

    
 
    // Add RazorID to DB
    
    func addRazorData(){
        
      
        
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
            
            
            let parameter  :[String: AnyObject] = [
                
                "FBAID": FBAId as AnyObject,
                "CustId": CustId as AnyObject,
                "PayId": paymentID as AnyObject
            ]
            let endUrl = "Addtorazorpaydata"
            let url =  FinmartRestClient.baseURLString  + endUrl
            print("urlRequest= ",url)
            print("parameter= ",parameter)
            Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                    alertView.close()
                    
                    self.view.layoutIfNeeded()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(AddToRazorpayModel.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                        
                            self.lblMessage.text = obj.MasterData[0].respmsg
                            print("REMESSAGE= ",obj.MasterData[0].respmsg)
                            
                            
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
