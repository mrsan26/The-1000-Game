//
//  RoolsController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine

class RoolsController: UIViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: RoolsControllerModel
    
    private lazy var topCloseImageView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        return view
    }()
    private lazy var topCloseImage: BasicImgView = {
        let view = BasicImgView(name: .named("top_close_img"), height: 10, width: 80)
        return view
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel = BasicLabel(font: .RobotronDot, fontSize: 30)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
//        view.scrollsToTop
        return view
    }()
    
    private lazy var roolsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "all_rools_ru_img")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        makeLayout()
        makeConstraints()
        binding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBackground()
    }
    
    init(viewModel: RoolsControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
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
    
    private func makeLayout() {
        view.addSubview(topCloseImageView)
        topCloseImageView.addSubview(topCloseImage)
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(scrollView)
        scrollView.addSubview(roolsImageView)
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.top).offset(-8)
        }
        
        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        roolsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(self.view.frame.size.width - 24)
            make.top.bottom.equalToSuperview()
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    private func binding() {
        self.titleLabel.setViewModel(viewModel.titleLabelVM)
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
    }
}
