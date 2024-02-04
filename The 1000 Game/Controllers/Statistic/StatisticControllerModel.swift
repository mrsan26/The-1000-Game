//
//  StatisticControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.01.2024.
//

import Foundation

final class StatisticControllerModel: Combinable {
    
    let turnNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryTurnNumberLabel.localized))
    let pointsNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryPointsNumberLabel.localized))
    let pointsChangesNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryPointsChangesNumberLabel.localized))
    
    override init() {
        super.init()
    }
}
