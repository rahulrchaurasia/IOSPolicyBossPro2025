//
//  PaymentCancelController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 10/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class PaymentCancelController: UIViewController {
    
    
    var custID = ""
    
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var lblCustomerID: UILabel!
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    
        setData()
      
    }
    
    
    func initialize()
    {
        
    
        cardView.backgroundColor = .white

        cardView.layer.cornerRadius = 10.0

        cardView.layer.shadowColor = UIColor.gray.cgColor

        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        cardView.layer.shadowRadius = 6.0

        cardView.layer.shadowOpacity = 0.7

    }
    
    func setData(){
        
        lblCustomerID.text = custID
    }
    
    
    
//    @IBAction func btnBackToPospClick(_ sender: Any) {
//
//        print ("posp clicled")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let enrolasPOSPVC : enrolasPOSPVC = storyboard.instantiateViewController(withIdentifier: "stbenrolasPOSPVC") as! enrolasPOSPVC
//
//        present(enrolasPOSPVC, animated: true, completion: nil)
//
//    }
    

    @IBAction func btnBackPospClick(_ sender: Any) {
        
       getToPospPage()
      
     
    }
    
    @IBAction func backBtnCliked(_ sender: Any) {
        
       
       getToPospPage()
    }
    
    func getToPospPage(){
           

         self.dismiss(animated: false, completion: nil)

       }
}
