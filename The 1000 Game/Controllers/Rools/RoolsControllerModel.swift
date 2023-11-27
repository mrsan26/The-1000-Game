//
//  RoolsControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

final class RoolsControllerModel: Combinable {
    
    let titleLabelVM = BasicLabel.ViewModel(textValue: .text("Правила"))
    
    override init() {
        super.init()
    }
}
