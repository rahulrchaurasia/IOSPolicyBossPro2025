//
//  ScannerScreen.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 19/03/26.
//

/*
 ✅ What This Fix Achieves
 Correct callback
 QRScannerViewController
         ↓
 onDetected
         ↓
 ScannerViewRepresentable
         ↓
 SwiftUI handleScan()
 Prevent multiple scans
 isProcessing
 isPaused

 Both protect the scanner.

 SwiftUI controls hardware
 SwiftUI isPaused
         ↓
 updateUIViewController
         ↓
 pauseScanning()
 resumeScanning()
 */

///
/*
 
 🧠 THE REAL CONTROL = isPaused

 You already built the correct architecture 👏

 🔁 Flow:
 Camera → QR detected → handleScan()
                         ↓
                    isPaused = true
                         ↓
             Scanner stops sending results
 ✅ WHERE SCANNING ACTUALLY STOPS
 1. SwiftUI layer (your guard)
 guard !isPaused else { return }

 👉 Even if camera sends frames → ignored

 2. UIKit layer (IMPORTANT — your Android equivalent)

 Inside your QRScannerViewController:

 if isProcessing || isPaused { return }

 👉 This is the real hardware-level stop

 3. SwiftUI → UIKit bridge

 From your ScannerViewRepresentable (this is key):

 func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {
     if isPaused {
         uiViewController.pauseScanning()
     } else {
         uiViewController.resumeScanning()
     }
 }

 👉 This connects:

 SwiftUI state (isPaused)
         ↓
 UIKit camera control
 🔥 WHAT HAPPENS WHEN DIALOG OPENS

 When scan happens:

 isPaused = true
 activeResult = ScanResult(...)
 */
///
///
/*
 ScannerScreen
  ├ CameraLayer
  │     └ ScannerViewRepresentable
  ├ Overlay
  ├ Toolbar
  └ Logic
 */


/*
 Scanner Flow :--
 
     GRAPHICAL FLOW
     UI FLOW

     Camera
       ↓
     QR detected
       ↓
     handleScan()
       ↓
     activeResult updated
       ↓
     .sheet(item:) triggered
       ↓
     Confirm Sheet opens


 API FLOW :----->

     User taps Confirm
       ↓
     ViewModel API
       ↓
     scannerState changes
       ↓
     .onChange triggered
       ↓
     Success/Error handled


 */

/*
 CURRENT HIERARCHY
 MainVC
  └── UIHostingController
       └── ScannerScreen
            └── .sheet(ConfirmLoginSheet)

 So success should happen in THIS ORDER:

 1. Close ConfirmLoginSheet
 2. Close ScannerScreen
 3. Return to MainVC
 4. Show snackbar
 */


// Why not OnChange event used
/*
 Your Case Specifically

 You had:

 sheet
  ↓
 async API
  ↓
 state change
  ↓
 dismiss another screen
  ↓
 UIKit snackbar

 Too many async UI layers.

 That is why .onChange became unstable.
 */

import SwiftUI


struct ScanResult: Identifiable,Equatable {
    
    let id = UUID()
    let rawCode: String
    let token: String

       let ipAddress: String
       let deviceInfo: String
       let isSuccess: Bool
}


struct ScannerScreen: View {
    
 

    @State private var isPaused = false
    @State private var activeResult: ScanResult?
    @State private var scanRegion: CGRect = .zero   // ✅ ADD
    
    
    // ✅ Prevent duplicate success/error handling
       @State private var hasHandledResult = false
    
    @ObservedObject var viewModel: HomeViewModel

  
    var onResult: (String) -> Void   // 👈 ADD THIS
    var onClose: () -> Void
    
    @Environment(\.dismiss) private var dismiss
  //  @EnvironmentObject var coordinator : AppCoordinator
    
  
    var body: some View {

        ZStack {

            // 1️⃣ Camera
            CameraLayer(
                isPaused: $isPaused,
                scanRegion: scanRegion,
                onScan: handleScan
            )

            // 2️⃣ Overlay
            ScannerOverlayView()

            // 3️⃣ Toolbar
            VStack {
                TopScannerBar {
                  //  dismiss()
                    onClose()
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets + 8)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    calculateScanRegion(screenSize: geo.size)
                }
            }
        )

