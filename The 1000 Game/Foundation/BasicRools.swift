//
//  BasicRools.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import Foundation

struct BasicRools {
    struct Constants {
        static let playersAmountDefault = 2
        static let cubesAmount = 5
        
        enum PlusCubes {
            case one
            case five
            
            var cubeDigit: Int {
                switch self {
                case .one:
                    return 1
                case .five:
                    return 5
                }
            }
            var points: Int {
                switch self {
                case .one:
                    return 10
                case .five:
                    return 5
                }
            }
        }
        
        enum Street {
            case little
            case big
            
            var combination: [Int] {
                switch self {
                case .little:
                    return [1,2,3,4,5]
                case .big:
                    return [2,3,4,5,6]
                }
            }
            var points: Int {
                switch self {
                case .little:
                    return 125
                case .big:
                    return 250
                }
            }
        }
        
        enum Multiplier: Int {
            case threeCubes
            case fourCubes
            case fiveCubes
            
            var cubesAmount: Int {
                switch self {
                case .threeCubes:
                    return 3
                case .fourCubes:
                    return 4
                case .fiveCubes:
                    return 5
                }
            }
            
            var multiplier: Int {
                switch self {
                case .threeCubes:
                    return 10
                case .fourCubes:
                    return 20
                case .fiveCubes:
                    return 100
                }
            }
        }
        static let multiplierAdditionalForOnePointCube = 10
    }
}

