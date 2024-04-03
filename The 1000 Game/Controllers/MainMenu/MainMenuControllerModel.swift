//
//  MainMenuControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import Foundation

final class MainMenuControllerModel: Combinable {
    
    let mainNameLabelVM = BasicLabel.ViewModel(textValue: .text("1000"))
    
    let playersLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcMainMenuPlayersView.localized))
    let playersCountLabelVM = BasicLabel.ViewModel(
        textValue:
                .text((UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault).toString())
    )
    let dicesChoiseLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcMainMenuDiceView.localized))
    let aboutGameLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcMainMenuaboutGameView.localized))
    
    let startGameButton = BasicButton.ViewModel(title: AppLanguage.vcMainMenuStartButton.localized)
    
    override init() {
        super.init()
    }
    
    func updateLabels() {
        playersLabelVM.textValue = .text(AppLanguage.vcMainMenuPlayersView.localized)
        dicesChoiseLabelVM.textValue = .text(AppLanguage.vcMainMenuDiceView.localized)
        aboutGameLabelVM.textValue = .text(AppLanguage.vcMainMenuaboutGameView.localized)
        startGameButton.title = AppLanguage.vcMainMenuStartButton.localized
    }
}
