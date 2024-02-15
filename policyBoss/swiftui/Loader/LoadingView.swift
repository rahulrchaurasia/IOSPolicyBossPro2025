//
//  LoadingView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 15/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
