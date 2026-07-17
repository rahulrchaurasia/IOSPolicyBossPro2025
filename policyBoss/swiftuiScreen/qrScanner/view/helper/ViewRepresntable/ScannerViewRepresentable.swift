//
//  ScannerViewRepresentable.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 19/03/26.
//

import SwiftUI


import SwiftUI

//mark : UIViewControllerRepresentable As bridge
struct ScannerViewRepresentable: UIViewControllerRepresentable {

    @Binding var isPaused: Bool
    var scanRegion: CGRect
    var onScan: (String) -> Void

    func makeUIViewController(context: Context) -> QRScannerViewController {

        let vc = QRScannerViewController()
        vc.onDetected = onScan   // ✅ FIXED
        vc.scanRegion = scanRegion
        return vc
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController,
                                context: Context) {

        // ✅ Update ROI only if changed
            if uiViewController.scanRegion != scanRegion {
                uiViewController.scanRegion = scanRegion
            }
        
       // uiViewController.scanRegion = scanRegion
        // ✅ Prevent unnecessary pause/resume calls
        if isPaused {
            uiViewController.pauseScanning()
        } else {
            uiViewController.resumeScanning()
        }
    }
}
