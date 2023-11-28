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
    private lazy var randomOrderLabel = BasicLabel(font: .InterBlack, fontSize: 17)
    private lazy var randomOrderSwitcher = BasicSwitcher()
    
    private lazy var playersTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(
            BasicTableCell<PlayerCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<PlayerCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnTableView)))
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
        playersTableView.scrollToRow(at: IndexPath(row: self.viewModel.players.count - 1, section: 0), at: .top, animated: true)
        Vibration.viewTap.vibrate()
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
            make.width.equalTo(49).priority(1000)
        }
        
        playersTableView.snp.makeConstraints { make in
            make.top.equalTo(randomOrderToogleView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
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
            Vibration.button.vibrate()
        }
        
        self.randomOrderSwitcher.setViewModel(viewModel.randomOrderSwitcherVM)
        self.viewModel.randomOrderSwitcherVM.actionSwitch = { [weak self] in
            self?.viewModel.randomOrderSwitcherAction()
            self?.playersTableView.reloadDataWithAnimation()
        }
    }
    
    @objc private func tapOnTableView() {
        guard playersTableView.isEditing else { return }
        playersTableView.isEditing = false
        Vibration.selection.vibrate()
    }
}

extension PlayerNamesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<PlayerCellView>.self), for: indexPath)
        guard let playerCell = cell as? BasicTableCell<PlayerCellView> else { return UITableViewCell() }
        
        playerCell.mainView.setPlayer(player: viewModel.players[indexPath.row])
                
        playerCell.mainView.deletePlayerAction = { [weak self] deletingPlayer in
            guard let self else { return }
            for (index, player) in self.viewModel.players.enumerated() where player.numberID == deletingPlayer.numberID {
                self.viewModel.deletePlayer(player: player)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                break
            }
        }
        
        playerCell.mainView.longPressViewClosure = {
            // gesture of starting editing
            tableView.isEditing = true
        }
        
        playerCell.mainView.tapViewClosure = {
            // gesture of ending editing
            guard tableView.isEditing else { return }
            tableView.isEditing = false
        }
        return playerCell
    }
    
}

extension PlayerNamesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Указываем, какие ячейки можно перемещать
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.switchPlayers(firstPlayerIndex: sourceIndexPath.row, secondPlayerIndex: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
