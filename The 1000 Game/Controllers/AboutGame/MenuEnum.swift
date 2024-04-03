//
//  MenuEnum.swift
//  The 1000 Game
//
//  Created by Sanchez on 04.04.2024.
//

import UIKit

enum AboutGame: SettableInfo {
    case termsOfUse
    case privacy
    case contacts
    case version
    
    private var version: String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        } else {
            return ""
        }
    }
    
    var img: UIImage {
        switch self {
        case .termsOfUse:
            UIImage(named: "privacy_img")!
        case .privacy:
            UIImage(named: "privacy_img")!
        case .contacts:
            UIImage(named: "privacy_img")!
        case .version:
            UIImage(named: "privacy_img")!
        }
    }
    
    var text: String {
        switch self {
        case .termsOfUse:
            AppLanguage.vcAboutGameTermsOfUseLabel.localized
        case .privacy:
            AppLanguage.vcAboutGamePrivacyLabel.localized
        case .contacts:
            AppLanguage.vcAboutGameContactsLabel.localized
        case .version:
            "\(AppLanguage.vcAboutGameVersionLabel.localized) \(version)"
        }
    }
    
    var chevron: UIImage? {
        switch self {
        case .termsOfUse:
            UIImage(named: "right_schevron")
        case .privacy:
            UIImage(named: "right_schevron")
        case .contacts:
            UIImage(named: "right_schevron")
        case .version:
            nil
        }
    }
}
