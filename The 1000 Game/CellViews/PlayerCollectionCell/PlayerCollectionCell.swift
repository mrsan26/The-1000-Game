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
    private lazy var winGamesLabel = BasicLabel(color: .white.withAlphaComponent(0.8), aligment: .center, font: .InterBlack, fontSize: 190)
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
        circleView.addSubview(winGamesLabel)
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
        
        let labels = [nameLabel, pointsLabel, emojiLabel, winGamesLabel]
        labels.forEach { label in
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func setPlayer(player: Player, winsCounter: Bool = false) {
        self.viewModel.player = player
        self.viewModel.winGamesLabelVM.isHidden = !winsCounter
        if winsCounter {
            emojiLabel.alpha = 0.8
        }
    }
    
    func isActive(_ active: Bool) {
        if active {
            circleView.snp.updateConstraints { make in
                make.height.width.equalTo(Int(UIScreen.main.bounds.size.height / 8))
            }
            circleView.layer.cornerRadius = CGFloat(Int(UIScreen.main.bounds.size.height / 8) / 2)
            emojiLabel.font = UIFont(name: "inter-black", size: 55)
        } else {
            circleView.snp.updateConstraints { make in
                make.height.width.equalTo(Int(UIScreen.main.bounds.size.height / 10))
            }
            circleView.layer.cornerRadius = CGFloat(Int(UIScreen.main.bounds.size.height / 10) / 2)
            emojiLabel.font = UIFont(name: "inter-black", size: 40)
        }
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.winGamesLabel.setViewModel(viewModel.winGamesLabelVM)
        self.emojiLabel.setViewModel(viewModel.emojiLabelVM)
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
    }
    
}
