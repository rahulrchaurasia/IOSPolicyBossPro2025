//
//  OTPAlertVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 06/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import UIKit
import SwiftUI

class OTPAlertVC: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var childView: UIView!
    //    @State var isOTPAlertPresented = true
   
   
    var completionHandler: ((closureType) -> Void)?
    
   
    var alertTitle = String()
     
    var  pospAmntData =   String()
   var  pospAmntList =  [String]()
     
    var alertSubTitle = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        addSwiftUIView()
    }
    

//    lazy var loginView : LoginView = {
//        
//        let otpView = LoginView {[weak self] otpData in
//            
//            print("OTP Data : \(otpData)")
//           // self.label =....
//            self?.dismiss(animated: true)
//           
//        }
//        
//        return otpView
//    }()
    
    lazy var otpAlerView : OTPAlertView = {
        
        let otpView = OTPAlertView {[weak self] otpData in
            
            print("OTP Data : \(otpData)")
           // self.label =....
           // self?.view.endEditing(true)
            self?.completionHandler?(otpData)
            self?.dismiss(animated: true)
            
          
        }
        
        return otpView
    }()
    
    
    func addSwiftUIView() {
        
//        let swiftUIView =  LoginView(onSelected: { selectedString in
//                    // Handle selectedString as needed in the preview
//                    print("Selected string: \(selectedString)")
//                })
        let hostingController = UIHostingController(rootView: otpAlerView)

        /// Add as a child of the current view controller.
        addChild(hostingController)

        /// Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding in main view
//        let constraints = [
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
//            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
//            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
//        ]

        // only Child view size access....
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: childView.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: childView.leftAnchor),
            childView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            childView.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        /// Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }



}
