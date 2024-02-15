//
//  PasswordAlertVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 11/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import UIKit
import SwiftUI

class PasswordAlertVC: UIViewController {

    
    @IBOutlet weak var childView: UIView!
    
    var completionHandler: ((closureType) -> Void)?
    
    var alertUserID = String()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        addSwiftUIView()
    }
    

    
//    lazy var passwordAlerView : PasswordAlertView = {
//        
//        let passwordView = PasswordAlertView { [weak self] in
//            
//            // self.label =....
//            self?.view.endEditing(true)
//            self?.completionHandler?()
//            self?.dismiss(animated: true)
//            
//        }
//        
//        return passwordView
//    }()
    
    // HereUsing alertUserID : Passing data to PasswordAlertView
    // and pass closure to handle Submit Event
    lazy var passwordAlerView : PasswordAlertView = {
        
        //Note : closureData is variable of closureType
        let passwordView = PasswordAlertView( alertUserID: alertUserID)
        { [weak self] closureData in
            
            // self.label =....
            
            self?.view.endEditing(true)
            self?.completionHandler?(closureData)
            self?.dismiss(animated: true)
            
        }
        
        return passwordView
    }()
    
   

    func addSwiftUIView() {
        
//        let swiftUIView =  LoginView(onSelected: { selectedString in
//                    // Handle selectedString as needed in the preview
//                    print("Selected string: \(selectedString)")
//                })
        let hostingController = UIHostingController(rootView: passwordAlerView)

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
