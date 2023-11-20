//
//  BasicViewController.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import UIKit
import Combine
import SnapKit
import SwiftyButton

class BasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        makeBackground()
        makeLayout()
        makeConstraints()
        binding()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "robotrondotmatrix", size: 30)!
        ]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func makeBackground() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
          UIColor(red: 0.922, green: 0.294, blue: 0.384, alpha: 1).cgColor,
          UIColor(red: 0.227, green: 0.51, blue: 0.969, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func makeLayout() {}
    
    func makeConstraints() {}
    
    func binding() {}
}
