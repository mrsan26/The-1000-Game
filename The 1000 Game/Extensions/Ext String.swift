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
    
    var localized: String {
        let selectedLanguage = Languages(rawValue: UserManager.read(key: .language) ?? 0)?.langSystemName ?? "ru"
        
        guard let path = Bundle.main.path(forResource: selectedLanguage.lowercased(), ofType: "lproj"),
              let bundle = Bundle(path: path)
        else { return self }
        let localizedText = bundle.localizedString(forKey: self, value: "", table: nil)
        return localizedText
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
