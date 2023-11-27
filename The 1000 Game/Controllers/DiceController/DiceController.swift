//
//  DiceController.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit
import Combine

class DiceController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: DiceControllerModel
    
    private lazy var diceTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<DieCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<DieCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кубики"
    }
    
    init(viewModel: DiceControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(diceTableView)
    }
    
    override func makeConstraints() {
        diceTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        
    }
}

extension DiceController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diceSkins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<DieCellView>.self), for: indexPath)
        guard let diceCell = cell as? BasicTableCell<DieCellView> else { return UITableViewCell() }
        
        if UserManager.read(key: .dieSkinIndex) ?? 0 == indexPath.row {
            diceCell.mainView.choosen.toggle()
        }
        
        diceCell.mainView.setItemIndex(index: indexPath.row)
        
        diceCell.mainView.setImages(
            firstDieImg: diceSkins[indexPath.row].getDie(number: 1, withColor: .withPointsStandart),
            secondDieImg: diceSkins[indexPath.row].getDie(number: 6, withColor: .withoutPointsStandart)
        )
        
        diceCell.mainView.chooseClosure = { choosenIndex in
            UserManager.write(value: choosenIndex, for: .dieSkinIndex)
            for (index, _) in diceSkins.enumerated() where index != choosenIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                guard let notChoosenCell = cell as? BasicTableCell<DieCellView> else { return }
                notChoosenCell.mainView.choosen = false
            }
            
        }
        
        return diceCell
    }
}
