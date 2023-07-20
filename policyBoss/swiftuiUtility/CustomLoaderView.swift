//
//  CustomLoaderView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 13/06/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import SwiftUI

enum LoadingState {
    case loading, success, fail, none
}

struct CustomLoaderView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if isLoading {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5) // Customize the size of the progress indicator
                    
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.headline) // Customize the font style
                        .padding(.top, 8)
                }
                .padding(16)
                .background(Color.gray.opacity(0.8))
                
                .cornerRadius(8)
                
                .transition(.scale) // Add a transition when the loader appears or disappears
                .onAppear(){
                    withAnimation(.easeInOut) {
                        // Animation duration and timing function
                    }
                }
                
                
                
                
            }
            
        }
    }
}

struct CustomLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoaderView(isLoading: .constant(true))
    }
}
