//
//  PlayerNamesController.swift
//  The 1000 Game
//
//  Created by Sanchez on 20.11.2023.
//

import UIKit
import Combine

class PlayerNamesController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: PlayerNamesControllerModel
    
    private lazy var randomOrderToogleView = BasicView()
    private lazy var randomOrderLabel = BasicLabel(font: .RobotronDot, fontSize: 16)
    private lazy var randomOrderSwitcher = BasicSwitcher()
    
    private lazy var playersTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<PlayerCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<PlayerCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .clear
        return table
    }()
    
    private lazy var buttonView = UIView()
    private lazy var deleteAllButton = BasicButton(style: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if viewModel.players.count < BasicRools.Constants.playersAmountDefault {
            viewModel.setDefaultPlayers()
        }
        UserManager.write(value: viewModel.players.count, for: .amountOfPlayers)
    }
    
    init(viewModel: PlayerNamesControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavBar() {
        let mainView = UIView()
        let plusLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "+"
            label.font = UIFont(name: "AlfaSlabOne-Regular", size: 40)
            return label
        }()
        mainView.addSubview(plusLabel)
        plusLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusPlayerAction)))
        
        let plusButton = UIBarButtonItem(customView: mainView)
        navigationItem.rightBarButtonItem = plusButton
        
        title = "Имена"
    }
    
    @objc private func plusPlayerAction() {
        self.viewModel.addPlayer()
        playersTableView.insertRows(at: [IndexPath(row: self.viewModel.players.count - 1, section: 0)], with: .fade)
    }
    
    override func makeLayout() {
        self.view.addSubview(randomOrderToogleView)
        randomOrderToogleView.addSubview(randomOrderLabel)
        randomOrderToogleView.addSubview(randomOrderSwitcher)
        self.view.addSubview(playersTableView)
        self.view.addSubview(buttonView)
        buttonView.addSubview(deleteAllButton)
    }
    
    override func makeConstraints() {
        randomOrderToogleView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-12)
        }
        
        randomOrderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(randomOrderSwitcher.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        randomOrderSwitcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        playersTableView.snp.makeConstraints { make in
            make.top.equalTo(randomOrderToogleView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(buttonView.snp.top)
        }
        
        buttonView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(playersTableView.snp.bottom)
            make.height.equalTo(self.view.frame.size.height / 6)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.randomOrderLabel.setViewModel(viewModel.randomOrderLabelVM)
        self.deleteAllButton.setViewModel(viewModel.deleteAllButtonVM)
        self.viewModel.deleteAllButtonVM.action = { [weak self] in
            self?.viewModel.deleteAllPlayers()
            self?.playersTableView.reloadDataWithAnimation()
        }
        self.randomOrderSwitcher.setViewModel(viewModel.randomOrderSwitcherVM)
    }
}

extension PlayerNamesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<PlayerCellView>.self), for: indexPath)
        
        guard let playerCell = cell as? BasicTableCell<PlayerCellView> else { return UITableViewCell() }
        playerCell.mainView.viewModel.nameLabelVM.textValue = .text(viewModel.players[indexPath.row].name)
        playerCell.mainView.viewModel.player = viewModel.players[indexPath.row]
        
        playerCell.mainView.renamePlayerClosure = { [weak self] player in
            self?.viewModel.renamePlayer(player: player)
        }
        
        playerCell.mainView.deletePlayerClosure = { [weak self] deletedPlayer in
            guard let self else { return }
            for (index, player) in self.viewModel.players.enumerated() where player.numberID == deletedPlayer.numberID {
                self.viewModel.deletePlayer(player: player)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                break
            }
        }
        return playerCell
    }
    
}
