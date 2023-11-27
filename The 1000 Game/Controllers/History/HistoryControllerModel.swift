//
//  HistoryControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation

final class HistoryControllerModel: Combinable {
    
    let nameLabelVM = BasicLabel.ViewModel()
    
    let turnNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Ход"))
    let pointsNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Очки"))
    let pointsChangesNumberLabelVM = BasicLabel.ViewModel(textValue: .text("Изменения"))
        
    override init() {
        super.init()
    }
}
