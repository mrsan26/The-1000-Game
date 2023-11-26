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
    
    func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool, completion: (() -> Void)?) {
        self.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        
        // Если анимация включена, определяем длительность анимации
        let animationDuration = animated ? 0.3 : 0.0
        
        // Выполняем анимацию с задержкой, чтобы учесть время анимации скроллинга
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            completion?() // Вызываем замыкание после завершения скроллинга
        }
    }
}
