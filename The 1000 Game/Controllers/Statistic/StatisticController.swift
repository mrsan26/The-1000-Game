//
//  StatisticController.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.01.2024.
//

import UIKit
import Combine

class StatisticController: BasicPresentController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: StatisticControllerModel
            
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        makeTitle(text: "Статистика игры")
    }
    
    init(viewModel: StatisticControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        
    }
    
    private func makeConstraints() {
        
    }
    
    override func binding() {
    }
}
