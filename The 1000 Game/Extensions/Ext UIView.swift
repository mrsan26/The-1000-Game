//
//  Ext UIView.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit

extension UIView {
    func backgroundColorChangingAnimate(to color: UIColor, duration: TimeInterval = 0.3) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.backgroundColor = color
        }, completion: nil)
    }
}
