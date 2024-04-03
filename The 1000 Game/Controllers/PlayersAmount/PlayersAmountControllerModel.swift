//
//  PlayersAmountControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

final class PlayersAmountControllerModel: Combinable {
    
    let playerNamesButtonVM = BasicButton.ViewModel(title: AppLanguage.vcPlayersAmountNamesButton.localized)
    
    var players: [Player] = []
    
    override init() {
        super.init()
        updatePlayersArray()
    }
    
    func setPlayersAmount(amount: Int) {
        UserManager.write(value: amount, for: .amountOfPlayers)
        updatePlayersArray()
        setDefaultPlayers()
    }
    
    private func updatePlayersArray() {
        players = RealmManager().read()
    }
    
    private func setDefaultPlayers() {
        let amountOfPlayers = UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault
        if players.count < amountOfPlayers {
            for _ in 1...amountOfPlayers - players.count {
                let uniqID = BasicMechanics().getUniqPlayerID(players: players)
                let player: Player = .init(
                    name: AppLanguage.playerDefaultName.localized(uniqID.toString()),
                    numberID: uniqID,
                    positionNumber: players.count,
                    emoji: BasicMechanics().getUniqEmoji(players: players)
                    )
                RealmManager().write(player)
                players.append(player)
            }
        } else if players.count > amountOfPlayers {
            var playersForDeleting: [Player] = []
            for player in players.reversed() {
                guard players.count - amountOfPlayers > playersForDeleting.count else { break }
                playersForDeleting.append(player)
            }
            RealmManager().deleteAll(objects: playersForDeleting)
        }
        updatePlayersArray()
    }
    
}
