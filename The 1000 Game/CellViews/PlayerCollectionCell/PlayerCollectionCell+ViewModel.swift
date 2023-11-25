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
        
        let emojiLabelVM = BasicLabel.ViewModel()
        let nameLabelVM = BasicLabel.ViewModel()
        let pointsLabelVM = BasicLabel.ViewModel()
        
        @Published var player: Player?
        
        init() {
            binding()
        }
        
        private func binding() {
            self.$player.sink { [weak self] player in
                guard let player,
                      let self
                else { return }
                self.emojiLabelVM.textValue = .text(player.emoji)
                self.nameLabelVM.textValue = .text(player.name)
                self.pointsLabelVM.textValue = .text(player.points.toString())
            }
            .store(in: &cancellables)
        }
    }
}
