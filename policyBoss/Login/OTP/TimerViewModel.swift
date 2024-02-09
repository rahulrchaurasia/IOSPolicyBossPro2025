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
   // @Published  var remainingTime: Double = 60.0 * 0.5 // Initial value
    @Published  var remainingTime: Double = 60.0 * 30 // Initial value

    var onSelected: ((String) -> Void)?
   
        func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.remainingTime -= 0.1
                if self.remainingTime <= 0 {
                    self.timer?.invalidate()
                    // Perform actions after timer completion (e.g., calling onSelected)
                 
                    onSelected?("5555")
                }
            }
        }

        func stopTimer() {
            timer?.invalidate()
            timer = nil
          
        }

       

}
