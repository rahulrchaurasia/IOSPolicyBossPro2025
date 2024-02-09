//
//  Extension+ UITextField.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 01/04/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation
import UIKit


// refer : https://medium.com/swift2go/swift-add-keyboard-done-button-using-uitoolbar-c2bea50a12c7
//Note : IN UI of Textfield (Storyboard) Done Accessory.to "ON"
extension UITextField{
    
    //In the Attributes Inspector, find the "User Defined Runtime Attributes" section.
   // Add a new row with the key path doneAccessory and type Boolean. Set the value to true.
    
    
    //Mark: Keyboard -> Done Button,this change via Storyboard
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    /////////////////////////////////////////////////
    
   
    //Via Code : Using Property Better apprach
   // Keyboard -> Done Button
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
        
    }
    
    
    
    ///*********** Only For OTP ***********//
    ///
     
    
    func addDoneButtonOnKeyboardOTP(completion: @escaping () -> Void)
    {
        
        let doneToolbar = UIToolbar()
                doneToolbar.barStyle = .default

                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonActionOTP))

                doneToolbar.items = [flexSpace, doneButton]
                doneToolbar.sizeToFit()

                inputAccessoryView = doneToolbar

                // Set action for "Done" button
//                doneButton.target = self
//                doneButton.action = #selector(doneButtonActionOTP)
        
            // Create a copy of the closure
                let copiedCompletion = { [weak self] in
                    if let strongSelf = self {
                        completion() // Execute the original closure
                    }
                }

                // Store the completion closure using associated objects
                objc_setAssociatedObject(self, &AssociatedKeys.doneButtonActionOTP, completion, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }

    @objc private func doneButtonActionOTP() {
            //resignFirstResponder() // Dismiss the keyboard


        
        // Safely retrieve and execute the closure
                if let completion = objc_getAssociatedObject(self, &AssociatedKeys.doneButtonActionOTP) as? () -> Void {
                    completion()
                }
        }
}

private struct AssociatedKeys {
    static var doneButtonActionOTP = "doneButtonActionOTP"
}
