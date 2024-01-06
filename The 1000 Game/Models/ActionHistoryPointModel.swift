//
//  ActionHistoryPointModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.11.2023.
//

import Foundation

class ActionHistoryPoint {
    var firstGameOpening: Bool
    var overtaken: Bool
    var boltsCrash: Bool
    var yamaStatus: Yama
    var samosvalCrash: Bool
    
    init(firstGameOpening: Bool = false,
         overtaken: Bool = false,
         boltsCrash: Bool = false,
         yamaStatus: Yama = .none,
         samosvalCrash: Bool = false)
    {
        self.firstGameOpening = firstGameOpening
        self.overtaken = overtaken
        self.boltsCrash = boltsCrash
        self.yamaStatus = yamaStatus
        self.samosvalCrash = samosvalCrash
    }
}
