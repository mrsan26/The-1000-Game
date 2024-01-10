//
//  HistoryCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import UIKit
import SnapKit

class HistoryCellView: BasicCellView {
    
    private lazy var mainContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    private lazy var playerNameLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 18)
    
    private lazy var labelsView = UIView()
    private lazy var turnNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    private lazy var pointsNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    private lazy var pointsChangesNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    
    private lazy var gameOpenedLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var overtakenLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var boltsCrashLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var yamaStatusLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var samosvalCrashLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)

    let viewModel = ViewModel()
    
    init() {
        super.init(frame: .zero)
        setViewModel(viewModel)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.addSubview(mainContentStack)
        
        mainContentStack.addArrangedSubview(playerNameLabel)
        
        labelsView.addSubview(turnNumberLabel)
        labelsView.addSubview(pointsNumberLabel)
        labelsView.addSubview(pointsChangesNumberLabel)
        mainContentStack.addArrangedSubview(labelsView)
        
        mainContentStack.addArrangedSubview(gameOpenedLabel)
        mainContentStack.addArrangedSubview(overtakenLabel)
        mainContentStack.addArrangedSubview(boltsCrashLabel)
        mainContentStack.addArrangedSubview(yamaStatusLabel)
        mainContentStack.addArrangedSubview(samosvalCrashLabel)
    }
    
    override func makeConstraints() {
        mainContentStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview()
        }
        
        turnNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        pointsNumberLabel.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
        }
        
        pointsChangesNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func prepareForReuse() {
        self.viewModel.prepareForReuse()
        self.backgroundColor = .clear
    }
    
    func setInfo(turnNumber: Int, points: Int, changesPoints: Int?, actions: ActionHistoryPoint?, playerName: String? = nil) {
        viewModel.setupLabels(turnNumber: turnNumber, points: points, changesPoints: changesPoints, actions: actions, playerName: playerName)
    }
    
    func chooseStatus(_ value: Bool) {
        value ? backgroundColorChangingAnimate(to: .white.withAlphaComponent(0.3)) : backgroundColorChangingAnimate(to: .clear)
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.playerNameLabel.setViewModel(viewModel.playerNameLabelVM)
        
        self.turnNumberLabel.setViewModel(viewModel.turnNumberLabelVM)
        self.pointsNumberLabel.setViewModel(viewModel.pointsNumberLabelVM)
        self.pointsChangesNumberLabel.setViewModel(viewModel.pointsChangesNumberLabelVM)
        
        self.gameOpenedLabel.setViewModel(viewModel.gameOpenedLabelVM)
        self.overtakenLabel.setViewModel(viewModel.overtakenLabelVM)
        self.boltsCrashLabel.setViewModel(viewModel.boltsCrashLabelVM)
        self.yamaStatusLabel.setViewModel(viewModel.yamaStatusLabelVM)
        self.samosvalCrashLabel.setViewModel(viewModel.samosvalCrashLabelVM)
    }
    
}

