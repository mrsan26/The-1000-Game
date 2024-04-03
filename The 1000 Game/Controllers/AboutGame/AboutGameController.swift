//
//  AboutGameController.swift
//  The 1000 Game
//
//  Created by Sanchez on 03.04.2024.
//

import Foundation
import UIKit

class AboutGameController: BasicViewController {
    
    let viewModel: AboutGameControllerModel
    
    private lazy var menuTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<InfoCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<InfoCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .clear
        return table
    }()
    
    private var menuItems: [AboutGame] = [.termsOfUse, .privacy, .contacts, .version]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        title = AppLanguage.vcAboutGameTitle.localized
    }
    
    init(viewModel: AboutGameControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        view.addSubview(menuTableView)
    }
    
    override func makeConstraints() {
        menuTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func binding() {}
}

extension AboutGameController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<InfoCellView>.self), for: indexPath)
        guard let infoCell = cell as? BasicTableCell<InfoCellView> else { return UITableViewCell() }
        
        infoCell.mainView.setInfo(menuItems[indexPath.row])
        infoCell.mainView.touchClosure = { [weak self] info in
            guard let info = info as? AboutGame else { return }
            switch info {
            case .termsOfUse:
                let playersVC = PlayersAmountController(viewModel: .init())
                self?.navigationController?.pushViewController(playersVC, animated: true)
            case .privacy:
                let playersVC = PlayersAmountController(viewModel: .init())
                self?.navigationController?.pushViewController(playersVC, animated: true)
            case .contacts:
                let playersVC = PlayersAmountController(viewModel: .init())
                self?.navigationController?.pushViewController(playersVC, animated: true)
            case .version:
                let playersVC = PlayersAmountController(viewModel: .init())
                self?.navigationController?.pushViewController(playersVC, animated: true)
            }
            Vibration.viewTap.vibrate()
        }
        
        return infoCell
    }
}

