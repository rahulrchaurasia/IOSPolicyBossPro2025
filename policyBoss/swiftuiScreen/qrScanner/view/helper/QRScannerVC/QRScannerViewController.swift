//
//  QRScannerViewController.swift
//  RahulProjectSwiftUI
//
//  Created by Rahul Chaurasia on 19/03/26.
//




import UIKit
import AVFoundation
import Vision


import UIKit
import AVFoundation
import Vision



class QRScannerViewController: UIViewController {

    // MARK: - Callback

    var onDetected: ((String) -> Void)?

    // MARK: - ROI

    var scanRegion: CGRect = .init(
        x: 0,
        y: 0,
        width: 1,
        height: 1
    )

    // MARK: - Camera

    private let session = AVCaptureSession()

    private var previewLayer: AVCaptureVideoPreviewLayer?

    // MARK: - State

    private var isProcessing = false

    private(set) var isPaused = false

    private var lastScannedValue: String?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        checkPermissionAndSetup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        previewLayer?.frame = view.bounds
    }

    deinit {

        print("QRScannerViewController DEINIT")

        session.stopRunning()
    }
}

// MARK: - Permission

extension QRScannerViewController {

    private func checkPermissionAndSetup() {

        let status = AVCaptureDevice.authorizationStatus(
            for: .video
        )

        switch status {

        case .authorized:

            setupCamera()

        case .notDetermined:

            AVCaptureDevice.requestAccess(
                for: .video
            ) { granted in

                if granted {

                    DispatchQueue.main.async {

                        self.setupCamera()
                    }
                }
            }

        default:

            print("❌ Camera permission denied")
        }
    }
}

// MARK: - Setup

extension QRScannerViewController {

    private func setupCamera() {

        // CAMERA DEVICE
        guard let device = AVCaptureDevice.default(
            for: .video
        ) else {

            print("❌ Camera device missing")
            return
        }

        // INPUT
        guard let input = try? AVCaptureDeviceInput(
            device: device
        ) else {

            print("❌ Camera input failed")
            return
        }

        // QUALITY
        session.sessionPreset = .high

        session.beginConfiguration()

        // INPUT
        if session.canAddInput(input) {

            session.addInput(input)
        }

        // OUTPUT
        let output = AVCaptureVideoDataOutput()

        // IMPORTANT
        output.alwaysDiscardsLateVideoFrames = true

        output.setSampleBufferDelegate(
            self,
            queue: DispatchQueue(
                label: "qr.scanner.queue"
            )
        )

        if session.canAddOutput(output) {

            session.addOutput(output)
        }

        // ORIENTATION
        if let connection = output.connection(
            with: .video
        ) {

            connection.videoOrientation = .portrait
        }

        session.commitConfiguration()

        // PREVIEW
        let previewLayer = AVCaptureVideoPreviewLayer(
            session: session
        )

        previewLayer.frame = view.bounds

        previewLayer.videoGravity = .resizeAspectFill

        self.previewLayer = previewLayer

        view.layer.addSublayer(previewLayer)

        // START CAMERA
        DispatchQueue.global(
            qos: .userInitiated
        ).async {

            self.session.startRunning()

            print("✅ Camera started")
        }
    }
}

// MARK: - Controls

extension QRScannerViewController {

    func pauseScanning() {

        print("⏸ Scanner paused")

        isPaused = true
    }

    func resumeScanning() {

        print("▶️ Scanner resumed")

        isPaused = false

        // allow same QR again
        lastScannedValue = nil
    }
}

// MARK: - Detection

extension QRScannerViewController:
AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {

        // PREVENT MULTIPLE PROCESSING
        if isProcessing || isPaused {

            return
        }

        isProcessing = true

        // PIXEL BUFFER
        guard let pixelBuffer =
                CMSampleBufferGetImageBuffer(
                    sampleBuffer
                ) else {

            isProcessing = false
            return
        }

        // VISION REQUEST
        let request = VNDetectBarcodesRequest {
            [weak self] request,
            error in

            guard let self = self else {
                return
            }

            defer {

                self.isProcessing = false
            }

            // ERROR
            if let error = error {

                print("❌ Vision error:", error)
                return
            }

            // RESULTS
            guard let results =
                    request.results as? [VNBarcodeObservation],
                  let first = results.first,
                  let value = first.payloadStringValue
            else {

                return
            }

            print("✅ QR DETECTED:", value)

            // DUPLICATE PREVENTION
            if value == self.lastScannedValue {

                return
            }

            self.lastScannedValue = value

            DispatchQueue.main.async {

                self.pauseScanning()

                self.onDetected?(value)
            }
        }

        request.symbologies = [.qr]

        // IMPORTANT:
        // KEEP ROI DISABLED FOR NOW
        // request.regionOfInterest = scanRegion

        // HANDLER
        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right
        )

        do {

            try handler.perform([request])

        } catch {

            isProcessing = false

            print("❌ Vision perform failed:", error)
        }
    }
}




