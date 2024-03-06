//
//  MainGameControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import Foundation
import UIKit

final class MainGameControllerModel: Combinable {
    
    let nameLabelVM = BasicLabel.ViewModel()
    let pointsLabelVM = BasicLabel.ViewModel()
    
    let currentActionInfoLabelVM = BasicLabel.ViewModel()
    
    let endOfTurnButtonVM = BasicButton.ViewModel(title: AppLanguage.vcMainGameEndOfTurnButton.localized)
    
    var players: [Player] = []
    var currentPlayer: Player {
        return players[1]
    }
    
    override init() {
        super.init()
        updatePlayersArray()
    }
    
    private func updatePlayersArray() {
        players = RealmManager().read()
        
        let amountOfPlayers = UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault
        if players.count < amountOfPlayers {
            for _ in 1...amountOfPlayers - players.count {
                let uniqID = BasicMechanics().getUniqPlayerID(players: players)
                let player: Player = .init(
                    name: AppLanguage.playerDefaultName.localized(uniqID.toString()),
                    numberID: uniqID,
                    positionNumber: players.count,
                    emoji: BasicMechanics().getUniqEmoji(players: players)
                )
                RealmManager().write(player)
                players.append(player)
            }
        }
        
        UserManager.read(key: .randomOrderPlayers) ?
        players.shuffle() :
        players.sort( by: {$0.positionNumber < $1.positionNumber} )
        
        guard let lastPlayer = players.last else { return }
        players.removeLast()
        players.insert(lastPlayer, at: 0)
        
        Testing().playersStats(players: players)
    }
    
    func updatePlayersOrder() {
        guard let firstPlayer = players.first else { return }
        players.remove(at: 0)
        players.append(firstPlayer)
    }
    
    func actionsBeforeTurn() {
        RoolsCheck().samosvalCheck(player: currentPlayer)
        RoolsCheck().yamaCheckBeforeTurn(player: currentPlayer)
        
        nameLabelVM.textValue = .text("\(currentPlayer.name)")
        pointsLabelVM.textValue = .text(currentPlayer.points.toString())
        
        currentActionInfoLabelVM.textValue = .text(AppLanguage.vcMainGameCurrentActionInfoLabelDice.localized)
        currentPointsLabelVM.textValue = .text("")
        
        // инициализация позиции и обновление обгона
        currentPlayer.addChangesPointInHistory(forPoint: .beforeTurn)
        currentPlayer.addChangesActionInHistory(forPoint: .beforeTurn)
        
        // обновление истории очков (в случае обгона)
        currentPlayer.addPointsInHistory(forPoint: .overtake)
    }
    
    func actionsAfterRoll() {
        var commonText = ""
        if currentPlayer.currentPoints == 0 {
            commonText = BasicMechanics().getRandomFailFrase()
            currentActionInfoLabelVM.textValue = .text(commonText)
        } else {
            commonText = AppLanguage.vcMainGameCurrentActionInfoLabelPoints.localized + "   " + currentPlayer.currentPoints.toString()
            
            let attributedString = NSMutableAttributedString(string: commonText)
            if let range = commonText.range(of: ":") {
                // Применяем разные стили к разным частям текста
                attributedString.addAttribute(.font,
                                              value: UIFont(name: "robotrondotmatrix", size: 20)!,
                                              range: NSRange(location: 0, length: range.lowerBound.utf16Offset(in: commonText)))
                attributedString.addAttribute(.font,
                                              value: UIFont(name: "AlfaSlabOne-Regular", size: 20)!,
                                              range: NSRange(location: range.lowerBound.utf16Offset(in: commonText) + 1, length: commonText.count - range.lowerBound.utf16Offset(in: commonText) - 1))
            }
            currentActionInfoLabelVM.textValue = .attributed(attributedString)
        }
        
        if currentPlayer.isBoltsCrash {
            pointsLabelVM.textValue = .text(currentPlayer.points.toString())
        }
        
        currentPlayer.addChangesActionInHistory(forPoint: .afterRoll)
        currentPlayer.addChangesPointInHistory(forPoint: .afterRoll)
    }
    
    func actionsAfterTurn() {
        // проверка в яме ли игрок - суммирование полученых за ход очков
        RoolsCheck().yamaCheckAfterTurn(player: currentPlayer)
        
        // проверка открылась ли игра после завершения хода по общему количеству очков
        RoolsCheck().openGameCheck(player: currentPlayer)
        
        if currentPlayer.turnsInYamaCounter <= 1, currentPlayer.gameOpened {
            currentPlayer.points += currentPlayer.currentPoints
        }
        
        // проверка на самосвал
        RoolsCheck().samosvalCheck(player: currentPlayer)
        
        // добавление истории очков
        currentPlayer.addPointsInHistory(forPoint: .other)
        currentPlayer.addChangesPointInHistory(forPoint: .afterTurn)
        currentPlayer.addChangesActionInHistory(forPoint: .afterTurn)
        
        
        // сброс показателей к стандартным после хода
        currentPlayer.updateStatsAfterTurn()
        
        // проверка на победителя
        RoolsCheck().winCheck(player: currentPlayer, playersArray: players)
    }
    
    
    func roll() {
        currentPlayer.lastAmountOfCubes = currentPlayer.amountOfCubes
        currentPlayer.curentRoll = BasicMechanics().diceRoll(cubesAmount: currentPlayer.amountOfCubes)
        
        let currentPlayerResults = BasicMechanics().getResult(cubeDigits: currentPlayer.curentRoll)
        
        // проверка есть ли положительные кубы
        if !currentPlayerResults.plusCubesArray.isEmpty {
            currentPlayer.currentPoints += currentPlayerResults.points
            // проверка все ли кубы выкинуты положительно и выставление остаточного кол-ва кубов
            if currentPlayerResults.plusCubesArray.count == currentPlayer.amountOfCubes {
                currentPlayer.amountOfCubes = BasicRools.Constants.cubesAmount
            } else {
                currentPlayer.amountOfCubes = currentPlayerResults.notPlusCubeCount
            }
        } else {
            currentPlayer.turnIsFinish = true
            currentPlayer.currentPoints = 0
        }
        
        checkRoolsAfterSuccesRoll()
    }
    
    func checkRoolsAfterSuccesRoll() {
        RoolsCheck().boltsCheck(player: currentPlayer)
        RoolsCheck().checkMinusPoints(player: currentPlayer)
    }
    
}
