//
//  HistoryControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation

final class HistoryControllerModel: Combinable {
        
    let turnNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryTurnNumberLabel.localized))
    let pointsNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryPointsNumberLabel.localized))
    let pointsChangesNumberLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcHistoryPointsChangesNumberLabel.localized))
        
    override init() {
        super.init()
    }
}
