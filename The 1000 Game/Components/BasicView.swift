//
//  BasicView.swift
//  The 1000 Game
//
//  Created by Sanchez on 02.11.2023.
//

import Foundation
import UIKit

class BasicView: UIView {
    
    var standartSize = true
    var userInteractive = false
    
    var touchClosure: (() -> Void)?
    
    init(standartSize: Bool = true, userInteractive: Bool = false) {
        super.init(frame: .zero)
        self.standartSize = standartSize
        self.userInteractive = userInteractive
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white.withAlphaComponent(0.4)
        self.layer.cornerRadius = UIScreen.main.bounds.size.height / 11 / 3
        self.clipsToBounds = true

        // Применение тени
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        
        if standartSize {
            self.snp.makeConstraints { make in
                make.height.equalTo((Int(UIScreen.main.bounds.size.height / 11)))
            }
        }
        
        if userInteractive {
            self.userInteractive = true
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touch)))
        }
    }
    
    @objc private func touch() {
        touchClosure?()
    }
    
    
}
