//
//  CustomTextFieldWithEye.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 11/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomTextFieldWithEye: View {
    
    var placeHolder : String
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false
   
   
    @FocusState private var isFocused: Bool

    //var onToggle: (() -> Void)? // Optional closure
    
    var body: some View {
        HStack(spacing : 0) {
            Image(systemName: "lock")
                .frame(width: 4)
                .padding(.leading,12)
            // Spacer for flexibility
                
            Group {
                if isPasswordVisible {
                    TextField(placeHolder, text: $text)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundStyle(.primary)
                        .focused($isFocused)
                    
                }else {
                    SecureField(placeHolder, text: $text)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundStyle(.primary)
                        .focused($isFocused)
                }
            }
            
            .padding()
            
            .disableAutocorrection(true)
            .autocapitalization(.none)
            
          
            
            Button {
                isPasswordVisible.toggle()
                
            } label: {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundStyle(.blue)
                    .background(Color.clear)
                        .contentShape(Rectangle())
                        // Increase the frame size here
                        .frame(width: 50)
                        .frame(maxHeight: .infinity) //
                        //.background(Color.red)
                    
            }
            
            
        }
        .frame(height: 60)
        .padding(.leading,10)
        .cornerRadius(25)
        
        .foregroundColor(.primary)
        .overlay(
          RoundedRectangle(cornerRadius: 25)
            .stroke(lineWidth: 1)
            .foregroundColor(Color.gray.opacity(0.7))
        )
        .font(.system(size: 17))
        .shadow(radius: 10)
        .onAppear(){
            
            isFocused = true
        }
        
    }
    
    private func backgroundColor(mode: ColorScheme) -> some View {
          return mode == .dark ? Color.black : Color.white
      }

      private func foregroundColor(mode: ColorScheme) -> some View {
          return mode == .dark ? Color.white : Color.black
      }

      private func color(mode: ColorScheme) -> some View {
          return mode == .dark ? Color.init(UIColor.systemBackground) : Color.white
      }
}

#Preview {
    CustomTextFieldWithEye(placeHolder: "Enter Password", text: .constant(""))
}
