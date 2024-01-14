//
//  Languages.swift
//  The 1000 Game
//
//  Created by Sanchez on 15.01.2024.
//

import Foundation

enum Languages {
    case rus
    case eng
    
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
}

let languages: [Languages] = [.rus, .eng]
