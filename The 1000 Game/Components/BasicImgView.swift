//
//  BasicImgView.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.11.2023.
//

import UIKit

class BasicImgView: UIImageView {
    
    init(name: ImageName?,
         image: UIImage? = nil,
         height: Int,
         width: Int,
         tintColor: UIColor? = .white,
         withShadow: Bool = false
    ) {
        super.init(frame: .zero)
        
        if let name {
            switch name {
            case .named(let name):
                self.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
            case .systemNamed(let name):
                self.image = UIImage(systemName: name)
            }
        }
        
        if let image {
            self.image = image
        }
        
        if let tintColor {
            self.tintColor = tintColor
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        if withShadow {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
            self.layer.shadowOpacity = 0.8
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowRadius = 4
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

enum ImageName {
    case named(String)
    case systemNamed(String)
}
