//
//  View+Extension.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    
    var getWidth: CGFloat {
            UIScreen.main.bounds.width
        }
    
    
    
    
    //added :05otp
    func disableWithOpacity(_ condition : Bool) -> some View {
        
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
        
    }
    
    func underlineTextField() -> some View {
            self
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(Color.gray.opacity(0.5)))
                .foregroundColor(Color.black)
                
                .padding(10)
        }
    
    
    
   //dismiss the keyboard by tapping outside the TextField or on a "Done" button.
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
    
/***********************************************************************/
       // Using  @ViewBuilder
/***********************************************************************/
    @ViewBuilder
   func formattedText(_ text: String, backgroundColor: Color, foregroundColor: Color = .black) -> some View {
           Text(text)
               .font(.largeTitle)
               .frame(width: 250, height: 250)
               .padding()
               .background(backgroundColor)
               .foregroundColor(foregroundColor)
               .cornerRadius(15)
       }

}
