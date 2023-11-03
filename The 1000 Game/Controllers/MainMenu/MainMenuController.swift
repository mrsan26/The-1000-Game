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
        stack.spacing = 13
        return stack
    }()
    private lazy var mainNameLabel: BasicLabel = {
        let label = BasicLabel(aligment: .center, font: .AlfaSlabOne, fontSize: 60)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        return label
    }()
    private lazy var playersGestureView = BasicView()
    private lazy var dicesChoiseGestureView = BasicView()
    private lazy var bochkiToogleView = BasicView()
    private lazy var botsToogleView = BasicView()
    private lazy var startGameButton = BasicButton(style: .red)
//    private lazy var roolsButton = BasicButton(style: .blue)
//    private lazy var settingsButton = BasicButton(style: .blue)
    
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
        self.view.addSubview(mainNameLabel)
        buttonsStackView.addArrangedSubview(playersGestureView)
        buttonsStackView.addArrangedSubview(dicesChoiseGestureView)
        buttonsStackView.addArrangedSubview(bochkiToogleView)
        buttonsStackView.addArrangedSubview(botsToogleView)
        self.view.addSubview(startGameButton)
    }
    
    override func makeConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
        
        mainNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-56)
        }
        
        startGameButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.startGameButton.setViewModel(viewModel.startGameButton)
//        self.viewModel.newGameButtonVM.action = { [weak self] in
//            let playersVC = PlayersController(viewModel: .init())
//            self?.navigationController?.pushViewController(playersVC, animated: true)
//        }
//
        self.mainNameLabel.setViewModel(viewModel.mainNameLabelVM)
        
    }

}
