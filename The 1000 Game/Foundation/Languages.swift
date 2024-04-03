//
//  Languages.swift
//  The 1000 Game
//
//  Created by Sanchez on 15.01.2024.
//

import Foundation

enum Languages: Int {
    case rus = 0
    case eng = 1
    
    var name: String {
        switch self {
        case .rus:
            return "Русский"
        case .eng:
            return "English"
        }
    }
    
    var emoji: String {
        switch self {
        case .rus:
            return "🇷🇺"
        case .eng:
            return "🇬🇧"
        }
    }
    
    var langSystemName: String {
        switch self {
        case .rus:
            return "ru"
        case .eng:
            return "en"
        }
    }
}

let languages: [Languages] = [.rus, .eng]
