//
//  Ext Collection.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.11.2023.
//

import UIKit

extension UICollectionView {
    func reloadDataWithAnimation(duration: TimeInterval = 0.3, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.reloadData()
        }, completion: { _ in
            completion?()
        })
    }
}
