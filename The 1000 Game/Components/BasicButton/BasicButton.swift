//
//  BasicButton.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine
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
        Vibration.button.vibrate()
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .red:
            self.colors = .init(button: UIColor(red: 0.922, green: 0.294, blue: 0.384, alpha: 1), shadow: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
        case .blue:
            self.colors = .init(button: UIColor(red: 0.227, green: 0.51, blue: 0.969, alpha: 1), shadow: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
        case .yellow:
            self.colors = .init(button: UIColor(red: 0.817, green: 0.801, blue: 0.555, alpha: 1), shadow: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
        }
        self.setTitleColor(.white, for: .normal)
        
        self.cornerRadius = UIScreen.main.bounds.size.height / 11 / 3
        self.shadowHeight = 4
        
        self.snp.makeConstraints { make in
            make.height.equalTo(Int(UIScreen.main.bounds.size.height / 11))
            make.width.equalTo(200)
        }
    }
}

extension BasicButton {
    enum Style {
        case red
        case blue
        case yellow
    }
}



