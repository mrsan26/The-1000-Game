//
//  Ext UIViewController.swift
//  The 1000 Game
//
//  Created by Sanchez on 02.12.2023.
//

import UIKit

extension UIViewController {
    func doesObjectExist(index objectIndex: Int, in array: [Any]) -> Bool {
        return objectIndex >= 0 && objectIndex < array.count
    }
}
