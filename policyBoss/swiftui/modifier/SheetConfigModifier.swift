//
//  SheetConfigModifier.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 18/05/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//
import SwiftUI

struct SheetConfigModifier: ViewModifier {
    func body(content: Content) -> some View {

        if #available(iOS 16.0, *) {
            content
                .presentationDetents([.fraction(0.5)])
                .interactiveDismissDisabled()
        } else {
            content
            // iOS 15 fallback (default full screen sheet)
        }
    }
}
