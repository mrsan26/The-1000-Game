//
//  ChevronImg.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.11.2023.
//

import UIKit

class ChevronImg: UIImageView {
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.image = UIImage(named: "right_schevron")
        self.tintColor = .white
        
        self.snp.makeConstraints { make in
            make.height.width.equalTo(17)
        }
    }
    
}
