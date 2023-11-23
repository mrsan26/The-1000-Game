//
//  RenamePopupControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import Foundation

final class RenamePopupControllerModel: Combinable {
    
    let titleLabelVM = BasicLabel.ViewModel(textValue: .text("Переименование Игрока"))
    let textFieldVM = BasicTextField.ViewModel(placeholder: "Введите имя")
    let confirmButtonVM = BasicButton.ViewModel(title: "Ок")
    let cancelButtonVM = BasicButton.ViewModel(title: "Отмена")
        
    override init() {
        super.init()
    }
    
}
