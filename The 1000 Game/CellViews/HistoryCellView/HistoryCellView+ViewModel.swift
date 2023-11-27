//
//  HistoryCellView+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation

extension HistoryCellView {
    final class ViewModel {
        
        let turnNumberLabelVM = BasicLabel.ViewModel()
        let pointsNumberLabelVM = BasicLabel.ViewModel()
        let pointsChangesNumberLabelVM = BasicLabel.ViewModel()
        
        let gameOpenedLabelVM = BasicLabel.ViewModel(textValue: .text("Игра открыта"), isHidden: true)
        let overtakenLabelVM = BasicLabel.ViewModel(textValue: .text("Вас обогнали"), isHidden: true)
        let boltsCrashLabelVM = BasicLabel.ViewModel(textValue: .text("Три болта"), isHidden: true)
        let yamaStatusLabelVM = BasicLabel.ViewModel(textValue: .text("Яма"), isHidden: true)
        let samosvalCrashLabelVM = BasicLabel.ViewModel(textValue: .text("Самосвал!"), isHidden: true)
        
        init() {
        }
        
        func setupLabels(turnNumber: Int, points: Int, changesPoints: Int, actions: ActionHistoryPoint) {
            var plus = ""
            changesPoints > 0 ? (plus = "+") : (plus = "")
            
            turnNumberLabelVM.textValue = .text(turnNumber.toString())
            pointsNumberLabelVM.textValue = .text(points.toString())
            pointsChangesNumberLabelVM.textValue = .text(plus + changesPoints.toString())
            
            gameOpenedLabelVM.isHidden = !actions.gameOpened
            overtakenLabelVM.isHidden = !actions.overtaken
            boltsCrashLabelVM.isHidden = !actions.boltsCrash
            yamaStatusLabelVM.isHidden = !actions.yamaStatus
            samosvalCrashLabelVM.isHidden = !actions.samosvalCrash
        }
    }
}
