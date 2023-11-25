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
    
    func rotate(duration: TimeInterval = 0.3, rotations: Double, completion: ((Bool) -> Void)? = nil) {
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
    
    func fadeIn(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func flyInFromRight(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
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
    
    func flyInFromLeft(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
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
}
