//
//  StatisticControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.01.2024.
//

import Foundation

final class StatisticControllerModel: Combinable {
    
    let turnNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Ход"))
    let pointsNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Очки"))
    let pointsChangesNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Изменения"))
    
    override init() {
        super.init()
    }
}
