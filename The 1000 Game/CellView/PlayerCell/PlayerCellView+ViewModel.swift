//
//  PlayerCellView+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit
import Combine

extension PlayerCellView {
    final class ViewModel {
        let nameLabelVM = BasicLabel.ViewModel()
        let renameLabelVM = BasicLabel.ViewModel(textValue: .text("Редактировать"))
        
        init() {
        }
    }
}
