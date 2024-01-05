//
//  Yama.swift
//  The 1000 Game
//
//  Created by Sanchez on 05.01.2024.
//

import Foundation

enum Yama {
    case first
    case second
    case none
    
    var name: String? {
        switch self {
        case .first:
            return "Первая"
        case .second:
            return "Вторая"
        case .none:
            return nil
        }
    }
}
