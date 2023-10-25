//
//  MainGameController.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import UIKit
import Combine

class MainGameController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel: MainGameControllerModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    init(viewModel: MainGameControllerModel) {
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
