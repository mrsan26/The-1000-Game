//
//  PlayerPointsCollectionCell.swift
//  The 1000 Game
//
//  Created by Sanchez on 04.04.2024.
//

import Foundation

import UIKit
import SnapKit
import Combine

class PlayerPointsCollectionCell: BasicCellView {
    
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
        
        view.layer.cornerRadius = CGFloat(Int(UIScreen.main.bounds.size.height / 7) / 2)
        return view
    }()
    
    private lazy var pointsLabel = BasicLabel(aligment: .center, font: .AlfaSlabOne, fontSize: 36)
    
    private lazy var nameLabelView = UIView()
    private lazy var nameLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 18)
    
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
    
    override func makeLayout() {
        self.addSubview(contentStack)
        
        mainCircleView.addSubview(circleView)
        circleView.addSubview(pointsLabel)
        contentStack.addArrangedSubview(mainCircleView)
        
        contentStack.addArrangedSubview(nameLabelView)
        nameLabelView.addSubview(nameLabel)
    }
    
    override func makeConstraints() {
        contentStack.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        circleView.snp.updateConstraints { make in
            make.height.width.equalTo(Int(UIScreen.main.bounds.size.height / 7))
            make.centerX.equalToSuperview()
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setPlayer(player: Player, labelColor: UIColor) {
        self.viewModel.player = player
        self.pointsLabel.textColor = labelColor
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
    }
    
}
