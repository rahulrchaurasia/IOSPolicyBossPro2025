//
//  OTPAlertDialog.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

struct OTPAlertDialog: View {
    
    
    @ObservedObject var vm = LoginViewModel()
    
    @StateObject var timerVM = TimerViewModel()

   

    //view property
    @State var otpText : String = ""
    
    //keyboard State
    @FocusState private var isKeyBoardShowing : Bool
    
    //for Communication
    //closureType is enum where we can deal with diff case
    var onSelected: ((closureType) -> Void)?
    
    
   // @State var isValidate = true
    
    @State private var isPasswordVisible: Bool = false


    @State var isOTPError = true
    
    @State var isResend = 1
    
    var body: some View {
        ZStack
        {
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
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                
                Button("Done") {
                    
                    isKeyBoardShowing.toggle()
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                
                
            }
            
        }
    }
}



private extension OTPAlertDialog {
    
    
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
                
                

            }
            .onAppear{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isKeyBoardShowing = true
                    
                    timerVM.onSelected = onSelected
                }
                
            }
        
        
        
    }
}


private extension OTPAlertDialog {
    
    var contentView: some View  {
        
        ScrollView {
            
            VStack{
                
                HStack(spacing : 0){
                    // OTP TEXT BOXES
                    
                    ForEach(0..<4 , id: \.self){ index in
                        
                        OTPTextBox(index )
                    }
                    
                    
                }
                .padding(.top,20)
                .padding(.horizontal,50)
                .background(
                    
                    
                    TextField("",text: $otpText.limit(4))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                       //Hide it Out
                        .frame(width: 1,height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                        .focused($isKeyBoardShowing)
                        
                        .onChange(of: otpText) { newValue in
                            
                            //Clear the Error Message
                            vm.errorMessage = ""
                            if newValue.count == 4 {
                                                  
                                isOTPError =  vm.validateOTP(strCode: otpText)
                                if(vm.isValid){
                                    
                                    print("Final Done \(otpText)")
                                    
                                    callVerifyOTPApi()
                                   
                                }
                                                  
                            }
                        }
                        
                    
                    
                )
                .contentShape(Rectangle())
                
                .onTapGesture {
                    isKeyBoardShowing.toggle()
                }
                
                
                .padding(.bottom,20)
                .padding(.top,10)
                
                //TextField("",text: $otpText)
  
                
                if !vm.isValid {
                    
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

    var formattedTime: String {
        let minutes = Int(timerVM.remainingTime) / 60 % 60
            let seconds = Int(timerVM.remainingTime) % 60
            return String(format: "%02d:%02d", minutes, seconds)
    }
}

private extension OTPAlertDialog {
    
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

private extension OTPAlertDialog {
    
    var ButtonView : some View {
        
        VStack {
            
            HStack(alignment: .center, spacing: 0) { // Center button within its row
                
                Button(action: {
                    
                  
                    isOTPError =  vm.validateOTP(strCode: otpText)
                    if(vm.isValid){
                        
                        print("Final Done \(otpText)")
                        
                        callVerifyOTPApi()
                       
                    }else{
                        
                        print("Validation ")
                    }
                    
                }, label: {
                    APButton(title: "Submit")
                })
                .disabled(vm.isLoading)
                .disableWithOpacity(otpText.count < 4)
                
            }.padding(.bottom)
                
        
            HStack(alignment: .center, spacing: 0)
            {
           
            Button(action: {
               
                
                clearOTP()
                timerVM.resendTimer() // reset Timmer
                vm.isLoading = true
                vm.errorMessage = ""
                isOTPError = true
               // clearOTP()
                // Delay action using DispatchQueue with `asyncAfter`
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                    print("Resend Code after 2 seconds...")
                    
                    resetOTP() // set again for Allowing Otp
                    print("Resend Code ....")
                    
                      Task {
                          do  {
                              
                              let result = try await  vm.resendOTP(mobileNumber: OTPDataViewModel.shareInstance.getOtpMobileNo())
                             
                              if(result.lowercased() == "success"){
                                  vm.isLoading = false
                                  
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
                
                let result = try await  vm.verifyOTP(otp: otpText, mobileNumber: OTPDataViewModel.shareInstance.getOtpMobileNo())
                
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
    
    func clearOTP(){

        otpText = ""
        isResend = 0
    }
    func resetOTP(){

        otpText = ""
        isResend = 1
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
       // isValidate = false
        vm.errorMessage = "Invalid OTP"
        isOTPError = false
        
    }

    func handleAPIError(_ error: Error) {
        
        vm.isLoading = false
        print("API call failed:",String(describing: error))
        vm.isValid = false
        //isValidate = false
        vm.errorMessage = Constant.serverMessage
    }
}

private extension OTPAlertDialog {
    
    @ViewBuilder
    func OTPTextBox(_ index : Int) -> some View{
        
        ZStack {
            
            if(isResend > 0){
                if otpText.count > index    {
                    //Finding char At index
                    
                    let startIndex = otpText.startIndex
                    let charIndex = otpText.index(startIndex, offsetBy: index)
                    
                    let charToString = String(otpText[charIndex])
                    Text(charToString)
                    
                   
                }else{
                    Text("")
                }
            }else{
                Text("")
            }
            
        }
        .frame(width: 50 ,height: 50)
        .background{
            //Highlight current active box
            let status = (isKeyBoardShowing && otpText.count == index)
            
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? Color.accentColor : .gray,
                 lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: status)

        }
        .frame(maxWidth: .infinity,alignment: .center)
    }
}

#Preview {
    OTPAlertDialog()
}
