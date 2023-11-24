//
//  DiceSkins.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit

enum DiceSkins {
    case transparent
    case standart
    
    func getDie(number: DieNumber, withColor: DieColors) -> UIImage {
        switch self {
        case .transparent:
            return UIImage(named: "transparent.die.\(number.rawValue).\(withColor.rawValue)")!
        case .standart:
            return UIImage(named: "default.die.\(number.rawValue).\(withColor.rawValue)")!
        }
    }
}

enum DieNumber: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
}

enum DieColors: String {
    case unactive = "unactive"
    case withoutPointsStandart = "withoutPointsStandart"
    case withPointsStandart = "withPointsStandart"
    case withoutPointsInYama = "withoutPointsInYama"
    case withPointsInYama = "withPointsInYama"
}

var diceSkins: [DiceSkins] = [.standart, .transparent]
