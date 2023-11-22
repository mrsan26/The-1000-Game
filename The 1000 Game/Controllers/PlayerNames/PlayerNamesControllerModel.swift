//
//  PlayerNamesControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import Foundation

final class PlayerNamesControllerModel: Combinable {
    
    let randomOrderLabelVM = BasicLabel.ViewModel(textValue: .text("Случайный порядок игроков"))
    let deleteAllButtonVM = BasicButton.ViewModel(title: "Очистить")
    let randomOrderSwitcherVM = BasicSwitcher.ViewModel(state: UserManager.read(key: .randomOrderPlayers))
    
    var players: [Player] = []
    
    override init() {
        super.init()
        
        updatePlayersArray()
        setDefaultPlayers()
        
        checkSwitherOnInit()
    }
    
    private func checkSwitherOnInit() {
        if randomOrderSwitcherVM.state == true {
            players.shuffle()
        }
        updatePlayersPositionsForRealm()
    }
    
    private func updatePlayersArray() {
        players = RealmManager<Player>().read()
        players.sort( by: {$0.positionNumber < $1.positionNumber} )
    }
    
    private func updatePlayersPositionsForRealm() {
        for (index, player) in players.enumerated() {
            RealmManager().update { realm in
                try? realm.write({
                    player.positionNumber = index
                })
            }
        }
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
                    positionNumber: players.count - 1,
                    emoji: BasicMechanics().getUniqEmoji(players: players)
                    )
                RealmManager().write(player)
                updatePlayersArray()
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
    
    func addPlayer() {
        let uniqID = BasicMechanics().getUniqPlayerID(players: players)
        let player: Player = .init(
            name: "Игрок \(uniqID)",
            numberID: uniqID,
            positionNumber: players.count - 1,
            emoji: BasicMechanics().getUniqEmoji(players: players)
            )
        RealmManager().write(player)
        updatePlayersArray()
    }
    
    func renamePlayer(player: Player) {
        let renamingPlayer = players.filter({$0.numberID == player.numberID})
        guard
            renamingPlayer.count == 1,
            let player = renamingPlayer.first
        else { return }
        
        // ДАЛЬНЕЙШАЯ ДОРАБОТКА
        print(player.name)
    }
    
    func deletePlayer(player: Player) {
        let deletingPlayer = players.filter({$0.numberID == player.numberID})
        guard
            deletingPlayer.count == 1,
            let deletingPlayer = deletingPlayer.first
        else { return }
        
        RealmManager<Player>().delete(object: deletingPlayer)
        
        updatePlayersArray()
        updatePlayersPositionsForRealm()
    }
    
    func deleteAllPlayers() {
        RealmManager().deleteAll(objects: players)
        updatePlayersArray()
    }
    
    func switchPlayers(firstPlayerIndex: Int, secondPlayerIndex: Int) {
        let playerToMove = players[firstPlayerIndex]
        players.remove(at: firstPlayerIndex)
        players.insert(playerToMove, at: secondPlayerIndex)
        
        updatePlayersPositionsForRealm()
    }
    
    func randomOrderSwitcherAction() {
        UserManager.write(value: randomOrderSwitcherVM.state, for: .randomOrderPlayers)
        
        switch randomOrderSwitcherVM.state {
        case true:
            players.shuffle()
        case false:
            players.sort( by: {$0.numberID < $1.numberID})
        }
        updatePlayersPositionsForRealm()
    }
}
