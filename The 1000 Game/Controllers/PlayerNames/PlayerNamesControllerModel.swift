//
//  PlayerNamesControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import Foundation

final class PlayerNamesControllerModel: Combinable {
    
    let randomOrderLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcPlayerNamesRandomOrderLabel.localized))
    let deleteAllButtonVM = BasicButton.ViewModel(title: AppLanguage.vcPlayerNamesClearButton.localized)
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
    
    func updatePlayersArray() {
        players = RealmManager<Player>().read()
        players.sort( by: {$0.positionNumber < $1.positionNumber} )
    }
    
    func updatePlayersPositionsForRealm() {
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
    
    func addPlayer() {
        let uniqID = BasicMechanics().getUniqPlayerID(players: players)
        let player: Player = .init(
            name: AppLanguage.playerDefaultName.localized(uniqID.toString()),
            numberID: uniqID,
            positionNumber: players.count - 1,
            emoji: BasicMechanics().getUniqEmoji(players: players)
            )
        RealmManager().write(player)
        updatePlayersArray()
    }
    
    func deletePlayer(player: Player) {
        RealmManager<Player>().delete(object: player)

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
