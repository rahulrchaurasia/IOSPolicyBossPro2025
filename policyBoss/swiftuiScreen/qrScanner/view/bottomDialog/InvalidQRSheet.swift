//
//  InvalidQRSheet.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 20/03/26.
//

import SwiftUI

struct InvalidQRSheet: View {
    
    var onRetry: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
            
            Text("Invalid QR code")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("The QR code you're trying to scan is incorrect. Please retry with a different code.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: onRetry) {
                Text("Retry")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        
    }
}

#Preview {
    InvalidQRSheet(onRetry: {})
}
