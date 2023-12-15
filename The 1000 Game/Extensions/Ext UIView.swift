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
    
    func rotateAnimation(duration: TimeInterval = 0.3, rotations: Double, completion: ((Bool) -> Void)? = nil) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: rotations * 2 * Double.pi)
        rotationAnimation.duration = duration
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 1
        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?(true)
        }
    }
    
    func fadeInAnimation(duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOutAnimation(duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func flyInFromRightAnimation(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        let originalCenter = center
        
        // Смещаем метку за пределы экрана слева
        let screenWidth = UIScreen.main.bounds.width
        let offScreenCenter = CGPoint(x: +(1.5 * screenWidth), y: originalCenter.y)
        center = offScreenCenter
        
        // Анимация влета информации
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            self.center = originalCenter
        }, completion: completion)
    }
    
    func flyInFromLeftAnimation(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        let originalCenter = center
        
        // Смещаем метку за пределы экрана слева
        let screenWidth = UIScreen.main.bounds.width
        let offScreenCenter = CGPoint(x: -screenWidth / 2, y: originalCenter.y)
        center = offScreenCenter
        
        // Анимация влета информации
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            self.center = originalCenter
        }, completion: completion)
    }
    
    func pulseAnimation(duration: TimeInterval = 0.2, scale: CGFloat = 1.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            // Установка масштаба для анимации пульсации
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                // Возвращение к исходному размеру
                self.transform = CGAffineTransform.identity
            }, completion: { _ in
                // Вызов замыкания по завершению анимации
                completion?()
            })
        })
    }
    
}
