//
//  Ext String.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import Foundation

extension String {
    func validate(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
