//
//  TestFile.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 09/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

struct TestFile: View {
    
    @State var phoneNumber = "9909808000"
    @State var errorMessage = "Enter Data"
    @State var testData : String = "Enter Data"
    @State var isSendingOTP = false
    var body: some View {
        VStack(spacing: 20) {
            Image("PolicyBoss_Pro_logo") // Replace with your image asset name
                .resizable()
                .frame(width: 150, height: 150)
            
            Text("Login Via Password")
                .font(.title)
                .fontWeight(.bold)
            
            CustomTextFieldWithEye(placeHolder: "Enter password", text: $testData)
               
                 .padding(.trailing, 10)
            
//            TextField("Enter Password", text: $phoneNumber)
//                .keyboardType(.numberPad)
//                .disabled(false)
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(5)
//                .padding()
//                .overlay(
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding()
//                        .opacity(errorMessage.isEmpty ? 0 : 1)
//                )
            
            Button(isSendingOTP ? "Sending..." : "SUBMIT") {
                //                    Task {
                //                        //await viewModel.loginWithOTP()
                //                    }
            }
            .disabled(isSendingOTP)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(5)
            
            Text("Not registered? Raise Ticket")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .onAppear {
            // Additional setup if needed
        }
    }
}



   
struct TestFil_Previews: PreviewProvider {
        static var previews: some View {

//            let vm: OTPAlertViewModel = OTPAlertViewModel()
//             PasswordAlertView(vm: vm)
            TestFile()
           
        }
}
