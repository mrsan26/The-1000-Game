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
    private var titleFontSize: CGFloat
    
    init(style: Style, titleFontSize: CGFloat = 30) {
        self.titleFontSize = titleFontSize
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
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "robotrondotmatrix", size: self?.titleFontSize ?? 30) ?? .systemFont(ofSize: 30),
                ]
            self?.setAttributedTitle(.init(string: title, attributes: attributes), for: .normal)
        }
        .store(in: &cancellables)
    }
    
    @objc private func tapAction() {
        vm?.action?()
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .red:
            self.colors = .init(button: UIColor(red: 0.922, green: 0.294, blue: 0.384, alpha: 1), shadow: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
            self.setTitleColor(.white, for: .normal)
        }
        
        self.cornerRadius = 20
        self.shadowHeight = 4
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(200)
        }
    }
}

extension BasicButton {
    enum Style {
        case red
    }
}



