//
//  PasswordAlertView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 09/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

//closureType is enum for run type handling
struct PasswordAlertView: View {
    
    @ObservedObject var vm = LoginViewModel()
    @State var isValidate = true
    let alertUserID: String
   // var onSelected: (() -> Void)? // Optional
    var onSelected: ((closureType) -> Void)?
    
    var body: some View {
        
        ZStack {
           
            mainView
            .frame(width: UIScreen.main.bounds.width - 30 ,alignment: .center)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 40)
            .padding(.bottom,-10)
            .overlay(alignment: .topTrailing) {
                
                
                Button {
                    
                    onSelected?(.close)
                } label: {
                    XDismissButton()
                }
                
                .background(Color.clear)
                .contentShape(Rectangle())
                
                .padding(.top,4)
                
            }
            
            //For Loader
            if vm.isLoading {

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        
        
            
           
        
        
      
    }
}

private extension PasswordAlertView {
    
   
    var mainView: some View  {
        
        VStack() {

           
                Text("Login Via Password")
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
          
        }
    }
    
    //main Container
    var contentView: some View  {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing :10)
            {
                
                Group{
                    
                    Text("Enter Password")
                        .font(.title3)

                        .padding(.top,15)
                    //Mark : View

                   
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //Mark : View
              
                CustomTextFieldWithEye(placeHolder: "Enter password", text: $vm.password)
                    .disabled(vm.isLoading)
                   
                     .padding(.trailing, 10)
                     .padding(.top,10)
                
               
                    Group{
                     
                        Text(vm.errorMessage)
                            .font(.title3)
                            .foregroundStyle(Color.red)
                            .opacity(vm.errorMessage.isEmpty ? 0 : 1)
                        
                    }
                   
                
                
                ButtonView
                
            }
            
            .frame(maxWidth: .infinity,maxHeight:450, alignment: .leading) // Align content to leading
            
            .padding(.horizontal)
            
        }
    }
}



private extension PasswordAlertView {
    
    var ButtonView : some View {
        
        VStack {
            
            HStack(alignment: .center, spacing: 0) { // Center button within its row
                
                Button(action: {
                    
                    // isValidate =  vm.validateOTP(strCode: code)
                    
                    if vm.validatePasswordForm() {
                        // Submit form data
                        print("Form submitted successfully!")
                        Task {
                            do  {
                                vm.isLoading = true
                                let result = try await  vm.getAuthLoginHorizon(username: alertUserID, password: vm.password)
                                
                                switch result {
                                case .success(let response):
                                    
                                    vm.isLoading = false
                                    print("Auth Response Done",response)
                                    // Update UI based on received data
                                    onSelected?(.success)
                                case .failure(let error):
                                    vm.isLoading = false
                                    print("API call failed:", error.localizedDescription)
                                    
                                }
                                
                                
                                
                                
                            } catch {
                                print("API call failed:",String(describing: error))
                              
                                vm.errorMessage = error.localizedDescription
                            }
                        }
                        
                        //onSelected?()
                    } 
                    else {
                        print("Password Validation......")
                    }
                    
                    
                }, label: {
                    APButton(title: "Submit")
                })
                .disabled(vm.isLoading)
                
            }.padding(.bottom)
                
           
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top,20)
    }
}


//#Preview {
//    PasswordAlertView()
//}
struct PasswordAlertView_Previews: PreviewProvider {
    static var previews: some View {

        let vm: LoginViewModel = LoginViewModel()
        PasswordAlertView(vm: vm, alertUserID: "userID")
        
       
    }
}
