//
//  XDismissButton.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation
import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .opacity(0.6)
            
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 54, height: 54)
                .foregroundColor(.black)
                
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}
