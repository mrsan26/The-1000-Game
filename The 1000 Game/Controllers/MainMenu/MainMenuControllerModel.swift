//
//  MainMenuControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import Foundation

final class MainMenuControllerModel: Combinable {
    
    let mainNameLabelVM = BasicLabel.ViewModel(textValue: .text("1000"))
    let startGameButton = BasicButton.ViewModel(title: "Начать")
//    let roolsButtonVM = BasicButton.ViewModel(title: .text("Правила"))
//    let settingsButtonVM = BasicButton.ViewModel(title: .text("Настройки"))
    
    
    
    override init() {
        super.init()
    }
}
