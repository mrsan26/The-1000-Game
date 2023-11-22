//
//  BasicView.swift
//  The 1000 Game
//
//  Created by Sanchez on 02.11.2023.
//

import Foundation
import UIKit

class BasicView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white.withAlphaComponent(0.3)
        
//        self.alpha = 0.3
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true

        // Применение тени
        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.layer.shadowRadius = 4
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        
        // Настройка тени, чтобы она не отображалась из-за прозрачности самого представления
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale

        // Прозрачность самого представления
//        self.alpha = 0.8 // Например, установка прозрачности в 80%

        
        
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 4
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                         y: bounds.maxY - layer.shadowRadius,
//                                                         width: bounds.width,
//                                                         height: layer.shadowRadius)).cgPath
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    
}

extension UIView {
    func makeClearViewWithShadow(
        cornderRadius: CGFloat,
        shadowColor: CGColor,
        shadowOpacity: Float,
        shadowRadius: CGFloat) {

        self.frame = self.frame.insetBy(dx: -shadowRadius * 2,
                                        dy: -shadowRadius * 2)
        self.backgroundColor = .clear
        let shadowView = UIView(frame: CGRect(
            x: shadowRadius * 2,
            y: shadowRadius * 2,
            width: self.frame.width - shadowRadius * 4,
            height: self.frame.height - shadowRadius * 4))
        shadowView.backgroundColor = .black
        shadowView.layer.cornerRadius = cornderRadius
        shadowView.layer.borderWidth = 1.0
        shadowView.layer.borderColor = UIColor.clear.cgColor

        shadowView.layer.shadowColor = shadowColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.masksToBounds = false
        self.addSubview(shadowView)

        let p: CGMutablePath = CGMutablePath()
        p.addRect(self.bounds)
        p.addPath(UIBezierPath(roundedRect: shadowView.frame, cornerRadius: shadowView.layer.cornerRadius).cgPath)

        let s = CAShapeLayer()
        s.path = p
        s.fillRule = CAShapeLayerFillRule.evenOdd

       self.layer.mask = s
    }
}
