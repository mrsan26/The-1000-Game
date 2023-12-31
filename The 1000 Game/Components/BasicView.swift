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
        self.backgroundColor = .white.withAlphaComponent(0.4)
        self.layer.cornerRadius = 20
        self.clipsToBounds = true

        // Применение тени
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        
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
