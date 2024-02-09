//
//  LoginNewVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 29/01/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import UIKit
import SwiftUI

// not in used...
class LoginNewVC: UIViewController,UITextFieldDelegate {

   // @State var isLoginSuccessful = true
    @State private var isOTPAlertPresented = false
    let loginvm = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        addSwiftUIView()
    }
    

    
    
    func addSwiftUIView() {
//        let swiftUIView = LoginView(loginvm: loginvm)
//        let hostingController = UIHostingController(rootView: swiftUIView)
//
//        /// Add as a child of the current view controller.
//        addChild(hostingController)
//
//        /// Add the SwiftUI view to the view controller view hierarchy.
//        view.addSubview(hostingController.view)
//
//        /// Setup the constraints to update the SwiftUI view boundaries.
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        let constraints = [
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
//            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
//            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//
//        /// Notify the hosting controller that it has been moved to the current view controller.
//        hostingController.didMove(toParent: self)
    }

}


