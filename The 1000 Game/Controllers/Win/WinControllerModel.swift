//
//  WinControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

final class WinControllerModel: Combinable {
    
    let winWordLabelVM = BasicLabel.ViewModel(textValue: .text("Победа"))
    let winerEmojiLabelVM = BasicLabel.ViewModel()
    let nameLabelVM = BasicLabel.ViewModel()
    let pointsLabelVM = BasicLabel.ViewModel()
    let resetButtonVM = BasicButton.ViewModel(title: "Начать заново")
    
    var playersWithoutWinner: [Player] = []
    var winnerPlayer: Player?
    
    override init() {
        super.init()
    }
    
    func updateComponents() {
        guard let winnerPlayer else { return }
        winerEmojiLabelVM.textValue = .text(winnerPlayer.emoji)
        nameLabelVM.textValue = .text(winnerPlayer.name)
        pointsLabelVM.textValue = .text(winnerPlayer.points.toString())
    }
    
}
