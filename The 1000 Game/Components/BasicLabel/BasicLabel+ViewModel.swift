//
//  BasicLabel+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import Foundation

extension BasicLabel {
    final class ViewModel: Combinable {
        @Published var textValue: TextValue?
        
        init(textValue: TextValue? = nil) {
            self.textValue = textValue
        }
    }
}
