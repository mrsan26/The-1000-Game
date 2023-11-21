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
    
    func setDefaultPlayers() {
        var amountOfPlayers = BasicRools.Constants.playersAmountDefault
        if UserManager.read(key: .amountOfPlayers) ?? 0 > BasicRools.Constants.playersAmountDefault {
            amountOfPlayers = UserManager.read(key: .amountOfPlayers)!
        }
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
    
    func renamePlayer(playerID: Int) {
        let renamingPlayer = players.filter({$0.numberID == playerID})
        guard
            renamingPlayer.count == 1,
            let player = renamingPlayer.first
        else { return }
        
        // ДАЛЬНЕЙШАЯ ДОРАБОТКА
        print(player.name)
    }
    
    func deletePlayer(playerID: Int) {
        let deletingPlayer = players.filter({$0.numberID == playerID})
        guard
            deletingPlayer.count == 1,
            let deletingPlayer = deletingPlayer.first
        else { return }
        
        RealmManager<Player>().delete(object: deletingPlayer)
        updatePlayers()
    }
}
