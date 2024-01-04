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
    var changesPointsHistory: [Int] = []
    var actionsHistory: [ActionHistoryPoint] = []
    
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
    
    func addPointsInHistory(forPoint: ChangesInHistoryPoint) {
        switch forPoint {
        case .overtake:
            guard wasOvertaken else { return }
            pointsHistory[pointsHistory.count - 1] = points
        case .other:
            pointsHistory.append(points)
        }
    }
    
    func addChangesPointInHistory(forPoint: ActionsChangesInHistoryPoint) {
        switch forPoint {
        case .beforeTurn:
            changesPointsHistory.append(0)
            guard wasOvertaken else { return }
            print(changesPointsHistory.last!)
            changesPointsHistory[changesPointsHistory.count - 2] -= 50
        case .afterRoll:
            var changes = currentPoints
            if isBoltsCrash {
                changes -= 100
            }
            changesPointsHistory[changesPointsHistory.count - 1] = changes
        case .afterTurn:
            guard isSamosvalCrash else { return }
            changesPointsHistory[changesPointsHistory.count - 1] -= 555
        }
    }
    
    func addChangesActionInHistory(forPoint: ActionsChangesInHistoryPoint) {
        switch forPoint {
        case .beforeTurn:
            actionsHistory.append(.init())
            actionsHistory[actionsHistory.count - 1].overtaken = wasOvertaken
            actionsHistory[actionsHistory.count - 1].yamaStatus = isItInYama
        case .afterRoll:
            actionsHistory[actionsHistory.count - 1].boltsCrash = isBoltsCrash
        case .afterTurn:
            actionsHistory[actionsHistory.count - 1].firstGameOpening = firstGameOpening
            actionsHistory[actionsHistory.count - 1].samosvalCrash = isSamosvalCrash
        }
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

enum ChangesInHistoryPoint {
    case overtake
    case other
}

enum ActionsChangesInHistoryPoint {
    case beforeTurn
    case afterRoll
    case afterTurn
//    case overtake
}
