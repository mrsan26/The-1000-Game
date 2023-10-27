//
//  PlayerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation

class Player {
    var name: String
    var numberID: Int
    var emoji: String
    var points: Int = 0
    
    var selected: Bool = false
    
    var currentPoints: Int = 0
    var curentRoll: [Int] = []
    var amountOfCubes: Int = 5
    var lastAmountOfCubes: Int = 5
    var bolts = 0
    var turnsInYamaCounter = 0
    var gameOpenID = 0
    
    var pointsHistory: [Int] = [0]
    var changesHistory: [Int] = [0]
    
    var nowIsDisplaying = false
    var winStatus = false
    var allCubesArePlus = false
    var turnIsFinish = false
    var isItInYama = false
    var gameOpen = false
    var wasOvertaken = false
    var isBoltsCrash = false
    var isSamosvalCrash = false
    
    init(name: String, numberID: Int, emoji: String) {
        self.name = name
        self.numberID = numberID
        self.emoji = emoji
    }
}
