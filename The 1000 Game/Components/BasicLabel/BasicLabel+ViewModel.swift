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
        @Published var isHidden: Bool?
        
        init(textValue: TextValue? = nil, isHidden: Bool? = nil) {
            self.textValue = textValue
            self.isHidden = isHidden
        }
        
        
    }
}
