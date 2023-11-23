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
         tintColor: UIColor = .white
    ) {
        super.init(frame: .zero)
        
        if let name {
            switch name {
            case .named(let name):
                self.image = UIImage(named: name)
            case .systemNamed(let name):
                self.image = UIImage(systemName: name)
            }
        }
        
        if let image {
            self.image = image
        }
        
        self.tintColor = tintColor
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
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
