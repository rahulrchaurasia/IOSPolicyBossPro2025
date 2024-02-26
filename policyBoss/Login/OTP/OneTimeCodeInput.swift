//
//  OneTimeCodeInput.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 31/01/24.
//

import Foundation
import UIKit
import SwiftUI
 
struct OneTimeCodeInput : UIViewRepresentable {
    
    
    
    typealias UIViewType = UITextField
    
    
    let index : Int
    @Binding var codeDict :[Int : String]
    @Binding var firstResponderIndex : Int
    @Binding var shouldBecomeFirstResponder: Bool

//    var tempIndex : Int
//    var tempCodeDict  :[Int : String]
//    
   
    var oncommit : (() -> Void)?
    
    
    // Variable to track the next available index

    
    // MARK : Internal Type
    class Coordinator: NSObject, UITextFieldDelegate {
        
        let index : Int
        @Binding var codeDict :[Int : String]
        @Binding var firstResponderIndex : Int
        @Binding var shouldBecomeFirstResponder : Bool
        
        //for temp Data
//        var tempCodeDict :[Int : String] = [:]
//        var tempIndex : Int = 0
       // var blnIsKeyBoardOTP = false
        var parent: OneTimeCodeInput?
                
        init(index: Int, codeDict: Binding<[Int:String]>,firstResponderIndex : Binding<Int>,shouldBecomeFirstResponder : Binding<Bool>
        ) {
            self.index = index
            self._codeDict = codeDict
            self._firstResponderIndex = firstResponderIndex
            self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
            

           
        }
        
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//                parent?.shouldBecomeFirstResponder = true
//           
//            }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent?.shouldBecomeFirstResponder = true
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
                    
                    if textView.text.count >= 1 {
                        // Move to the next text field
                        
                        debugPrint("OTP COUNT \(textView.text)")
                    }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            

//            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
//             // return newText.count <= 10 // Allow up to 10 characters
//
//            
//            debugPrint("OTP COUNT \(newText)")

            
            //Mark: Deleting, Set Empty Value Related to dictionary and put back one step prev
            if string.isBackspace {
                
                
                
                DispatchQueue.main.async {
                    self.codeDict.updateValue("", forKey: self.index)
                    self.firstResponderIndex = max(0, self.index - 1)
                }
                
                return false
            }
            
         
            //typing
            //pasting
            
            for i in index..<min(codeDict.count, index + string.count){
              
                DispatchQueue.main.async {
                    self.codeDict.updateValue(string.stringAt(index: i - self.index), forKey: i)
                    self.firstResponderIndex = min(self.codeDict.count - 1, self.index + string.count)
                    
                    debugPrint("Update Value Min at \(self.firstResponderIndex)")
     
                }

            }
            
            //Mark commented : For Auto Fill
//           for i in index..<min(codeDict.count, index + string.count){
//              
//                saveDigit(string)
//               
//                if(keyBoardOTPVerify()){
//                    
//                    OTPDataViewModel.shareInstance.resettempDictandIndex()
//                    OTPDataViewModel.shareInstance.blnIsKeyBoardOTP = true
//                  
//                    //OTPDataViewModel.shareInstance.blnIsKeyBoardOTP = true
//
//                }else{
//                    
//                    DispatchQueue.main.async {
//                        self.codeDict.updateValue(string.stringAt(index: i - self.index), forKey: i)
//                        self.firstResponderIndex = min(self.codeDict.count - 1, self.index + string.count)
//                        
//                        debugPrint("Update Value Min at \(self.firstResponderIndex)")
//         
//                    }
//                   
//                }
//
//            }
           
            
            
            return false
        }
        
      

        
        func saveDigit(_ digit: String) {
            guard  OTPDataViewModel.shareInstance.gettempIndex() < 4 ,self.firstResponderIndex == 0 , OTPDataViewModel.shareInstance.blnIsKeyBoardOTP == false else {
                // Handle case where maximum digits are reached
                return
            }

           
            OTPDataViewModel.shareInstance.settempDict( data: digit)
            
        
        }
      
        func keyBoardOTPVerify() ->Bool {
            
            if (OTPDataViewModel.shareInstance.blnIsKeyBoardOTP){
                
                return false
            }
            guard OTPDataViewModel.shareInstance.gettempIndex() == 4,  self.firstResponderIndex == 0 ,
                  OTPDataViewModel.shareInstance.blnIsKeyBoardOTP == false
            else {return false }
            
            // Check if all Field have values from keyboard OTP:
            
            if OTPDataViewModel.shareInstance.gettempDict().values.allSatisfy({$0 != ""}){
                
                print("Complete OTP entered: \(OTPDataViewModel.shareInstance.gettempDict())")
                //assign whole tempDic to our main codeDic when tempDic has full dict value has data
                let tempDict = OTPDataViewModel.shareInstance.gettempDict()
               
                for i in 0..<tempDict.count {
                    
                    if let value = tempDict[i] {
                        DispatchQueue.main.async {
                            self.codeDict[i] = value
                            
                        }
                     
                    }
                }

                return true
            }
            
            return false
        }
        
    }
    
    class BackspaceTextField : UITextField {
        
        var onDelete: (()-> Void)?
        
        
        init(onDelete: ( () -> Void)? = nil) {
            self.onDelete = onDelete
            
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func deleteBackward() {
           
            super.deleteBackward()
            
            onDelete?()
        }
        
        //Mark : Default remove paste option //
//        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//                       return false
//                   }
//            return super.canPerformAction(action, withSender: sender)
//        }

        
        
    }
    
   
    func makeCoordinator() -> Coordinator {
//        .init(index: index, codeDict: $codeDict, firstResponderIndex: $firstResponderIndex)
        
        let coordinator = Coordinator(index: index, codeDict: $codeDict, firstResponderIndex: $firstResponderIndex, shouldBecomeFirstResponder: $shouldBecomeFirstResponder

        )
               coordinator.parent = self // Assigning the coordinator to the parent
               return coordinator
    }
    
    func makeUIView(context: Context) -> UITextField {
        
      
        let tf = BackspaceTextField {
            firstResponderIndex = max(0, index - 1)
        }
        //.numberPad
        tf.delegate = context.coordinator
        tf.keyboardType = .asciiCapableNumberPad
        tf.textContentType = .none   // For Auto Detect Data
        tf.font = .preferredFont(forTextStyle: .largeTitle)
        tf.textAlignment = .center
        
    
        tf.addDoneButtonOnKeyboardOTP {

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                tf.resignFirstResponder() // Dismiss the keyboard
                shouldBecomeFirstResponder = false
                
                // parent?.oncommit?()
            }
        }
        
       
        return tf
    }
    
        
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = codeDict[index]
        
        if index == firstResponderIndex {
           // uiView.becomeFirstResponder()
            if shouldBecomeFirstResponder {
                uiView.becomeFirstResponder()
            }
            
        }
        
        
//Note : here our index when reach the last index of OTP
//bec we set logic firstResponderIndex = min(codeDict.count - 1, index + string.count)
// mean firstResponderIndex at the end set last codeDict
        if index == firstResponderIndex, codeDict.values.filter({!$0.isEmpty}).count == codeDict.count {
            
            //print("Done \(firstResponderIndex)")
            
    //Note: ******************************************************
     //not trigger bec we used onChange and this is handle inside onChange*********
            oncommit?()
            
     // *********************************************
            
        }
        
    }
    
    
  
    //Note: For Error Handling Trigger :-
    // Use onChange to handle changes to codeDict
        func onChange(_ onChange: @escaping () -> Void) -> Self {
            
            
            var view = self
            view.oncommit = onChange
            return view
        }
    
   
}
