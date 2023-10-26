//
//  BasicButton+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import Foundation

extension BasicButton {
    final class ViewModel: Combinable {
        @Published var isEnabled: Bool = true
        @Published var title: TextValue
        
        var action: Completion?
        
        init(title: TextValue) {
            self.title = title
        }
    }
}
