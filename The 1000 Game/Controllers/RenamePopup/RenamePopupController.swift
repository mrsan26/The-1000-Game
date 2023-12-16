//
//  RenamePopupController.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit
import Combine

class RenamePopupController: UIViewController {
    var cancellables: Set<AnyCancellable> = []

    let viewModel: RenamePopupControllerModel
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.831, green: 0.529, blue: 0.655, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var titleLabel = BasicLabel(color: .white, aligment: .center, font: .InterBlack, fontSize: 16)
    
    private lazy var textField = BasicTextField(becomeFirstResponderMode: true)
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var confirmButton = BasicButton(style: .blue)
    private lazy var cancelButton = BasicButton(style: .red)
    
    var playerForEditing: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        binding()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnView)))
    }
    
    private var acceptAction: VoidBlock?

    init(viewModel: RenamePopupControllerModel, playerForEditing: Player, acceptAction: VoidBlock? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.acceptAction = acceptAction
        self.playerForEditing = playerForEditing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeLayout() {
        self.view.addSubview(mainView)
        mainView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(textField)
        contentStack.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(confirmButton)
    }

    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.size.height / 5.5)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
        }
    }

    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    private func binding() {
        self.titleLabel.setViewModel(viewModel.titleLabelVM)
        self.viewModel.titleLabelVM.textValue = .text("Переименование \(playerForEditing?.name ?? "Игрока")")
        
        self.textField.setViewModel(viewModel.textFieldVM)
        
        self.confirmButton.setViewModel(viewModel.confirmButtonVM)
        self.viewModel.confirmButtonVM.action = { [weak self] in
            guard let self,
                  self.textField.checkInput(validationRule: .length(min: 2, max: 10)),
                  let name = self.textField.text else { return }
            
            RealmManager().update { realm in
                try? realm.write({
                    self.playerForEditing?.name = name
                })
            }
            self.acceptAction?()
            self.dismiss(animated: true)
        }
        
        self.cancelButton.setViewModel(viewModel.cancelButtonVM)
        self.viewModel.cancelButtonVM.action = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    @objc private func tapOnView() {
        self.dismiss(animated: true)
        Vibration.viewTap.vibrate()
    }
}

extension RenamePopupController {
    static func show(playerForEditing: Player, acceptAction: VoidBlock?) {
        let popup = RenamePopupController(viewModel: .init(), playerForEditing: playerForEditing, acceptAction: acceptAction)
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(popup, animated: true)
        }
    }
}
