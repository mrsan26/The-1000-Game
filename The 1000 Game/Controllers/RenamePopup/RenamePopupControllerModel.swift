//
//  RenamePopupControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import Foundation

final class RenamePopupControllerModel: Combinable {
    
    let titleLabelVM = BasicLabel.ViewModel(textValue: .text(AppLanguage.vcRenamePopupTitleLabel.localized))
    let textFieldVM = BasicTextField.ViewModel(errorText: AppLanguage.vcRenamePopupErrorText.localized, placeholder: AppLanguage.vcRenamePopupPlaceholder.localized)
    let confirmButtonVM = BasicButton.ViewModel(title: AppLanguage.vcPopupConfirm.localized)
    let cancelButtonVM = BasicButton.ViewModel(title: AppLanguage.vcPopupCancel.localized)
        
    override init() {
        super.init()
    }
    
}
