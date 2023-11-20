//
//  PlayersAmountControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

final class PlayersAmountControllerModel: Combinable {
    
    let playerNamesButtonVM = BasicButton.ViewModel(title: "Имена")
    
    override init() {
        super.init()
    }
    
    func setPlayersAmount(amount: Int) {
        UserManager.write(value: amount, for: .amountOfPlayers)
    }
    
}
