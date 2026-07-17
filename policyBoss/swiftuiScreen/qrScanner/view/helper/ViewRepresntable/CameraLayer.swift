//
//  CameraLayer.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 24/03/26.
//

import SwiftUI


struct CameraLayer: View {

    @Binding var isPaused: Bool
    var scanRegion: CGRect
    var onScan: (String) -> Void

    var body: some View {
        ScannerViewRepresentable(
            isPaused: $isPaused,
            scanRegion: scanRegion,
            onScan: onScan
        )
        .ignoresSafeArea()
    }
}
