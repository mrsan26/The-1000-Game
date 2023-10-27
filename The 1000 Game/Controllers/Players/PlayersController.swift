//
//  PlayersController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import UIKit
import Combine
import SnapKit

class PlayersController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: PlayersControllerModel
    
    private lazy var playersTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    private lazy var playerNameTextField = BasicTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(viewModel: PlayersControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(playerNameTextField)
    }
    
    override func makeConstraints() {
        playerNameTextField.snp.makeConstraints { make in
            make.leading.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        playerNameTextField.setViewModel(viewModel.playerNameInputVM)
    }

}

