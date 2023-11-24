//
//  MainGameControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import Foundation

final class MainGameControllerModel: Combinable {
    
    let nameLabelVM = BasicLabel.ViewModel(textValue: .text("Игрок"))
    let pointsLabelVM = BasicLabel.ViewModel(textValue: .text("1000"))
    
    let currentActionInfoLabelVM = BasicLabel.ViewModel(textValue: .text("Бросайте кубики"))
    let currentPointsLabelVM = BasicLabel.ViewModel(textValue: .text("150"))
    
    let endOfTurnButtonVM = BasicButton.ViewModel(title: "Конец хода")
    
    var players: [Player] = []
    var whoIsTurnIndex = 1
    
    override init() {
        super.init()
        
        
    }
    
//    private func testingMainAlgorithm() {
//        var randomNumbers = [Int]()
//        for _ in 1...6 {
//            randomNumbers.append(Int.random(in: 1...6))
//        }
//        print(randomNumbers)
//        print(BasicMechanics().getResult(cubeDigits: randomNumbers).points)
//    }
    
    private func checkRoolsBeforeTurn() {
        
    }
    
    private func turn() {
        let currentPlayer = players[whoIsTurnIndex]
        guard !currentPlayer.turnIsFinish else {
            print("Turn is finish")
            return
        }
        
        currentPlayer.lastAmountOfCubes = currentPlayer.amountOfCubes
        currentPlayer.curentRoll = BasicMechanics().diceRoll(cubesAmount: currentPlayer.amountOfCubes)
        
        let plusCubesArray = BasicMechanics().getResult(cubeDigits: currentPlayer.curentRoll).plusCubesArray
        // проверка есть ли положительные кубы
        if !plusCubesArray.isEmpty {
            currentPlayer.currentPoints += BasicMechanics().getResult(cubeDigits: currentPlayer.curentRoll).points
            // проверка все ли кубы выкинуты положительно и выставление остаточного кол-ва кубов
            if plusCubesArray.count == currentPlayer.amountOfCubes {
                currentPlayer.amountOfCubes = BasicRools.Constants.cubesAmount
            } else {
                currentPlayer.amountOfCubes = BasicMechanics().getResult(cubeDigits: currentPlayer.curentRoll).notPlusCubeCount
            }
        } else {
            currentPlayer.turnIsFinish = true
            currentPlayer.currentPoints = 0
        }
    }
}
