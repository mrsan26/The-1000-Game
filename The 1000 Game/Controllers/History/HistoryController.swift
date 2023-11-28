//
//  HistoryController.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation
import UIKit
import Combine

class HistoryController: UIViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: HistoryControllerModel
    
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
    
    private lazy var nameLabel = BasicLabel(font: .RobotronDot, fontSize: 30)
    
    private lazy var tableTitleView = UIView()
    private lazy var turnNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    private lazy var pointsNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    private lazy var pointsChangesNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    
    private lazy var historyTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<HistoryCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<HistoryCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .white
        table.separatorStyle = .singleLine
        return table
    }()
    
    var player: Player
    
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
    
    init(viewModel: HistoryControllerModel, player: Player) {
        self.viewModel = viewModel
        self.player = player
        self.viewModel.nameLabelVM.textValue = .text(player.name)
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
        mainView.addSubview(nameLabel)
        mainView.addSubview(tableTitleView)
        
        tableTitleView.addSubview(turnNumberLabel)
        tableTitleView.addSubview(pointsNumberLabel)
        tableTitleView.addSubview(pointsChangesNumberLabel)
        
        mainView.addSubview(historyTableView)
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
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(tableTitleView.snp.top).offset(-8)
        }
        
        tableTitleView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(historyTableView.snp.top).offset(-8)
        }
        turnNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        pointsNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        pointsChangesNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        
        historyTableView.snp.makeConstraints { make in
            make.top.equalTo(tableTitleView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    private func binding() {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        
        self.turnNumberLabel.setViewModel(viewModel.turnNumberLabelVM)
        self.pointsNumberLabel.setViewModel(viewModel.pointsNumberLabelVM)
        self.pointsChangesNumberLabel.setViewModel(viewModel.pointsChangesNumberLabelVM)
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
        Vibration.viewTap.vibrate()
    }
}

extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.pointsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<HistoryCellView>.self), for: indexPath)
        guard let historyCell = cell as? BasicTableCell<HistoryCellView> else { return UITableViewCell() }
        
        
        
        historyCell.mainView.setInfo(
            turnNumber: indexPath.row,
            points: player.pointsHistory[indexPath.row],
            changesPoints: player.changesPointsHistory[indexPath.row],
            actions: player.actionsHistory[indexPath.row]
        )
        
        return historyCell
    }
}
