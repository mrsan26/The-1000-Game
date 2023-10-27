//
//  BasicButton.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine
import SwiftyButton
import SnapKit

class BasicButton: PressableButton {
    private var cancellables: Set<AnyCancellable> = []
    
    weak var vm: ViewModel?
    
    init(style: Style = .blue) {
        super.init(frame: .zero)
        
        setStyle(style)
        
        initButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButton() {
        self.addTarget(
            self,
            action: #selector(tapAction),
            for: .touchUpInside
        )
    }
    
    func setViewModel(_ vm: ViewModel) {
        self.vm = vm
        
        vm.$isEnabled.sink { [weak self] value in
            self?.isEnabled = value
            self?.alpha = value ? 1 : 0.5
        }
        .store(in: &cancellables)
        
        vm.$title.sink { [weak self] title in
            switch title {
                
            case .text(let text):
                self?.setTitle(text, for: .normal)
            case .attributed(let attributed):
                self?.titleLabel?.attributedText = attributed
            }
        }
        .store(in: &cancellables)
    }
    
    @objc private func tapAction() {
        vm?.action?()
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .red:
            self.colors = .init(button: .red, shadow: .systemGray4)
            self.setTitleColor(.white, for: .normal)
            
        case .blue:
            self.colors = .init(button: .systemBlue, shadow: .systemGray4)
            self.setTitleColor(.white, for: .normal)
            
        case .green:
            self.colors = .init(button: .green, shadow: .systemGray4)
            self.setTitleColor(.white, for: .normal)
        }
        
        self.cornerRadius = 16
        self.shadowHeight = 8
    }
}

extension BasicButton {
    enum Style {
        case red
        case blue
        case green
    }
}



