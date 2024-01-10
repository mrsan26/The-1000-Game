//
//  RoolsCheck.swift
//  The 1000 Game
//
//  Created by Sanchez on 31.10.2023.
//

import Foundation

struct RoolsCheck {
    
    func checkMinusPoints(player: Player) {
        guard player.points < 0 else { return }
        player.points = 0
    }
    
    func openGameCheck(player: Player) {
        guard !player.gameOpened else { return }
        player.gameOpened = player.currentPoints >= 50
        player.firstGameOpening = player.currentPoints >= 50
    }
    
    func yamaCheckAfterTurn(player: Player) {
        let overalPoints = player.points + player.currentPoints
        switch overalPoints {
        case 200...299:
            player.isItInYama = .first
            player.turnsInYamaCounter += 1
        case 600...699:
            player.turnsInYamaCounter += 1
// проверка необходима на случай если игрок из первой ямы сразу попадает во вторую (набрав много очков)
            if player.isItInYama == .first {
                player.turnsInYamaCounter = 0
            }
            player.isItInYama = .second
        default:
            player.isItInYama = .none
            player.turnsInYamaCounter = 0
        }
    }
    
    func yamaCheckBeforeTurn(player: Player) {
        switch player.points {
        case 200...299:
            player.isItInYama = .first
            if player.turnsInYamaCounter == 0 {
                player.turnsInYamaCounter = 1
            }
        case 600...699:
            player.isItInYama = .second
            if player.turnsInYamaCounter == 0 {
                player.turnsInYamaCounter = 1
            }
        default:
            player.isItInYama = .none
            player.turnsInYamaCounter = 0
        }
    }
    
    func samosvalCheck(player: Player) {
        guard player.points == 555 else { return }
        player.isSamosvalCrash = true
        player.points = 0
    }
    
    func boltsCheck(player: Player) {
        if player.gameOpened, player.currentPoints == 0 {
            player.bolts += 1
        }
        if player.gameOpened, player.bolts == 3 {
            player.points -= 100
            player.bolts = 0
            player.isBoltsCrash = true
        }
    }
    
    func overtakeMinus(player: Player) {
        guard player.wasOvertaken else { return }
        player.points -= 50
    }
    
    func winCheck(player: Player, playersArray: [Player]) {
        guard player.points >= 1000 else { return }
        player.winStatus = true
        if player.winGames + 1 > 9 {
            playersArray.forEach { player in
                player.winGames = 0
            }
        }
        player.winGames += 1
    }
    
    func checkOvertake(currentPlayer: Player, playersArray: [Player]) {
        let overalPoints = currentPlayer.points + currentPlayer.currentPoints
        var isItCurrentPlayerStillInYama = false
        
        // перед проверко на обгон необходимо дополнительно проверять, будет ли текущий игрок все еще в яме - в таком случае обгон засчитываться не будет (тк в яме очки не присваюваются в конце хода)
        if currentPlayer.turnsInYamaCounter >= 1, (200...299).contains(overalPoints) || (600...699).contains(overalPoints) {
            isItCurrentPlayerStillInYama = true
        }
        
        for everyPlayer in playersArray where everyPlayer.numberID != currentPlayer.numberID {
            // проверка обгона должна выполняться СТРОГО ДО суммирования points и currentPoints текущего игрока
            if isItCurrentPlayerStillInYama == false,
                everyPlayer.gameOpened == true,
                currentPlayer.points < everyPlayer.points,
                currentPlayer.points + currentPlayer.currentPoints > everyPlayer.points
            {
                everyPlayer.wasOvertaken = true
                RoolsCheck().overtakeMinus(player: everyPlayer)
                RoolsCheck().checkMinusPoints(player: everyPlayer)
            }
        }
    }
    
}
