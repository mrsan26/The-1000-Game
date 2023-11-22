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
    
    weak var viewModel: ViewModel?
    
    init() {
        super.init(frame: .zero)
        self.onTintColor = .systemPink
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(changeState), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func changeState() {
        viewModel?.state = self.isOn
        viewModel?.actionSwitch?()
    }
    
    func setViewModel(_ vm: ViewModel) {
        cancellables.removeAll()
        self.viewModel = vm
        
        vm.$state.sink(receiveValue: { switherState in
            self.isOn = switherState
        })
        .store(in: &cancellables)
        
    }
    
}
