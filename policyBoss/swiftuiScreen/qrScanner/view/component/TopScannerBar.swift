//
//  TopScannerBar.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 24/03/26.
//

import SwiftUI

struct TopScannerBar: View {
    var onClose: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

                    HStack {
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Text("Instant login to PolicyBossPro")
                            .font(.headline)
                            .foregroundColor(.white)

                        Spacer()
                    }

                    Text("Scan the QR code to log into PolicyBossPro.com")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
              
    }
}

#Preview {
    TopScannerBar(onClose: {})
}
