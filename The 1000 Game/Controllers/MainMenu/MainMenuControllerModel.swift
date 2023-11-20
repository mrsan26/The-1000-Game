//
//  MainMenuControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import Foundation

final class MainMenuControllerModel: Combinable {
    
    let mainNameLabelVM = BasicLabel.ViewModel(textValue: .text("1000"))
    
    let playersLabelVM = BasicLabel.ViewModel(textValue: .text("Игроки"))
    let playersCountLabelVM = BasicLabel.ViewModel(
        textValue:
                .text((UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault).toString())
    )
    let dicesChoiseLabelVM = BasicLabel.ViewModel(textValue: .text("Кубики/Скин"))
    let bochkiLabelVM = BasicLabel.ViewModel(textValue: .text("Бочки"))
    let botsLabelVM = BasicLabel.ViewModel(textValue: .text("С ботами"))
    
    let startGameButton = BasicButton.ViewModel(title: "Начать")
    
    override init() {
        super.init()
    }
    
    func updateLabelsInfo() {
        playersCountLabelVM.textValue = .text((UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault).toString())
    }
}