      //Means : Sheet is controlled by: activeResult != nil
      //  This sheet is NOT system-controlled, it is state-controlled
      //  Sheet visibility = activeResult != nil
        .sheet(item: $activeResult, content: { result in
            Group {
                if result.isSuccess {
                    
                    ConfirmLoginSheet(
                        result: result,
                        viewModel : viewModel,  // 👈 PASS LOADER,
                        onConfirm: {
                            
                            guard let result = activeResult
                            else { return   }
                            
                            Task {
                                
                               // await viewModel.qrVerifiedScanner(token: result.token)
                                await handleConfirmButtonTapped(
                                          token: result.token )
                            }
                            
                        },
                        onCancel: {
                            closeSheetAndResume()
                        }
                    )
                    
                } else {
                    
                    InvalidQRSheet {
                        closeSheetAndResume()
                    }
                }
            }
            .presentationDetents([.fraction(0.5)])   // ✅ HERE
            .interactiveDismissDisabled( viewModel.scannerState != .idle)
           // .presentationBackground(.clear) // 🔥🔥🔥 ADD THIS
            
            //for  sheet.presentationDetents([.fraction(0.5)]) available in ios 16
              .applySheetConfig()   // ✅ clean approach

        })
        
      
      
    }
    
   
}

private extension ScannerScreen {

   
    func handleConfirmButtonTapped(
        token: String
    ) async {
        
        guard !hasHandledResult else {
            return
        }
        
        hasHandledResult = true
        
        let result = await viewModel
            .qrVerifiedScanner(
                token: token
            )
        
        switch result {
            
        case .success(let message):
            
            activeResult = nil
            
            try? await Task.sleep(
                for: .milliseconds(400)
            )
            
            onClose()
            
            // wait for dismiss animation
               try? await Task.sleep(
                   for: .milliseconds(350)
               )
            onResult(message)
            
            resetHandling()
            
        case .error(let error):
            
            // close only bottom sheet
                  activeResult = nil

                  // wait animation
                  try? await Task.sleep(
                      for: .milliseconds(350)
                  )

                onResult(error)

               // wait before resume
               try? await Task.sleep(
                   for: .seconds(2)
               )

               isPaused = false

               resetHandling()
            
        default:
            resetHandling()
            
            hasHandledResult = false
        }
    }

    // MARK: Close Sheet + Resume Scanner

    func closeSheetAndResume() {

        activeResult = nil

        viewModel.resetScannerState()

        // Wait for sheet dismissal animation
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.3
        ) {

            isPaused = false
        }
        
    }
    
    func resetHandling() {
        
       

        hasHandledResult = false

        isPaused = false

        viewModel.resetScannerState()
    }
    
    
}

extension ScannerScreen {

    private func calculateScanRegion(screenSize: CGSize) {

        let width: CGFloat = 260
        let height: CGFloat = 260

        let rect = CGRect(
            x: (screenSize.width - width) / 2,
            y: (screenSize.height - height) / 2,
            width: width,
            height: height
        )

        scanRegion = convertToNormalized(rect: rect, in: screenSize)
    }

    private func convertToNormalized(rect: CGRect, in size: CGSize) -> CGRect {

        let x = rect.origin.x / size.width
        let y = 1 - ((rect.origin.y + rect.height) / size.height) // 🔥 IMPORTANT
        let width = rect.width / size.width
        let height = rect.height / size.height

        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension ScannerScreen {

   

        private func handleScan(_ code: String) {

            
            debugPrint("scanner code " + code)
            guard !isPaused else { return }

            isPaused = true   // ✅ stop multiple scans

            let cleanedCode = code
                .trimmingCharacters(in: .whitespacesAndNewlines)

            let success = cleanedCode
                .lowercased()
                .contains("policyboss")

            
            
            // INVALID QR
                guard success else {

                    activeResult = ScanResult(
                        rawCode: cleanedCode,
                        token: "",
                        ipAddress: "",
                        deviceInfo: "",
                        isSuccess: false
                    )

                    return
                }
            
            // SPLIT USING |
                let components = cleanedCode.components(
                    separatedBy: "|"
                )

                // SAFETY CHECK
                guard components.count >= 3 else {

                    activeResult = ScanResult(
                        rawCode: cleanedCode,
                        token: "",
                        ipAddress: "",
                        deviceInfo: "",
                        isSuccess: false
                    )

                    return
                }
            
            // FIRST PART
                let tokenPart = components[0]

                // TOKEN EXTRACTION
                let token = tokenPart
                    .components(separatedBy: "token=")
                    .last ?? ""

                // SECOND PART
                let ipAddress = components[1]

                // THIRD PART
                let deviceInfo = components[2]

            print("TOKEN:", token)
              print("IP:", ipAddress)
              print("DEVICE:", deviceInfo)
            
            print("SCANNED:", success)

               Task {

                   await viewModel.qrPreScanner(
                       token: token
                   )
               }
           
            // ✅   // STORE STRUCTURED RESULT
            activeResult = ScanResult(
                    rawCode: cleanedCode,
                    token: token,
                    ipAddress: ipAddress,
                    deviceInfo: deviceInfo,
                    isSuccess: true
                )
            

        }
    

    
    
    
}


//#Preview {
//    
//   let viewModel = HomeViewModel(
//        repository: HomeRepository(apiService:  APIService()))
//   
//    ScannerScreen(viewModel: viewModel, onResult: {_ in })
//}
