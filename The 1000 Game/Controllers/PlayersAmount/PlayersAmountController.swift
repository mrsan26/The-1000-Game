//
//  PlayersAmountController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import UIKit
import Combine
import SnapKit

class PlayersAmountController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: PlayersAmountControllerModel
    
    private var pickerContent = [2,3,4,5,6,7,8,9,10]
    private lazy var pickerView = UIView()
    private lazy var playersAmountPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    private lazy var pickerSelectorView = BasicView()
    
    private lazy var playerNamesButtonView = UIView()
    private lazy var playerNamesButton = BasicButton(style: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Игроки"
        
        playersAmountPicker.dataSource = self
        playersAmountPicker.delegate = self
        
        setupPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPicker()
    }
    
    init(viewModel: PlayersAmountControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(pickerView)
        pickerView.addSubview(pickerSelectorView)
        pickerView.addSubview(playersAmountPicker)
        self.view.addSubview(playerNamesButtonView)
        playerNamesButtonView.addSubview(playerNamesButton)
    }
    
    override func makeConstraints() {
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(playerNamesButtonView.snp.top)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        pickerSelectorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-18)
        }
        
        playersAmountPicker.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playerNamesButtonView.snp.makeConstraints { make in
            make.top.equalTo(playersAmountPicker.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(self.view.frame.size.height / 6)
        }
        
        playerNamesButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(playerNamesButtonView)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.playerNamesButton.setViewModel(viewModel.playerNamesButtonVM)
        self.viewModel.playerNamesButtonVM.action = { [weak self] in
            let playerNamesVC = PlayerNamesController(viewModel: .init())
            self?.navigationController?.pushViewController(playerNamesVC, animated: true)
            Vibration.button.vibrate()
        }
    }
    
    private func setupPicker() {
        guard let
                playersAmount = UserManager.read(key: .amountOfPlayers),
              playersAmount >= BasicRools.Constants.playersAmountDefault
        else {
            playersAmountPicker.selectRow(0, inComponent: 0, animated: true)
            return
        }
        playersAmountPicker.selectRow(playersAmount - BasicRools.Constants.playersAmountDefault, inComponent: 0, animated: true)
    }

}

extension PlayersAmountController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContent.count
    }
}

extension PlayersAmountController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let basicView = BasicView()
        let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont(name: "AlfaSlabOne-Regular", size: 30)
            label.text = pickerContent[row].toString()
            return label
        }()
        basicView.addSubview(label)
        basicView.snp.makeConstraints { make in
            make.width.equalTo(self.playersAmountPicker.bounds.size.width - 18)
        }

        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setPlayersAmount(amount: pickerContent[row])
    }
}
