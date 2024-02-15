//
//  TimerService.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 07/02/24.
//  Copyright © 2024 policyBoss. All rights reserved.
//

import Foundation

class TimerViewModel : ObservableObject  {
    
    
    private var timer: Timer?
    @Published  var remainingTime: Double = 60.0 * 2 // Initial value
    // @Published  var remainingTime: Double = 60.0 * 30 // Initial value
    @Published var isResendButtonVisible: Bool = false
    //var onSelected: ((String) -> Void)?
    var onSelected: ((closureType) -> Void)?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.remainingTime -= 0.1
            
            // Update resend button visibility only when needed
            self.isResendButtonVisible = self.remainingTime <= 60.0 // Show when below 1 minute
            
            if self.remainingTime <= 0 {
                self.timer?.invalidate()
                // Perform actions after timer completion (e.g., calling onSelected)
               // self.isResendButtonVisible = false // Hide after expiration
                onSelected?(.close)
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        
    }
    
    func resendTimer() {
        stopTimer() // Explicitly stop if already running
        remainingTime = 60.0 * 2 // Reset to initial value (2 minutes)
        startTimer() // Restart the timer
    }
    
}
