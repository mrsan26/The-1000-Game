//
//  LangCellView+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 14.01.2024.
//

import UIKit
import Combine

extension LangCellView {
    final class ViewModel {
        
        let langLabelVM = BasicLabel.ViewModel()
        let emojiLabellVM = BasicLabel.ViewModel()
        
        init() {
        }
        
        func setInfo(langName: String, langEmoji: String) {
            langLabelVM.textValue = .text(langName)
            emojiLabellVM.textValue = .text(langEmoji)
        }
    }
}
