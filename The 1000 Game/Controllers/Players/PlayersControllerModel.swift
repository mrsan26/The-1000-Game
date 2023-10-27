//
//  PlayersControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

final class PlayersControllerModel: Combinable {
    
    let playerNameInputVM = BasicTextField.ViewModel(placeholder: "Имя нового игрока")
    
    override init() {
        super.init()
        
    }
    
    
}
