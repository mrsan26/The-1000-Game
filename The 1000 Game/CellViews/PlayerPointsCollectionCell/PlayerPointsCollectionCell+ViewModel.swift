//
//  PlayerPointsCollectionCell+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 04.04.2024.
//

import UIKit
import Combine

extension PlayerPointsCollectionCell {
    final class ViewModel {
        
        var cancellables: Set<AnyCancellable> = []
        
        let nameLabelVM = BasicLabel.ViewModel()
        let pointsLabelVM = BasicLabel.ViewModel()
        
        var player: Player? {
            didSet {
                guard let player else { return }
                self.nameLabelVM.textValue = .text(player.name)
                self.pointsLabelVM.textValue = .text(player.winGames.toString())
            }
        }
        
        init() {}
    }
}
