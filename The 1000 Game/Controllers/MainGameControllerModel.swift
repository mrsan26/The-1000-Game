//
//  MainGameControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import Foundation

final class MainGameControllerModel: Combinable {
    
    
    
    override init() {
        super.init()
//        testingMainAlgorithm()
    }
    
    private func testingMainAlgorithm() {
        var randomNumbers = [Int]()
        for _ in 1...6 {
            randomNumbers.append(Int.random(in: 1...6))
        }
        print(randomNumbers)
        print(BasicMechanics().getResult(cubeDigits: randomNumbers).points)
    }
}
