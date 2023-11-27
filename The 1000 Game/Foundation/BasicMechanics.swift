//
//  BasicMechanics.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import Foundation

struct BasicMechanics {
    
    func getResult(cubeDigits: [Int]) -> (plusCubesArray: [Int], notPlusCubeCount: Int, notRepeatingNumsArray: [Int], points: Int) {
        var points = 0
        var plusCubesArray = [Int]()
        var notPlusCubeCount = BasicRools.Constants.cubesAmount
        var notRepeatingNumsArray = [Int]()
        var repeatingNumOverTwoTimes = 0
        //
        // 1. Проверка наличия повторяющихся значений и определение повторяющегося числа
        // составление массивов с повторяющимися значениями (если есть) - они же автоматически являются выигрышными и неповторяющимися значениями (если нет повторяющихся)
        for num in cubeDigits {
            if cubeDigits.filter({$0 == num}).count > 2 {
                plusCubesArray.append(num)
                repeatingNumOverTwoTimes = num
            } else {
                notRepeatingNumsArray.append(num)
            }
        }
        // проверка есть ли среди неповторяющихся значений - равные выигрышным 1 или 5, добавление в массив с выигрышными если есть
        for item in notRepeatingNumsArray where item == BasicRools.Constants.PlusCubes.one.cubeDigit || item == BasicRools.Constants.PlusCubes.five.cubeDigit {
            plusCubesArray.append(item)
        }
        // проверка стритов и если есть - перезапись массива с выигрышными значениями и запись победных очков
        if cubeDigits.sorted() == BasicRools.Constants.Street.little.combination {
            plusCubesArray = cubeDigits.sorted()
            points = BasicRools.Constants.Street.little.points
        } else if cubeDigits.sorted() == BasicRools.Constants.Street.big.combination {
            plusCubesArray = cubeDigits.sorted()
            points = BasicRools.Constants.Street.big.points
        }
        // подсчет числа непринесших очков кубиков (для последующего переброса)
        notPlusCubeCount = cubeDigits.count - plusCubesArray.count
        
        //
        // 2. Вычисление кол-ва очков
        // если был стрит, дальнейший подсчет не имеет смысла
        guard points == 0 else { return (plusCubesArray, notPlusCubeCount, notRepeatingNumsArray, points) }
        
        var multiplier = 0
        // определения множителя количества очков в зависимости от колличества повторяемых значений
        switch cubeDigits.count - notRepeatingNumsArray.count {
        case BasicRools.Constants.Multiplier.threeCubes.cubesAmount:
            multiplier = BasicRools.Constants.Multiplier.threeCubes.multiplier
            
        case BasicRools.Constants.Multiplier.fourCubes.cubesAmount:
            multiplier = BasicRools.Constants.Multiplier.fourCubes.multiplier
            
        case BasicRools.Constants.Multiplier.fiveCubes.cubesAmount:
            multiplier = BasicRools.Constants.Multiplier.fiveCubes.multiplier
        default:
            break
        }
        // определения кол-ва очков в зависимости от повторяемых чисел
        switch repeatingNumOverTwoTimes {
        case 1:
            points += BasicRools.Constants.multiplierAdditionalForOnePointCube * multiplier
        case 2...6:
            points += repeatingNumOverTwoTimes * multiplier
        default:
            break
        }
        // подсчет 1 и 5
        for item in notRepeatingNumsArray where item == BasicRools.Constants.PlusCubes.one.cubeDigit || item == BasicRools.Constants.PlusCubes.five.cubeDigit {
            item == BasicRools.Constants.PlusCubes.one.cubeDigit ? (points += BasicRools.Constants.PlusCubes.one.points) : (points += BasicRools.Constants.PlusCubes.five.points)
        }
        
        return (plusCubesArray, notPlusCubeCount, notRepeatingNumsArray, points)
    }
    
    func diceRoll(cubesAmount: Int) -> [Int] {
        var dicesArray: [Int] = []
        for _ in 1...cubesAmount {
            dicesArray.append(Int.random(in: 1...6))
        }
        return dicesArray
    }
    
    func getUniqPlayerID(players: [Player]) -> Int {
        guard !players.isEmpty else { return 1 }
        var playersIDs: [Int] = []
        var uniqID = 0
        for player in players {
            playersIDs.append(player.numberID)
        }
        repeat {
            uniqID += 1
        } while playersIDs.contains(uniqID)
        
        return uniqID
    }
    
    func getUniqEmoji(players: [Player]) -> String {
        currentEmojies.removeAll()
        players.forEach { player in
            currentEmojies.append(player.emoji)
        }
        
        var emojies = emojiArray
        for index in stride(from: emojies.count - 1, through: 0, by: -1) {
            let value = emojies[index]
            guard emojies.count > 0 else {
                return emojiArray.randomElement()!
            }
            if currentEmojies.contains(value) {
                emojies.remove(at: index)
            }
        }
        return emojies.randomElement() ?? emojiArray.randomElement()!
    }
}
