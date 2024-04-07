//
//  AppColors.swift
//  The 1000 Game
//
//  Created by Sanchez on 07.04.2024.
//

import UIKit

enum AppColors {
    case red
    case blue
    case yellow
    
    var getColor: UIColor {
        switch self {
        case .red:
            UIColor(red: 0.922, green: 0.294, blue: 0.384, alpha: 1)
        case .blue:
            UIColor(red: 0.227, green: 0.51, blue: 0.969, alpha: 1)
        case .yellow:
            UIColor(red: 0.817, green: 0.801, blue: 0.555, alpha: 1)
        }
    }
}
