//
//  UserManager.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import Foundation

final class UserManager {
    static let userManager = UserDefaults.standard
    
    enum Keys: String, CaseIterable {
        case amountOfPlayers
    }
    
    static func read(key: Keys) -> Bool {
        let value = userManager.object(forKey: key.rawValue) as? Bool ?? false
        return value
    }
    
    static func read(key: Keys) -> Int? {
        let value = userManager.object(forKey: key.rawValue) as? Int
        return value
    }
    
    static func write(value: Bool, for key: Keys) {
        userManager.set(value, forKey: key.rawValue)
    }
    
    static func write(value: Int, for key: Keys) {
        userManager.set(value, forKey: key.rawValue)
    }
    
    static func removeAllSettings() {
        let allCases = Keys.allCases
        allCases.forEach { key in
            userManager.set(nil, forKey: key.rawValue)
        }
    }
}
