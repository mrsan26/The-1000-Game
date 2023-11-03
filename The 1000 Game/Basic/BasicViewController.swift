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
    
    private func makeBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
          UIColor(red: 0.922, green: 0.294, blue: 0.384, alpha: 1).cgColor,
          UIColor(red: 0.227, green: 0.51, blue: 0.969, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 1, c: 1, d: 0, tx: 0, ty: 0))
        gradientLayer.bounds = self.view.bounds.insetBy(dx: -1*self.view.bounds.size.width, dy: -0.5*self.view.bounds.size.height)
        gradientLayer.position = self.view.center
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func makeLayout() {}
    
    func makeConstraints() {}
    
    func binding() {}
}
