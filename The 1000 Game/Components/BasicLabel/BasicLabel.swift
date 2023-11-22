//
//  BasicLabel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine

class BasicLabel: UILabel {
    private var cancellables: Set<AnyCancellable> = []

    init(
        color: UIColor = .white,
        aligment: NSTextAlignment = .left,
        font: FontValue,
        fontSize: CGFloat
    ) {
        super.init(frame: .zero)
        self.textColor = color
        self.textAlignment = aligment
        switch font {
        case .RobotronDot:
            self.font = UIFont(name: "robotrondotmatrix", size: fontSize)
        case .AlfaSlabOne:
            self.font = UIFont(name: "AlfaSlabOne-Regular", size: fontSize)
        case .InterBlack:
            self.font = UIFont(name: "inter-black", size: fontSize)
        }
        self.minimumScaleFactor = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancellables.removeAll()

        vm.$textValue.sink { [weak self] value in
            guard let value else { return }
            
            switch value {
            case .text(let text):
                self?.text = text

            case .attributed(let attributed):
                self?.attributedText = attributed
            }
        }
        .store(in: &cancellables)
        
    }
    
}
