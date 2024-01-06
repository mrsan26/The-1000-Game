//
//  BasicPresentController.swift
//  The 1000 Game
//
//  Created by Sanchez on 07.01.2024.
//

import UIKit
import Combine
import SnapKit

class BasicPresentController: UIViewController {
    
    private lazy var topCloseImageView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        return view
    }()
    private lazy var topCloseImage: BasicImgView = {
        let view = BasicImgView(name: .named("top_close_img"), height: 10, width: 80)
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        binding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeBackground()
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
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = mainView.bounds
        gradientLayer.cornerRadius = mainView.layer.cornerRadius
        mainView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lightBackgroundMode() {
        let transparentLayer = CALayer()
        transparentLayer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        transparentLayer.frame = mainView.bounds
        transparentLayer.cornerRadius = mainView.layer.cornerRadius
        mainView.layer.insertSublayer(transparentLayer, at: 1)
    }
    
    private func makeLayout() {
        view.addSubview(topCloseImageView)
        topCloseImageView.addSubview(topCloseImage)
        view.addSubview(mainView)
    }
    
    private func makeConstraints() {
        topCloseImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        topCloseImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(topCloseImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func binding() {}
    
    @objc private func closeAction() {
        dismiss(animated: true)
        Vibration.viewTap.vibrate()
    }
}
