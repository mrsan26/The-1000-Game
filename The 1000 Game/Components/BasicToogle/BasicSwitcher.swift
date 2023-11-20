//
//  BasicSwitcher.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.11.2023.
//

import UIKit
import Combine

class BasicSwitcher: UISwitch {
    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(frame: .zero)
        self.onTintColor = .systemPink
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancellables.removeAll()

        vm.$state.sink(receiveValue: { switherState in
            switch switherState {
            case .on:
                self.isSelected = true
            case .off:
                self.isSelected = false
            }
        })
        .store(in: &cancellables)
        
    }
    
}
