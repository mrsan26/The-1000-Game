//
//  WinPointsController.swift
//  The 1000 Game
//
//  Created by Sanchez on 04.04.2024.
//

import Foundation
import UIKit
import Combine

class WinPointsController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: WinPointsControllerModel
    
    private lazy var mainContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var titleLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 40)
    
    private lazy var playersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = 10 // Минимальный интервал между ячейками
        layout.minimumLineSpacing = 30 // Минимальный вертикальный интервал между ячейками
        let width = (UIScreen.main.bounds.size.width - 24 - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: UIScreen.main.bounds.size.height / 7 + 30) // Размер ячейки
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            BasicCollectionViewCell<PlayerPointsCollectionCell>.self,
            forCellWithReuseIdentifier: String(describing: BasicCollectionViewCell<PlayerPointsCollectionCell>.self)
        )
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    private lazy var continueButton = BasicButton(style: .blue, titleFontSize: 18)
    private lazy var resetButton = BasicButton(style: .red, titleFontSize: 18)
    
    private var resetGameClosure: VoidBlock?
    private var continueGameClosure: VoidBlock?
    
    var colorsForPointsLabel: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addRoolsButtonInNavBar()
    }
    
    init(viewModel: WinPointsControllerModel,
         allPlayers: [Player], 
         resetGameClosure: VoidBlock?,
         continueGameClosure: VoidBlock?) {
        self.viewModel = viewModel
        self.viewModel.allPlayers = allPlayers
        self.resetGameClosure = resetGameClosure
        self.continueGameClosure = continueGameClosure
        super.init()
        self.getLabelColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavBar() {
        title = "1000"
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.25)
        shadow.shadowOffset = CGSize(width: 0, height: 4)
        shadow.shadowBlurRadius = 4
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "AlfaSlabOne-Regular", size: 20)!,
            .shadow: shadow
        ]
    }
    
    @objc private func backAction() {
        ConfirmPopupController.show(titleText: AppLanguage.vcMainGameConfirmPopupTitle.localized, position: .center) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        Vibration.viewTap.vibrate()
    }
    
    override func makeLayout() {
        self.view.addSubview(mainContentStack)
        mainContentStack.addArrangedSubview(titleLabel)
        mainContentStack.addArrangedSubview(playersCollection)
        mainContentStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(resetButton)
        buttonsStack.addArrangedSubview(continueButton)
    }
    
    override func makeConstraints() {
        mainContentStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(6)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-6)
        }
        
        playersCollection.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.size.height / 1.5)
            make.width.equalToSuperview()
        }
    }
    
    override func binding() {
        self.titleLabel.setViewModel(viewModel.titleLabelVM)
        self.resetButton.setViewModel(viewModel.resetButtonVM)
        self.viewModel.resetButtonVM.action = { [weak self] in
            guard let self else { return }
            ConfirmPopupController.show(titleText: AppLanguage.vcWinNewGamePopup.localized, 
                                        position: .center) { [weak self] in
                guard let self,
                      let mainGameVC = self.navigationController?.viewControllers[1] else { return }
                self.resetGameClosure?()
                self.navigationController?.popToViewController(mainGameVC, animated: true)
                
            }
        }
        self.continueButton.setViewModel(viewModel.continueButtonVM)
        self.viewModel.continueButtonVM.action = { [weak self] in
            guard let self else { return }
            self.continueGameClosure?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func getLabelColors() {
        var allColors: [UIColor] = [AppColors.red.getColor,
                                        AppColors.blue.getColor,
                                        .white]
        var colorCounter = 0
        for _ in viewModel.allPlayers {
            colorsForPointsLabel.append(allColors[colorCounter])
            colorCounter += 1
            if colorCounter > 2 {
                colorCounter = 0
            }
        }
    }
}


extension WinPointsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allPlayers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let playerCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BasicCollectionViewCell<PlayerPointsCollectionCell>.self),
            for: indexPath
        ) as? BasicCollectionViewCell<PlayerPointsCollectionCell> else { return .init() }
        
        playerCell.mainView.setPlayer(player: viewModel.allPlayers[indexPath.row],
                                      labelColor: colorsForPointsLabel[indexPath.row])
        
        return playerCell
    }
}
