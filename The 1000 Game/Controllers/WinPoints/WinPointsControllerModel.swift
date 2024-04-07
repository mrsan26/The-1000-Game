//
//  WinPointsControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 04.04.2024.
//

import Foundation

final class WinPointsControllerModel: Combinable {
    
    let titleLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcWinPointsTitleLabel.localized.uppercased()))
    let resetButtonVM = BasicButton.ViewModel(title: AppLanguage.vcWinPointsResetButton.localized)
    let continueButtonVM = BasicButton.ViewModel(title: AppLanguage.vcWinPointsContinueButton.localized)
    
    var allPlayers: [Player] = []
    var playersWithoutWinner: [Player] = []
    
    override init() {
        super.init()
    }
    
}
