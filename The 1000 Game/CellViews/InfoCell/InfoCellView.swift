//
//  InfoCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 03.04.2024.
//

import UIKit
import Combine

class InfoCellView: BasicCellView {
    
    var cancellables: Set<AnyCancellable> = []
    
    private var mainView = BasicView(userInteractive: true)
    
    private lazy var infoView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var textLabel = BasicLabel(font: .RobotronDot, fontSize: 17)
    private lazy var сhevronImg = UIImageView()

    let viewModel = ViewModel()
    
    var info: SettableInfo?
    var touchClosure: ((SettableInfo?) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setViewModel(viewModel)
        
        mainView.touchClosure = { [weak self] in
            self?.touchClosure?(self?.info)
        }
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.addSubview(mainView)
        mainView.addSubview(infoView)
        infoView.addSubview(imageView)
        infoView.addSubview(textLabel)
        infoView.addSubview(сhevronImg)
    }
    
    override func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12))
        }
        
        infoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        сhevronImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(17)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalTo(сhevronImg.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
        }
    }
        
    func setInfo(_ info: SettableInfo) {
        self.info = info
        
        self.viewModel.setInfo(labelText: info.text)
        
        imageView.image = info.img
        
        if let image = info.chevron {
            сhevronImg.image = image
        }
    }
    
    private func setViewModel(_ viewModel: ViewModel) {
        textLabel.setViewModel(viewModel.textLabelVM)
    }
}
