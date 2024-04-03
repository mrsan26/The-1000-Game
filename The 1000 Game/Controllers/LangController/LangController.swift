//
//  LangController.swift
//  The 1000 Game
//
//  Created by Sanchez on 15.01.2024.
//

import UIKit
import Combine

class LangController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: LangControllerModel
    
    private lazy var langTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<LangCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<LangCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppLanguage.vcLangTitle.localized
    }
    
    init(viewModel: LangControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(langTableView)
    }
    
    override func makeConstraints() {
        langTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func binding() {}
    
    private func changeLanguage() {
        NotificationCenter.default.post(name: Notification.Name("languageChanged"), object: nil)
        title = AppLanguage.vcLangTitle.localized
    }
}

extension LangController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<LangCellView>.self), for: indexPath)
        guard let langCell = cell as? BasicTableCell<LangCellView> else { return UITableViewCell() }
        
        if UserManager.read(key: .language) ?? 0 == indexPath.row {
            langCell.mainView.choosen.toggle()
        }
        
        langCell.mainView.setItemIndex(index: indexPath.row)
        
        langCell.mainView.setInfo(
            langName: languages[indexPath.row].name,
            langEmoji: languages[indexPath.row].emoji
        )
        
        langCell.mainView.chooseClosure = { [weak self] choosenIndex in
            UserManager.write(value: choosenIndex, for: .language)
            for (index, _) in languages.enumerated() where index != choosenIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                guard let notChoosenCell = cell as? BasicTableCell<LangCellView> else { return }
                notChoosenCell.mainView.choosen = false
            }
            self?.changeLanguage()
        }
        
        return langCell
    }
}
