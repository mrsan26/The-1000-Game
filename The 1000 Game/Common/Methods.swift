//
//  Methods.swift
//  The 1000 Game
//
//  Created by Sanchez on 30.12.2023.
//

import Foundation

func doesObjectExist(index objectIndex: Int, in array: [Any]) -> Bool {
    return objectIndex >= 0 && objectIndex < array.count
}
