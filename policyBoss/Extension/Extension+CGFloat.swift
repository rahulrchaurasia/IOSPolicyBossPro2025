//
//  Extension+CGFloat.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 18/05/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//

import Foundation
import SwiftUI

extension CGFloat {
    
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(per: Double) -> Double {
        return screenWidth * per
    }
    
    static func heightPer(per: Double) -> Double {
        return screenHeight * per
    }
    
    
    static func getSafeArea() -> UIEdgeInsets {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return .zero
        }
        return window.safeAreaInsets
    }
    static func getSafeArea2() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
        
    }
   
    static var topInsets: CGFloat {
          getSafeArea().top
      }

      static var bottomInsets: CGFloat {
          getSafeArea().bottom
      }
    
    static var horizontalInsets: CGFloat {
        let insets = getSafeArea()
        return insets.left + insets.right
    }

    static var verticalInsets: CGFloat {
        let insets = getSafeArea()
        return insets.top + insets.bottom
    }
    
//    static var topInsets: Double {
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            return Double(scene.windows.first?.safeAreaInsets.top ?? 50)
//        }
//        return 0.0
//
//    }
//
//
//    static var bottomInsets: Double {
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            return Double(scene.windows.first?.safeAreaInsets.bottom ?? 50)
//        }
//        return 0.0
//    }
    
//    static var horizontalInsets: Double {
//
//
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            return Double(scene.windows.first?.safeAreaInsets.left ?? 8 + (scene.windows.first?.safeAreaInsets.right ?? 8) )
//        }
//        return 0.0
//    }
//
//    static var verticalInsets: Double {
//
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            return Double(scene.windows.first?.safeAreaInsets.top ?? 10 + (scene.windows.first?.safeAreaInsets.bottom ?? 10) )
//        }
//        return 0.0
//    }
    
}


struct ShowButton: ViewModifier {
    @Binding var isShow: Bool
    
    public func body(content: Content) -> some View {
        
        HStack {
            content
            Button {
                isShow.toggle()
            } label: {
                Image(systemName: !isShow ? "eye.fill" : "eye.slash.fill" )
                    .foregroundColor(.white)
            }

        }
    }
}
