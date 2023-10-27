//
//  PlayersController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import UIKit
import Combine

class PlayersController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel: PlayersControllerModel
    
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
        
    }
    
    override func makeConstraints() {
        
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        
    }

}

