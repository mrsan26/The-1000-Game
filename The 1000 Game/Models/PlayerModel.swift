//
//  PlayerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import RealmSwift

class Player: Object {
    @Persisted var name: String
    @Persisted var numberID: Int
    @Persisted var positionNumber: Int
    @Persisted var emoji: String
    var points: Int = 0
    
    var selected: Bool = false
    
    var currentPoints: Int = 0
    var curentRoll: [Int] = []
    var amountOfCubes: Int = 5
    var lastAmountOfCubes: Int = 5
    var bolts = 0
    var turnsInYamaCounter = 0
    
    var pointsHistory: [Int] = [0]
    var changesPointsHistory: [Int] = [0]
    var actionsHistory: [ActionHistoryPoint] = [.init()]
    
    var winStatus = false
    var turnIsFinish = false
    var isItInYama = false
    var gameOpened = false
    var firstGameOpening = false
    var wasOvertaken = false
    var isBoltsCrash = false
    var isSamosvalCrash = false
    
    convenience init(name: String, numberID: Int, positionNumber: Int, emoji: String) {
        self.init()
        self.name = name
        self.numberID = numberID
        self.positionNumber = positionNumber
        self.emoji = emoji
    }
    
    func addPointsInHistory() {
        pointsHistory.append(points)
    }
    
//    old version
//    func addChangesPointInHistory() {
//        if pointsHistory.count > 1 {
//            changesPointsHistory.append(pointsHistory.last! - pointsHistory[pointsHistory.count - 2])
//        } else {
//            changesPointsHistory.append(points)
//        }
//    }
    
    func addChangesPointInHistory() {
        changesPointsHistory.append(currentPoints)
    }
    
    func addChangesActionInHistory() {
        actionsHistory.append(.init(
            firstGameOpening: firstGameOpening,
            overtaken: wasOvertaken,
            boltsCrash: isBoltsCrash,
            yamaStatus: turnsInYamaCounter > 1,
            samosvalCrash: isSamosvalCrash)
        )
    }
    
    func resetStats() {
        points = 0
        currentPoints = 0
        curentRoll.removeAll()
        amountOfCubes = 5
        lastAmountOfCubes = 5
        bolts = 0
        turnsInYamaCounter = 0
        winStatus = false
        turnIsFinish = false
        isItInYama = false
        gameOpened = false
        firstGameOpening = false
        wasOvertaken = false
        isBoltsCrash = false
        isSamosvalCrash = false
        pointsHistory = [0]
        changesPointsHistory = [0]
        actionsHistory = [.init()]
    }
    
    func updateStatsAfterTurn() {
        currentPoints = 0
        curentRoll.removeAll()
        amountOfCubes = 5
        lastAmountOfCubes = 5
        firstGameOpening = false
        turnIsFinish = false
        isBoltsCrash = false
        wasOvertaken = false
        isSamosvalCrash = false
        
    }
}
