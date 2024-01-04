//
//  Ext ProgressView.swift
//  The 1000 Game
//
//  Created by Sanchez on 12.12.2023.
//

import UIKit

extension UIProgressView {
    func fillingAnimation(progressValue: Float, duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.setProgress(progressValue.roundForSignsAfterDot(3), animated: true)
        }
    }
}
