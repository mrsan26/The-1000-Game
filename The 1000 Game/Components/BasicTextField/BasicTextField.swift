//
//  BasicTextField.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine

class BasicTextField: UIView {
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: .init(x: self.frame.size.width - 10, y: 0, width: 10, height: 0))
        
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 20
        
        textField.backgroundColor = .white.withAlphaComponent(0.3)
        
        textField.font = UIFont(name: "robotrondotmatrix", size: 20)
        textField.textColor = .white
        
        textField.addTarget(
            self,
            action: #selector(textChanged),
            for: .editingChanged
        )
                
        textField.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        return textField
    }()
    
    private lazy var errorLabel: BasicLabel = {
        let label = BasicLabel(color: .systemPink, aligment: .center, font: .InterBlack, fontSize: 16)
        label.isHidden = true
        return label
    }()
    
    var text: String?
    
    init(becomeFirstResponderMode: Bool = false) {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        
        if becomeFirstResponderMode {
            textField.becomeFirstResponder()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.addSubview(contentStack)
        contentStack.addArrangedSubview(textField)
        contentStack.addArrangedSubview(errorLabel)
    }
    
    private func makeConstraints() {
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func textChanged() {
        text = textField.text
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancellables.removeAll()

        vm.$text.sink { [weak self] value in
            guard let value else { return }
            self?.textField.text = value
        }
        .store(in: &cancellables)
        
        
        vm.$placeholder.sink { [weak self] value in
            guard let value else { return }
            self?.textField.placeholder = value
        }
        .store(in: &cancellables)
        
        vm.$errorText.sink { [weak self] value in
            guard let value else { return }
            self?.errorLabel.text = value
        }
        .store(in: &cancellables)
    }
    
    func checkInput(validationRule: ValidationRules) -> Bool {
        if textField.text?.validate(validationRule.pattern) ?? false {
            errorLabel.isHidden = true
            return true
        } else {
            errorLabel.isHidden = false
            return false
        }
    }
}
