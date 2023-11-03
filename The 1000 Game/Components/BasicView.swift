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
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {

        self.backgroundColor = .white
        self.alpha = 0.3
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }
    
    
}
