//
//  RoolsCheck.swift
//  The 1000 Game
//
//  Created by Sanchez on 31.10.2023.
//

import Foundation

struct RoolsCheck {
    
    func checkMinusPoints(player: Player) {
        if player.points < 0 {
            player.points = 0
        }
    }
    
    func openGameCheck(player: Player) {
        if player.points >= 50 {
            player.gameOpen = true
            player.gameOpenCounter += 1
        } else if player.gameOpen == false {
            player.points = 0
        }
    }
    
    func yamaCheckAfterTurn(player: Player) {
        let overalPoints = player.points + player.currentPoints
        if overalPoints >= 200, overalPoints < 300 || overalPoints >= 600, overalPoints < 700 {
            player.isItInYama = true
            player.turnsInYamaCounter += 1
        } else {
            player.isItInYama = false
            player.turnsInYamaCounter = 0
        }
    }
    
    func yamaCheckBeforeTurn(player: Player) {
        if player.points >= 200, player.points < 300 || player.points >= 600, player.points < 700 {
            player.isItInYama = true
            if player.turnsInYamaCounter == 0 {
                player.turnsInYamaCounter = 1
            }
        } else {
            player.isItInYama = false
            player.turnsInYamaCounter = 0
        }
    }
    
    func samosvalCheck(player: Player) {
        if player.points == 555 {
            player.isSamosvalCrash = true
            player.points = 0
        } else {
            player.isSamosvalCrash = false
        }
    }
    
    func boltsCheck(player: Player) {
        if player.gameOpen, player.currentPoints == 0 {
            player.bolts += 1
        }
        if player.gameOpen, player.bolts == 3 {
            player.points -= 100
            player.bolts = 0
            player.isBoltsCrash = true
        }
    }
    
    func overtakeMinus(player: Player) {
        if player.wasOvertaken {
            player.points -= 50
        }
    }
    
    func winCheck(player: Player) {
        if player.points >= 1000 {
            player.winStatus = true
        }
    }
    
    
    
}