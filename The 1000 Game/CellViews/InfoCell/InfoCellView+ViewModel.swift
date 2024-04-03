//
//  InfoCellViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 03.04.2024.
//

import Foundation

extension InfoCellView {
    final class ViewModel {
        
        let textLabelVM = BasicLabel.ViewModel()
        
        init() {}
        
        func setInfo(labelText: String) {
            textLabelVM.textValue = .text(labelText)
        }
    }
}
