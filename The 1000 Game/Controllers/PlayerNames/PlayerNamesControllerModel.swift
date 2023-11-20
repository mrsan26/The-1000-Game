//
//  PlayerNamesControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import Foundation

final class PlayerNamesControllerModel: Combinable {
    
    let randomOrderLabelVM = BasicLabel.ViewModel(textValue: .text("Случайный порядок игроков"))
    
    var players: [Player] = []
    
    override init() {
        super.init()
        updatePlayers()
        setDefaultPlayers()
    }
    
    private func updatePlayers() {
        players = RealmManager<Player>().read()
    }
    
    private func setDefaultPlayers() {
        let amountOfPlayers = (UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault)
        if players.count < amountOfPlayers {
            for _ in 1...amountOfPlayers - players.count {
                let uniqID = BasicMechanics().getUniqPlayerID(players: players)
                let player: Player = .init(
                    name: "Игрок \(uniqID)",
                    numberID: uniqID,
                    emoji: BasicMechanics().getUniqEmoji(players: players)
                    )
                RealmManager().write(player)
                updatePlayers()
            }
        } else if players.count > amountOfPlayers {
            var playersForDeleting: [Player] = []
            for player in players.reversed() {
                guard players.count - amountOfPlayers > playersForDeleting.count else { break }
                playersForDeleting.append(player)
            }
            RealmManager().deleteAll(objects: playersForDeleting)
        }
        updatePlayers()
    }
}
