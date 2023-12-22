//
//  ConfirmPopupController.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import UIKit
import Combine

class ConfirmPopupController: UIViewController {
    var cancellables: Set<AnyCancellable> = []

    let viewModel: ConfirmPopupControllerModel
    
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
    
    private lazy var titleLabel = BasicLabel(color: .white, aligment: .center, font: .InterBlack, fontSize: 18)
        
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
    private var positionView: ViewPosition?

    init(viewModel: ConfirmPopupControllerModel, titleText: String, position: ViewPosition, acceptAction: VoidBlock? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.acceptAction = acceptAction
        self.viewModel.titleLabelVM.textValue = .text(titleText)
        self.positionView = position
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeLayout() {
        self.view.addSubview(mainView)
        mainView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(confirmButton)
    }

    private func makeConstraints() {
        if let positionView {
            switch positionView {
            case .top:
                mainView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(self.view.frame.size.height / 5.5)
                    make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
                }
            case .center:
                mainView.snp.makeConstraints { make in
                    make.centerX.centerY.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
                }
            }
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
        }
    }

    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    private func binding() {
        self.titleLabel.setViewModel(viewModel.titleLabelVM)
        
        self.confirmButton.setViewModel(viewModel.confirmButtonVM)
        self.viewModel.confirmButtonVM.action = { [weak self] in
            guard let self else { return }

            self.dismiss(animated: true)
            self.acceptAction?()
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

extension ConfirmPopupController {
    static func show(titleText: String, position: ViewPosition, acceptAction: VoidBlock?) {
        let popup = ConfirmPopupController(viewModel: .init(), titleText: titleText, position: position, acceptAction: acceptAction)
        
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

enum ViewPosition {
    case top
    case center
}
