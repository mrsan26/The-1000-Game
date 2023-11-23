//
//  BasicTextField+ViewModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

extension BasicTextField {
    final class ViewModel: Combinable {
        @Published var placeholder: String?
        @Published var text: String?
        
        init(text: String? = nil, placeholder: String? = nil) {
            self.placeholder = placeholder
            self.text = text
        }
    }
}
