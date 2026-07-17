//
//  ScannerOverlayView.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 20/03/26.
//

import SwiftUI

struct ScannerOverlayView: View {

    var body: some View {
        GeometryReader { geo in

            let width: CGFloat = 260
            let height: CGFloat = 260

            ZStack {

                // 🔥 Dark transparent background
                Color.black.opacity(0.6)
                    .mask(
                        Rectangle()
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: width, height: height)
                                    .blendMode(.destinationOut)
                            )
                    )

                // White border
                //    //
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.lightWhite, lineWidth: 1)
                    .frame(width: width, height: height)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.compositingGroup()
        }
        .ignoresSafeArea()
    }
}
