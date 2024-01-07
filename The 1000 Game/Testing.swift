//
//  Testing.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.12.2023.
//

import Foundation

struct Testing {
    
    // Настройка и применение
    func playersStats(players: [Player]) {
        set(mode: .off,
            players: players,
            gameOpen: .all,
            points: .firstAndSecond(800, 900),
            readyToOvertake: .off)
    }
    
    // Внутрянка
    func set(mode: IsUsed,
                      players: [Player],
                      gameOpen: GameOpen,
                      points: Points,
                      readyToOvertake: Overtake) {
        
        guard mode == .on else { return }
        guard doesObjectExist(index: 1, in: players) else {
            print("Error: there is no player with index 1")
            return
        }
        guard doesObjectExist(index: 0, in: players) else {
            print("Error: there is no player with index 0")
            return
        }
        
        switch gameOpen {
        case .all:
            players.forEach { player in
                player.gameOpened = true
                player.firstGameOpening = true
            }
        case .first:
            players[1].gameOpened = true
            players[1].firstGameOpening = true
        case .firstAndSecond:
            players[1].gameOpened = true
            players[1].firstGameOpening = true
            players[0].gameOpened = true
            players[0].firstGameOpening = true
        }
        
        switch points {
        case .all(let points):
            players.forEach { player in
                player.points = points
            }
        case .first(let points):
            players[1].points = points
        case .firstAndSecond(let pointsFirst, let pointsSecond):
            players[1].points = pointsFirst
            players[0].points = pointsSecond
        case .playerIndex(let index, let points):
            guard doesObjectExist(index: index, in: players) else { return }
            players[index].points = points
        }
        
        switch readyToOvertake {
        case .on(let overtakeYama):
            switch overtakeYama {
            case .fallInYama:
                players[0].points = 305
                players[1].points = 295
                players[1].isItInYama = .first
                players[1].turnsInYamaCounter = 2
            case .off:
                players[0].points = 500
                players[1].points = 495
                players[0].gameOpened = true
                players[1].gameOpened = true
            }
        case .off:
            break
        }
        
    }
}

enum IsUsed {
    case on
    case off
}

enum GameOpen {
    case all
    case first
    case firstAndSecond
}

enum Points {
    case all (Int)
    case first (Int)
    case firstAndSecond (Int, Int)
    case playerIndex (Int, Int)
}

enum Overtake {
    case on (OvertakeYama)
    case off
}

enum OvertakeYama {
    case fallInYama
    case off
}
