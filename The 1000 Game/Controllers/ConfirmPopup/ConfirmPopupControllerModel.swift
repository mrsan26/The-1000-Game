//
//  ConfirmPopupControllerModel.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation

final class ConfirmPopupControllerModel: Combinable {
    
    let titleLabelVM = BasicLabel.ViewModel()
    let confirmButtonVM = BasicButton.ViewModel(title: "Да")
    let cancelButtonVM = BasicButton.ViewModel(title: "Отмена")
        
    override init() {
        super.init()
    }
    
}

