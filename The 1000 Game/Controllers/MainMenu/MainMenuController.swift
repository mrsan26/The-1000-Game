//
//  MainMenuController.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine

class MainMenuController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: MainMenuControllerModel
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 26
        return stack
    }()
    private lazy var newGameButton = BasicButton(style: .blue)
    private lazy var roolsButton = BasicButton(style: .blue)
    private lazy var settingsButton = BasicButton(style: .blue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: MainMenuControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(newGameButton)
        buttonsStackView.addArrangedSubview(roolsButton)
        buttonsStackView.addArrangedSubview(settingsButton)
    }
    
    override func makeConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.newGameButton.setViewModel(viewModel.newGameButtonVM)
        self.viewModel.newGameButtonVM.action = { [weak self] in
            let mainGameVC = MainGameController(viewModel: .init())
            self?.navigationController?.pushViewController(mainGameVC, animated: true)
        }
        
        self.roolsButton.setViewModel(viewModel.roolsButtonVM)
        self.settingsButton.setViewModel(viewModel.settingsButtonVM)
    }

}
