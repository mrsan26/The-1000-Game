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
    case anime
    case numbers
    
    func getDie(number: Int, withColor: DieColors) -> UIImage {
        guard number > 0, number < 7 else { return UIImage(systemName: "xmark.app.fill")! }
        switch self {
        case .transparent:
            return UIImage(named: "transparent.die.\(number).\(withColor.rawValue)")!
        case .standart:
            return UIImage(named: "default.die.\(number).\(withColor.rawValue)")!
        case .anime:
            return UIImage(named: "anime.die.\(number).\(withColor.rawValue)")!
        case .numbers:
            return UIImage(named: "123456.die.\(number).\(withColor.rawValue)")!
        }
    }
}

//enum DieNumber: Int {
//    case one = 1
//    case two
//    case three
//    case four
//    case five
//    case six
//}

enum DieColors: String {
    case unactive = "unactive"
    case withoutPointsStandart = "withoutPointsStandart"
    case withPointsStandart = "withPointsStandart"
    case withoutPointsInYama = "withoutPointsInYama"
    case withPointsInYama = "withPointsInYama"
}

var diceSkins: [DiceSkins] = [.standart, .transparent, .numbers, .anime]
