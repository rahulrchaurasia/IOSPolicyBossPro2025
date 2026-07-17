//
//  ConfirmLoginSheet.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 20/03/26.
//

/* Note : VVImp
 SIMPLE RULE (REMEMBER THIS)
 If sheet is controlled by @State → NEVER use dismiss()
 ⚡ WHEN SHOULD YOU USE dismiss()?

 Only when:

 .sheet(isPresented: $showSheet)
 */

/*
 
 // ************* Note VVIMP **********
 
 ********* Dialog Closing Logic  ***********
 1. resetScannerState()

 You asked:

 if not idle return it also set idle ?

 NO.

 This code:

 func resetScannerState() {

     guard scannerState != .idle else {
         return
     }

     scannerState = .idle
 }

 means:

 IF scannerState is ALREADY .idle
 → stop here
 → do nothing

 ELSE
 → set scannerState = .idle

 Equivalent normal form:

 func resetScannerState() {

     if scannerState == .idle {
         return
     }

     scannerState = .idle
 }
 WHY WE NEED THIS

 Because every time you change:

 scannerState

 SwiftUI fires:

 .onChange(of: viewModel.scannerState)

 So:

 .success
 → .idle

 triggers .onChange AGAIN.

 That can cause:

 duplicate dismiss
 duplicate snackbar
 duplicate state handling

 So this guard prevents unnecessary extra state changes.

 Example

 WITHOUT guard:

 scannerState = .idle
 scannerState = .idle
 scannerState = .idle

 Every line still triggers:

 @Published update
 SwiftUI refresh
 .onChange

 even though value is same logically.

 So guard avoids redundant UI updates.

 2. hasHandledResult

 This solves COMPLETELY DIFFERENT issue.

 You asked:

 we already disable button right?

 YES.

 BUT button disabling protects ONLY against:

 multiple user taps

 NOT against:

 multiple state changes
 multiple async callbacks
 multiple onChange executions

 Very different problem.

 BUTTON DISABLE PROTECTS UI

 This:

 .disabled(isLoading)

 prevents:

 User taps Confirm twice quickly

 GOOD.

 But it does NOT protect this:

 API success
 ↓
 scannerState = .success
 ↓
 .onChange fires
 ↓
 resetScannerState()
 ↓
 scannerState = .idle
 ↓
 .onChange fires AGAIN

 That second .onChange
 has NOTHING to do with button taps.

 It is state lifecycle issue.

 So hasHandledResult protects BUSINESS FLOW

 This:

 @State private var hasHandledResult = false

 means:

 "Did we already process this success/error lifecycle?"
 */

import SwiftUI

struct ConfirmLoginSheet: View {

    let result: ScanResult

    @ObservedObject var viewModel: HomeViewModel

       var onConfirm: () -> Void
       var onCancel: () -> Void

    
    private var isLoading: Bool {

           viewModel.scannerState.isLoading
       }
    var body: some View {

        VStack(spacing: 16) {

            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)

            Text("Confirm login")
                .font(.title2)
                .fontWeight(.semibold)

//            Text("You'll be logged into the desktop device after your PIN/Biometric verification")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
            
            Text("You'll be logged into the desktop device after your verification")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
            

            VStack(spacing: 12) {

               // infoRow(title: "Web Location", value: result.location)

                infoRow(
                    title: "Web IP address",
                    value: result.ipAddress
                )

                infoRow(
                    title: "Web device",
                    value: result.deviceInfo
                )
            }
            .padding(.top, 8)

            // ✅ LOADER
            // ✅ FIXED HEIGHT AREA
            HStack(spacing: 12) {

                ProgressView()
                    .tint(Color.accentColor)
                    .opacity(isLoading ? 1 : 0)

                Text("Processing...")
                    .font(.subheadline)
                    .foregroundStyle(Color.accentColor)
                    .opacity(isLoading ? 1 : 0)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            .padding(.top, 10)
            .animation(.easeInOut, value: isLoading)

            HStack(spacing: 12) {

                Button(action: onCancel) {

                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            isLoading
                            ? Color.gray.opacity(0.25)
                            : Color(.systemGray5)
                        )
                        .foregroundColor(
                            isLoading
                            ? .gray
                            : .primary
                        )
                        .cornerRadius(10)
                }
                .disabled(isLoading)

                Button(action: onConfirm) {

                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            isLoading
                            ? Color.accentColor.opacity(0.4)
                            : Color.accentColor
                        )
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                }
                .disabled(isLoading)
            }
            .padding(.top, 12)
        }
        .padding()
        .animation(.easeInOut, value: isLoading)
    }

    // Reusable row
    private func infoRow(title: String, value: String) -> some View {

        HStack(alignment: .top, spacing: 16) {

            Text(title)
                .foregroundColor(.gray)
                .frame(width: 120, alignment: .leading)

            Text(value)
                .fontWeight(.medium)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    let result = ScanResult(
            rawCode: "wdqwdqd1313",
            token: "cdcwc",
            ipAddress: "10.0.3.4",
            deviceInfo: "Chrome 145.0.0.0 (Windows 10)",
            isSuccess: true
        )

    
    let viewModel = HomeViewModel(
           repository: HomeRepository(apiService:  APIService()))

        viewModel.scannerState = .loading

        return ConfirmLoginSheet(
            result: result,
            viewModel: viewModel,
            onConfirm: {},
            onCancel: {}
        )
}

