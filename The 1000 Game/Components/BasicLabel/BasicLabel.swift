//
//  BasicLabel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine

class BasicLabel: UILabel {
    private var cancallables: Set<AnyCancellable> = []

    init(aligment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.textAlignment = aligment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancallables.removeAll()

        vm.$textValue.sink { [weak self] value in
            guard let value else { return }
            
            switch value {

            case .text(let text):
                self?.text = text

            case .attributed(let attributed):
                self?.attributedText = attributed
            }
        }
        .store(in: &cancallables)
        
    }
    
}