//class QRScannerViewController: UIViewController {
//
//    var onDetected: ((String) -> Void)?
//    var scanRegion: CGRect = .init(x: 0, y: 0, width: 1, height: 1)
//
//    private let session = AVCaptureSession()
//    private var isProcessing = false
//    // 🔥 CHANGE 1: expose isPaused to SwiftUI (for sync check)
//    private(set) var isPaused = false
//    
//    // 🔥 CHANGE 2: prevent duplicate scans
//    private var lastScannedValue: String? //added
//    
//    // 🔥 CHANGE 3: keep reference of previewLayer (for resizing fix)
//        private var previewLayer: AVCaptureVideoPreviewLayer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        checkPermissionAndSetup()
//    }
//
//    // MARK: Permission
//    private func checkPermissionAndSetup() {
//
//        let status = AVCaptureDevice.authorizationStatus(for: .video)
//
//        switch status {
//        case .authorized:
//            setupCamera()
//
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if granted {
//                    DispatchQueue.main.async {
//                        self.setupCamera()
//                    }
//                }
//            }
//
//        default:
//            print("Camera permission denied")
//        }
//    }
//
//    // MARK: Camera Setup
//    private func setupCamera() {
//
//        guard let device = AVCaptureDevice.default(for: .video),
//              let input = try? AVCaptureDeviceInput(device: device) else { return }
//
//        session.beginConfiguration()
//
//        if session.canAddInput(input) {
//            session.addInput(input)
//        }
//
//        let output = AVCaptureVideoDataOutput()
//        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "qr.queue"))
//
//        if session.canAddOutput(output) {
//            session.addOutput(output)
//        }
//
//        session.commitConfiguration()
//
//        // 🔥 CHANGE 3: store previewLayer reference
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.frame = view.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//
//        self.previewLayer = previewLayer //added
//        view.layer.addSublayer(previewLayer)
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.session.startRunning()
//        }
//    }
//
//    
//    // 🔥 CHANGE 3: fix rotation / layout issues
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        previewLayer?.frame = view.bounds
//    }
//
//    // 🔥 CHANGE 4: stop camera when leaving screen
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        session.stopRunning()
//    }
//    
//    // MARK: Controls
//       func pauseScanning() {
//           isPaused = true
//       }
//
//       func resumeScanning() {
//           isPaused = false
//
//           // 🔥 CHANGE 2: reset duplicate scan lock
//           lastScannedValue = nil
//       }
//}
//
//// MARK: Delegate
//extension QRScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//
//    func captureOutput(
//        _ output: AVCaptureOutput,
//        didOutput sampleBuffer: CMSampleBuffer,
//        from connection: AVCaptureConnection
//    ) {
//
//        if isProcessing || isPaused { return }
//
//        isProcessing = true
//
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            isProcessing = false
//            return
//        }
//
//        let request = VNDetectBarcodesRequest { [weak self] request, _ in
//
//            defer { self?.isProcessing = false }
//
//            guard let result = (request.results as? [VNBarcodeObservation])?.first,
//                  let value = result.payloadStringValue else { return }
//
//            // 🔥 CHANGE 2: prevent duplicate scan of same QR
//            if value == self?.lastScannedValue { return }
//            self?.lastScannedValue = value
//            
//            DispatchQueue.main.async {
//                self?.pauseScanning()
//                self?.onDetected?(value)
//            }
//        }
//
//        request.symbologies = [.qr]
//
//        // 🔥 ONLY SCAN INSIDE BOX
//       // request.regionOfInterest = scanRegion
//
//        let handler = VNImageRequestHandler(
//            cvPixelBuffer: pixelBuffer,
//            orientation: .right
//        )
//
//        try? handler.perform([request])
//    }
//}
