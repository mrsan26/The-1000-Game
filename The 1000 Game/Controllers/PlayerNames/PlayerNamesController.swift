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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Имена"
    }
    
    init(viewModel: PlayerNamesControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(randomOrderToogleView)
        randomOrderToogleView.addSubview(randomOrderLabel)
        randomOrderToogleView.addSubview(randomOrderSwitcher)
        self.view.addSubview(playersTableView)
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
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.randomOrderLabel.setViewModel(viewModel.randomOrderLabelVM)
    }
}

extension PlayerNamesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<PlayerCellView>.self), for: indexPath)
        
        guard let newsCell = cell as? BasicTableCell<PlayerCellView> else { return UITableViewCell() }
        newsCell.mainView.viewModel.nameLabelVM.textValue = .text(viewModel.players[indexPath.row].name)
        
        return newsCell
    }
    
}
