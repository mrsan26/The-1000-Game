//
//  ValidationRules.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import Foundation

enum ValidationRules {
    case without
    case digit
    case characters
    case length(min: Int, max: Int)
    case email
    
    var pattern: String {
        switch self {
        case .without:                      return ""
        case .digit:                        return "^[0-9]{1,100}$"
        case .characters:                   return "^[a-zA-Zа-яА-Я ]{1,100}$"
        case .length(let min, let max):     return "^[a-zA-Zа-яА-Я0-9. ]{\(min),\(max)}$"
        case .email:                        return "^[\\w\\.]+@[\\w-]+\\.+[\\w-]{2,6}$"
        }
    }
}
