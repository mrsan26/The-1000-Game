//
//  PlayerCollectionCell.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.11.2023.
//

import UIKit
import SnapKit
import Combine

class PlayerCollectionCell: UIView {
    
    var cancellables: Set<AnyCancellable> = []
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var mainCircleView = UIView()
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        return view
    }()
    private lazy var emojiLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 40)
    
    private lazy var nameLabelView = UIView()
    private lazy var nameLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 16)
    
    private lazy var pointsLabelView = UIView()
    private lazy var pointsLabel = BasicLabel(aligment: .center, font: .AlfaSlabOne, fontSize: 16)

    let viewModel = ViewModel()
    
    init() {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        setViewModel(viewModel)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.addSubview(contentStack)
        
        mainCircleView.addSubview(circleView)
        circleView.addSubview(emojiLabel)
        contentStack.addArrangedSubview(mainCircleView)
        
        contentStack.addArrangedSubview(nameLabelView)
        nameLabelView.addSubview(nameLabel)
        contentStack.addArrangedSubview(pointsLabelView)
        pointsLabelView.addSubview(pointsLabel)
    }
    
    private func makeConstraints() {
        contentStack.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
//        circleView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.bottom.equalToSuperview()
//            make.height.width.equalTo(100)
//        }
        
        let labels = [nameLabel, pointsLabel, emojiLabel]
        labels.forEach { label in
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func setPlayer(player: Player) {
        self.viewModel.player = player
    }
    
    func isActive(_ active: Bool) {
        if active {
            circleView.snp.makeConstraints { make in
                make.height.width.equalTo(100)
            }
            circleView.layer.cornerRadius = 50
            emojiLabel.font = UIFont(name: "inter-black", size: 55)
        } else {
            circleView.snp.makeConstraints { make in
                make.height.width.equalTo(80)
            }
            circleView.layer.cornerRadius = 40
            emojiLabel.font = UIFont(name: "inter-black", size: 30)
        }
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.emojiLabel.setViewModel(viewModel.emojiLabelVM)
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
    }
    
}
