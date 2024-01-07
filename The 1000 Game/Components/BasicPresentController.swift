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
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
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
        gradientLayer.frame = backView.bounds
        gradientLayer.cornerRadius = backView.layer.cornerRadius
        backView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lightBackgroundMode() {
        let transparentLayer = CALayer()
        transparentLayer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        transparentLayer.frame = backView.bounds
        transparentLayer.cornerRadius = backView.layer.cornerRadius
        backView.layer.insertSublayer(transparentLayer, at: 1)
    }
    
    func makeTitle(text: String, fontSize: CGFloat = 30, textColor: UIColor = .white) {
        titleLabel.text = text
        titleLabel.font = UIFont(name: "robotrondotmatrix", size: fontSize)
        titleLabel.textColor = textColor
    }
    
    private func makeLayout() {
        view.addSubview(topCloseImageView)
        topCloseImageView.addSubview(topCloseImage)
        view.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(mainView)
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
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(topCloseImageView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func binding() {}
    
    @objc private func closeAction() {
        dismiss(animated: true)
        Vibration.viewTap.vibrate()
    }
}
