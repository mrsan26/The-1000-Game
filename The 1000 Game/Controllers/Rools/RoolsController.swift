//
//  RoolsController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine

class RoolsController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel: RoolsControllerModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: RoolsControllerModel) {
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
