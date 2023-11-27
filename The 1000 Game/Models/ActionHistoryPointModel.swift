//
//  ActionHistoryPointModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.11.2023.
//

import Foundation

class ActionHistoryPoint {
    var gameOpened: Bool
    var overtaken: Bool
    var boltsCrash: Bool
    var yamaStatus: Bool
    var samosvalCrash: Bool
    
    init(gameOpened: Bool = false,
         overtaken: Bool = false,
         boltsCrash: Bool = false,
         yamaStatus: Bool = false,
         samosvalCrash: Bool = false)
    {
        self.gameOpened = gameOpened
        self.overtaken = overtaken
        self.boltsCrash = boltsCrash
        self.yamaStatus = yamaStatus
        self.samosvalCrash = samosvalCrash
    }
}
