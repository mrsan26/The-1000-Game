//
//  Ext Float.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.12.2023.
//

import Foundation

extension Float {
    func roundForSignsAfterDot(_ signs: Int) -> Float {
        var multiplier: Float = 1
        for _ in 1...signs {
            multiplier *= 10
        }
        return (self * multiplier).rounded() / multiplier
    }
}
