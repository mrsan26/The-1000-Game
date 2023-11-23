//
//  DiceSkins.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit

enum DiceSkins {
    case system
    case standart
    
    var firstDieSkin: UIImage {
        switch self {
        case .system:
            return UIImage(systemName: "die.face.1.fill")!
        case .standart:
            return UIImage(systemName: "die.face.1")!
        }
    }
    
    var sixDieSkin: UIImage {
        switch self {
        case .system:
            return UIImage(systemName: "die.face.6.fill")!
        case .standart:
            return UIImage(systemName: "die.face.6")!
        }
    }
}

var diceSkins: [DieModel] = [.init(skin: .system), .init(skin: .standart)]
