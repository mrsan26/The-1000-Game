//
//  HistoryCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import UIKit
import SnapKit

class HistoryCellView: UIView {
    
    private lazy var mainContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    private lazy var labelsView = UIView()
    private lazy var turnNumberLabel = BasicLabel(color: .systemBlue, font: .InterBlack, fontSize: 16)
    private lazy var pointsNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    private lazy var pointsChangesNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    
    private lazy var gameOpenedLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var overtakenLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var boltsCrashLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var yamaStatusLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)
    private lazy var samosvalCrashLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 16)

    let viewModel = ViewModel()
    
    init() {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        setViewModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.addSubview(mainContentStack)
        
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
    
    private func makeConstraints() {        
        mainContentStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.bottom.equalToSuperview()
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
    
    func setInfo(turnNumber: Int, points: Int, changesPoints: Int, actions: ActionHistoryPoint) {
        viewModel.setupLabels(turnNumber: turnNumber, points: points, changesPoints: changesPoints, actions: actions)
    }
    
    func setViewModel(_ viewModel: ViewModel) {
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

