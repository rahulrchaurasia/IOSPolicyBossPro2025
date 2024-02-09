//
//  OTPAlertView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

struct OTPAlertView: View {
    
    @ObservedObject var vm = OTPAlertViewModel()
    
    @StateObject var timerVM = TimerViewModel()

    static let codeDigit = 4
    
    @State var isValidate = true
    

    @State
      var codeDict = Dictionary<Int,String>(uniqueKeysWithValues: (0..<codeDigit).map{($0,"")}
      )
    
    @State var isOTPError = true
    
    var code : String {
        
        codeDict.sorted(by:{$0.key < $01.key}).map(\.value).joined()
        
    }

    var onSelected: ((String) -> Void)

    var body: some View {
        
        
        mainView
        .frame(width: UIScreen.main.bounds.width - 30 , height: 350,alignment: .center)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        
        .overlay(alignment: .topTrailing) {
          
            
            Button {
               
               // vm.dismissAlert()
                timerVM.stopTimer()
                onSelected("0000")
                print("CLose Alert View")
            } label: {
                XDismissButton()
            }
                .background(Color.clear)
                .contentShape(Rectangle())
    
                .padding(.top,4)

        }
        
            
           
        
        
      
    }
        
        
    
    
    
    var formattedTime: String {
        let minutes = Int(timerVM.remainingTime) / 60 % 60
            let seconds = Int(timerVM.remainingTime) % 60
            return String(format: "%02d:%02d", minutes, seconds)
    }
}


private extension OTPAlertView {
    
   
    var mainView: some View  {
        
        VStack() {

           
                Text("Verify Your Account")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                
                   
                contentView // View
            
                Divider()
                    .background(Color.blue.opacity(0.4))
                    .padding([.bottom],20)
                
              
            
            ///
        }
        
        .onAppear{
            
            // Start the timer when the view appears
            timerVM.onSelected = onSelected
        }
    }
    
    //main Container
    var contentView: some View  {
        
        ScrollView {
            
            VStack(alignment: .center, spacing :10)
            {
                
               
                //Mark : View
                
                OTPView

                if !isValidate {
                    
                    Group{
                     
                        Text(vm.errorMessage)
                            .font(.title3)
                            .foregroundStyle(Color.red)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                  

                }
                
                //Mark : View
                displayMssgView
                
                //Mark : Tommer MsgView
                 timmerMssgView
                
                ButtonView
                
            }
            
            .frame(maxWidth: .infinity, alignment: .leading) // Align content to leading
            .padding(.horizontal)
            
        }
    }
}

private extension OTPAlertView {
    
    var displayMssgView : some View {
        Group{
            
            
            Text(vm.dynamicText) // Access dynamic text from view model
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
                .fixedSize(horizontal: false, vertical: true)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
    
        
    }
    var timmerMssgView : some View {
        
        Group{
            Text(formattedTime)
                .font(.title)
                .onAppear {
                    timerVM.startTimer()
                    
                   
                    
//                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//                        remainingTime -= 0.1
//                        if remainingTime <= 0 {
//                            timer.invalidate()
//                            
//                            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                // Perform actions after timer completion (e.g., calling onSelected)
//                                 onSelected("0000") // Or any other action
//                            }
//                        }
//                    }
                }
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .trailing)
    }
}

private extension OTPAlertView {
    
    var ButtonView : some View {
        
        VStack {
            
            HStack(alignment: .center, spacing: 0) { // Center button within its row
                
                Button(action: {
                    
                    isValidate =  vm.validateOTP(strCode: code)
                    isOTPError = isValidate
                    if(isValidate){
                        
                        print("Final Done \(code)")
                    }else{
                        
                        print("Validation ")
                    }
                    
                }, label: {
                    APButton(title: "Submit")
                })
                
            }.padding(.bottom)
                
        
            HStack(alignment: .center, spacing: 0)
            {
           
            Button(action: {
                
              print("Resend Code ....")
                
            }, label: {
                Text("Resend Code")
                    .font(.title2)
                    .underline()
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .tint(Color.blue)
               
            })
           
        }
           
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top,20)
    }
}

private extension OTPAlertView {
    
    var OTPView : some View {
        Group{
        
            OneTimeCodeBoxes(codeDict:$codeDict, isOTPError: $isOTPError,
                             oncommit: {
            

                print("***Final Done \(code)")
                
                Task {
                        // Perform asynchronous operations or other tasks

                        // Access and use the saved state later:
                        DispatchQueue.main.async {
                           let (isVerified, message)  =  vm.validateOTP1(strCode: code)
                            
                               isValidate = isVerified
                               isOTPError = isVerified
                               vm.errorMessage = message
                        }
                    }
               
              
            })
            .onChange(of: codeDict) { newValue in
                
                isOTPError = true
            }
            .padding(.top,20)
            
        }
    }
}

struct OTPAlertView_Previews: PreviewProvider {
    static var previews: some View {

        let vm: OTPAlertViewModel = OTPAlertViewModel()
//        OTPAlertView(vm: vm, onSelected: <#(String) -> Void#>)
        
        OTPAlertView(vm: vm,onSelected: { selectedString in
                    // Handle selectedString as needed in the preview
                    print("Selected string: \(selectedString)")
                })
    }
}
