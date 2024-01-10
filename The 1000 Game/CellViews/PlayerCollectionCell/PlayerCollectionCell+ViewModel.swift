//
//  PlayerCollectionCell+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.11.2023.
//

import UIKit
import Combine

extension PlayerCollectionCell {
    final class ViewModel {
        
        var cancellables: Set<AnyCancellable> = []
        
        let winGamesLabelVM = BasicLabel.ViewModel(isHidden: true)
        let emojiLabelVM = BasicLabel.ViewModel()
        let nameLabelVM = BasicLabel.ViewModel()
        let pointsLabelVM = BasicLabel.ViewModel()
        
        var player: Player? {
            didSet {
                guard let player else { return }
                self.emojiLabelVM.textValue = .text(player.emoji)
                self.nameLabelVM.textValue = .text(player.name)
                self.pointsLabelVM.textValue = .text(player.points.toString())
                
                self.winGamesLabelVM.textValue = .text(player.winGames.toString())
            }
        }
        
        init() {}
    }
}
