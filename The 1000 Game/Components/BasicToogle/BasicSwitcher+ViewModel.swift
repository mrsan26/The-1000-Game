//
//  BasicSwitcher+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.11.2023.
//

import Foundation

extension BasicSwitcher {
    final class ViewModel: Combinable {
        @Published var state: Bool
        
        var actionSwitch: VoidBlock?
        
        init(state: Bool) {
            self.state = state
        }
    }
}
