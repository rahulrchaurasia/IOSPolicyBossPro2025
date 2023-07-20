//
//  PaymentMainController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 09/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import Razorpay
import CustomIOSAlertView
import TTGSnackbar
import Alamofire

class PaymentMainController: UIViewController ,RazorpayPaymentCompletionProtocol {
   
    
    //,RazorpayPaymentCompletionProtocol
    
    //let razorpaykeyLive = "rzp_live_b7vQ8lyFs69syy"    // old Finmart connected to datacomp

    // Below razorpaykeyLive is For PolicyBoss live
    let razorpaykeyLive = "rzp_live_DFxDFYDslN2DIq"
    let rupee = "\u{20B9}"
    
   // var razorpay: Razorpay!
    var razorpay: RazorpayCheckout!
    var paymentDtlObj: PaymentDetailMasterData? = nil
    
    
    
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnPayment: UIButton!
    
    @IBOutlet weak var cardview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblCustomerName: UILabel!
    
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       razorpay = RazorpayCheckout.initWithKey(razorpaykeyLive, andDelegate: self)
         initialize()
        
         getPaymentDetail()
        
        
    }
    
    
    func initialize()
    {
        mainView.backgroundColor = .white

        mainView.layer.cornerRadius = 10.0

        mainView.layer.shadowColor = UIColor.gray.cgColor

        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        mainView.layer.shadowRadius = 6.0

        mainView.layer.shadowOpacity = 0.7
     
        
       
        
    }
    
    
    @IBAction func btnPayment(_ sender: Any) {
        
       
        showPaymentForm()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        
        print("cancel")
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let KYDrawer : KYDrawerController = storyboard.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//         KYDrawer.modalPresentationStyle = .fullScreen
//        present(KYDrawer, animated: true, completion: nil)
        
        
        self.dismissAll(animated: false)

    }
    

    func onPaymentError(_ code: Int32, description str: String) {
        
       let paymentCancelVC : PaymentCancelController = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentCancelController") as! PaymentCancelController

        paymentCancelVC.modalPresentationStyle = .fullScreen
        paymentCancelVC.custID = paymentDtlObj?.CustID ?? ""
        self.addChild(paymentCancelVC)
        self.view.addSubview(paymentCancelVC.view)
        
      
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        
        
        moveToSuccessVC(paymentID: payment_id)
        
    }
   
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        
      self.dismissAll(animated: false)
        
        
        
    }
    
    //05
    internal func showPaymentForm(){
       // navigationController?.setNavigationBarHidden(true, animated: true)

        if (paymentDtlObj?.CustID) != nil {
        let options: [String:Any] = [
            "amount": paymentDtlObj!.amount as Any, //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",
            "description": paymentDtlObj!.CustID ,
            "image":  paymentDtlObj!.image ,

            "name": paymentDtlObj!.Name ,
            "prefill": [
                "contact": paymentDtlObj!.Mobile  ,
                "email": paymentDtlObj?.Email
            ],
            "theme": [
                "color": "#009ee3"
            ]
        ]
         // razorpay.open(options)
            razorpay.open(options , displayController : self)
            
        }
    }
    
 
    
    
    func getPaymentDetail(){
        
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
                
                "FBAID": FBAId as AnyObject
            ]
            let endUrl = "getfbadataforrpay"
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
                        let obj = try decoder.decode(PaymentDetailModel.self, from: data)
                        
                        
                        
                        print("response= ",obj)
                        
                        if obj.StatusNo == 0 {
                            
                            self.paymentDtlObj = obj.MasterData

                            if( self.paymentDtlObj?.CustID == "0"){
                                
                                self.alertCustomCall(message: self.paymentDtlObj!.dispmsg)
                                
                            }else{
                                 self.setPaymentDetail(objModel: obj.MasterData)
                            }
                         
                            
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
    
    

    
    func setPaymentDetail(objModel :PaymentDetailMasterData ){
     
        
        
        lblCustomerName.text = objModel.Name + "-" + objModel.CustID
        //lblProductName.text  = objModel.productname
        lblProductName.text  = "Platform for onboarding for PolicyBoss Pro"
        lblAmount.text       = rupee + " " + objModel.displayamounts
    }
    
    
     func moveToSuccessVC(paymentID : String){
        
        //Note : this one when Razorpay give unique payment ID when transaction is done.
        // No need to check paymentID if success is done RazorPay give us unique payment ID .
        guard let CustomerID = paymentDtlObj?.CustID else{
            let snackbar = TTGSnackbar.init(message: "Customer ID Not Found", duration: .middle )
            snackbar.show()
            return
        }
        let paymentSuccessVC : PaymentSuccessVC = self.storyboard?.instantiateViewController(withIdentifier: "stbPaymentSuccessVC") as! PaymentSuccessVC
        paymentSuccessVC.modalPresentationStyle = .fullScreen
        paymentSuccessVC.paymentID = paymentID
        paymentSuccessVC.CustId = CustomerID
        self.addChild(paymentSuccessVC)
        self.view.addSubview(paymentSuccessVC.view)
        
    }
    
   
    
    //--<showalertView>--
    func alertCustomCall(message:String)
    {
       // let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let KYDrawer : KYDrawerController = storyboard.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
//            KYDrawer.modalPresentationStyle = .fullScreen
//            self.present(KYDrawer, animated: true, completion: nil)
            
           self.dismiss(animated: false, completion: nil)
        }
        
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
}


