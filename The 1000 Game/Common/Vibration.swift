//
//  Vibration.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import UIKit

enum Vibration {
        case error
//        case success
//        case warning
//        case light
        case button //medium
        case heavy
        @available(iOS 13.0, *)
        case viewTap //soft
//        @available(iOS 13.0, *)
//        case rigid
        case selection
        
        public func vibrate() {
            switch self {
            case .error:
                UINotificationFeedbackGenerator().notificationOccurred(.error)
//            case .success:
//                UINotificationFeedbackGenerator().notificationOccurred(.success)
//            case .warning:
//                UINotificationFeedbackGenerator().notificationOccurred(.warning)
//            case .light:
//                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .button:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            case .viewTap:
                if #available(iOS 13.0, *) {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
//            case .rigid:
//                if #available(iOS 13.0, *) {
//                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
//                }
            case .selection:
                UISelectionFeedbackGenerator().selectionChanged()
            }
        }
    }
