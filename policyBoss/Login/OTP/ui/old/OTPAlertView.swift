//
//  OTPAlertView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

struct OTPAlertView: View {
    
    @ObservedObject var vm = LoginViewModel()
    
    @StateObject var timerVM = TimerViewModel()

    static let codeDigit = 4
    
    @State var isValidate = true
    
    @State private var isPasswordVisible: Bool = false

    @State var firstResponderIndex = 0
    @State
      var codeDict = Dictionary<Int,String>(uniqueKeysWithValues: (0..<codeDigit).map{($0,"")}
      )
    
    @State var isOTPError = true
    
    var code : String {
        
        codeDict.sorted(by:{$0.key < $01.key}).map(\.value).joined()
        
    }

    //closureType is enum where we can deal with diff case
    var onSelected: ((closureType) -> Void)?

    var body: some View {
        
        ZStack {
            
           
            mainView
            
                .frame(width: UIScreen.main.bounds.width - 30 , alignment: .center)
            
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 40)
                .padding(.bottom,-10)
                .overlay(alignment: .topTrailing) {
                    
                    
                    Button {
                        
                        // vm.dismissAlert()
                        timerVM.stopTimer()
                        onSelected?(.close)
                        print("CLose Alert View")
                    } label: {
                        XDismissButton()
                    }
                    .background(Color.clear)
                    .contentShape(Rectangle())
                    
                    .padding(.top,4)
                    
                }
            // Background blur effect
           
                //.ignoresSafeArea()
                //.blur(radius: vm.isLoading ? 20 : 0)
            
            if vm.isLoading {

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
            
            
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        // Ensure the ZStack takes the entire screen

       
        
        
      
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
                OTPDataViewModel.shareInstance.resettempDictandIndex()
                OTPDataViewModel.shareInstance.resetIsKeyBoard()
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
            
            .frame(maxWidth: .infinity,maxHeight:400, alignment: .leading) // Align content to leading
            
            .padding(.horizontal)
            
        }
    }
}

private extension OTPAlertView {
    
    var displayMssgView : some View {
        Group{
            
            
            Text(vm.getMobOTPMessage()) // Access dynamic text from view model
                .font(.title3)
                .multilineTextAlignment(.leading)
            
                .fixedSize(horizontal: false, vertical: true)
            
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
    
        
    }
    var timmerMssgView : some View {
        
        Group{
            Text(formattedTime)
                .font(.title)
                .foregroundStyle(.blue)
                .onAppear {
                    timerVM.startTimer()
                    
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
                        
                        callVerifyOTPApi()
                       
                    }else{
                        
                        print("Validation ")
                    }
                    
                }, label: {
                    APButton(title: "Submit")
                })
                .disabled(vm.isLoading)
                
            }.padding(.bottom)
                
        
            HStack(alignment: .center, spacing: 0)
            {
           
            Button(action: {
               
                timerVM.resendTimer() // reset Timmer
                vm.isLoading = true
                vm.errorMessage = ""
                isOTPError = true
                clearOTP()
                // Delay action using DispatchQueue with `asyncAfter`
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    print("Resend Code after 2 seconds...")
                    
                    print("Resend Code ....")
                    
                      Task {
                          do  {
                              
                              let result = try await  vm.resendOTP(mobileNumber: OTPDataViewModel.shareInstance.getOtpMobileNo())
                             
                              if(result.lowercased() == "success"){
                                  vm.isLoading = false
                                  OTPDataViewModel.shareInstance.blnIsKeyBoardOTP = false
                                  OTPDataViewModel.shareInstance.resettempDictandIndex()
                                  print("resend OTP success",result)
                              }else{
                                  vm.isLoading = false
                                  print("resend OTP Fail",result)
                              }
                                
                              
                          } catch {
                              vm.isLoading = false
                              print("Error resend OTP Fail")
                          }
                      }
                }

             
                
            }, label: {
                Text("Resend OTP")
                    .font(.title2)
                    .underline()
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .tint(Color.blue)
               
            })
            .disabled(!timerVM.isResendButtonVisible)
           
        }
           
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top,20)
    }
    
    func callVerifyOTPApi() {
       
        Task{
            do  {
                
                let result = try await  vm.verifyOTP(otp: code, mobileNumber: OTPDataViewModel.shareInstance.getOtpMobileNo())
                
                if(result.lowercased() == "success"){
                    handleSuccess()
                }else{
                    handleFailure()
                    
                }
                
                
            } catch {
                
                handleAPIError(error)
            }
        }
        
    }
    
    func handleSuccess() {
        vm.isLoading = false
        vm.isValid = true
        vm.errorMessage = ""
        print("Verify OTP API  Done")
        onSelected?(.success)
    }

    func handleFailure() {
        vm.isLoading = false
        vm.isValid = false
        isValidate = false
        vm.errorMessage = "Invalid OTP"
        isOTPError = false
        
    }

    func handleAPIError(_ error: Error) {
        
        vm.isLoading = false
        print("API call failed:",String(describing: error))
        vm.isValid = false
        isValidate = false
        vm.errorMessage = Constant.serverMessage
    }
}

private extension OTPAlertView {
    
    var OTPView : some View {
        Group{
        
            OneTimeCodeBoxes(codeDict:$codeDict, isOTPError: $isOTPError, firstResponderIndex: $firstResponderIndex,
               oncommit: {
              
                // Not trigger bec we use onchange, hence here logic written below onchange event
              
            })
            .disabled(vm.isLoading)
            .onChange(of: codeDict) { newValue in
                
                debugPrint("***OTP Value \(newValue.values)")
                isOTPError = true
                isValidate = true
                
                if( newValue.values.filter({!$0.isEmpty}).count == codeDict.count){
                    
                    debugPrint("***Final Done \(code)")
                    let (isVerified, message)  =  vm.validateOTP1(strCode: code)
                     
                        isValidate = isVerified
                        isOTPError = isVerified
                        vm.errorMessage = message
                     
                    
                         if(isVerified){
                             
                             callVerifyOTPApi()
                         }
                }
                
              
                
            }
            .padding(.top,20)
            
        }
    }
    
    func clearOTP(){
        
        // Clear all text fields
        for (i, _) in codeDict.enumerated() {
            codeDict[i] = ""
        }
        firstResponderIndex = 0 // Set focus to first field
    }
}

struct OTPAlertView_Previews: PreviewProvider {
    static var previews: some View {

        let vm: LoginViewModel = LoginViewModel()
//        OTPAlertView(vm: vm, onSelected: <#(String) -> Void#>)
        
        OTPAlertView(vm: vm,onSelected: { selectedString in
                    // Handle selectedString as needed in the preview
                    print("Selected string: \(selectedString)")
                })
    }
}
