//
//  BasicTextField.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine

class BasicTextField: UITextField {
    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.leftViewMode = .always
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        self.rightViewMode = .always
        self.rightView = UIView(frame: .init(x: self.frame.size.width - 10, y: 0, width: 10, height: 0))
        
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 20
        
        self.backgroundColor = .white.withAlphaComponent(0.3)
        
        self.font = UIFont(name: "robotrondotmatrix", size: 20)
        self.textColor = .white
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancellables.removeAll()

        vm.$text.sink { [weak self] value in
            guard let value else { return }
            self?.text = value
        }
        .store(in: &cancellables)
        
        
        vm.$placeholder.sink { [weak self] value in
            guard let value else { return }
            self?.placeholder = value
        }
        .store(in: &cancellables)
        
    }
}
