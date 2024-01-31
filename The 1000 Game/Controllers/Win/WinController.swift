//
//  WinController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine
import SPConfetti

class WinController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: WinControllerModel
    
    private lazy var mainContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var winnerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    private lazy var winWordLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 40)
    private lazy var mainCircleView = UIView()
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnWinnerView)))
        return view
    }()
    private lazy var winGamesLabel = BasicLabel(color: .white.withAlphaComponent(0.8), aligment: .center, font: .InterBlack, fontSize: 190)
    private lazy var winerEmojiLabel: BasicLabel = {
        let label = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 100)
        label.alpha = 0.8
        return label
    }()
//    private lazy var winerEmojiLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 100)
    private lazy var playersInfoLabelsView = UIView()
    private lazy var nameLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 30)
    private lazy var pointsLabel = BasicLabel(aligment: .center, font: .AlfaSlabOne, fontSize: 30)
    
    private lazy var playersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            BasicCollectionViewCell<PlayerCollectionCell>.self,
            forCellWithReuseIdentifier: String(describing: BasicCollectionViewCell<PlayerCollectionCell>.self)
        )
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var resetButtonView = UIView()
    private lazy var statisticButton: BasicButton = {
        let button = BasicButton(style: .blue, titleFontSize: 16)
        button.cornerRadius = 16
        return button
    }()
    private lazy var resetButton = BasicButton(style: .red, titleFontSize: 18)
    
    private var resetGameClosure: VoidBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addRoolsButtonInNavBar()
        self.view.alpha = 0
        self.view.fadeInAnimation { [weak self] _ in
            self?.confettiAnimation()
        }
    }
    
    init(viewModel: WinControllerModel, winnerPlayer: Player, allPlayers: [Player], resetGameClosure: VoidBlock?) {
        self.viewModel = viewModel
        self.viewModel.allPlayers = allPlayers
        self.viewModel.playersWithoutWinner = allPlayers.filter( { !$0.winStatus } )
        self.viewModel.winnerPlayer = winnerPlayer
        self.resetGameClosure = resetGameClosure
        self.viewModel.updateComponents()
        super.init()
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
        
        let backImgView = BasicImgView(name: .named("back_button_img"), height: 20, width: 40)
        backImgView.contentMode = .scaleAspectFit
        backImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        let backButton = UIBarButtonItem(customView: backImgView)
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func makeLayout() {
        view.addSubview(mainContentStack)
        mainContentStack.addArrangedSubview(winnerContentStack)
        winnerContentStack.addArrangedSubview(winWordLabel)
        mainCircleView.addSubview(circleView)
        circleView.addSubview(winGamesLabel)
        circleView.addSubview(winerEmojiLabel)
        winnerContentStack.addArrangedSubview(mainCircleView)
        playersInfoLabelsView.addSubview(nameLabel)
        playersInfoLabelsView.addSubview(pointsLabel)
        winnerContentStack.addArrangedSubview(playersInfoLabelsView)
        mainContentStack.addArrangedSubview(playersCollection)
        resetButtonView.addSubview(statisticButton)
        resetButtonView.addSubview(resetButton)
        mainContentStack.addArrangedSubview(resetButtonView)
    }
    
    override func makeConstraints() {
        mainContentStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-6)
        }
        
        circleView.snp.makeConstraints { make in
            make.height.width.equalTo(self.view.frame.size.width / 2)
            circleView.layer.cornerRadius = self.view.frame.size.width / 4
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        winGamesLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        winerEmojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        playersCollection.snp.makeConstraints { make in
            make.height.equalTo(154)
        }
        
        statisticButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(resetButton.snp.top).offset(-10)
            
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
        
        resetButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.winWordLabel.setViewModel(viewModel.winWordLabelVM)
        self.winGamesLabel.setViewModel(viewModel.winGamesLabelVM)
        self.winerEmojiLabel.setViewModel(viewModel.winerEmojiLabelVM)
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
        self.resetButton.setViewModel(viewModel.resetButtonVM)
        self.viewModel.resetButtonVM.action = { [weak self] in
            ConfirmPopupController.show(titleText: "Начать новую партию?", position: .center) { [weak self] in
                self?.resetGameClosure?()
                self?.navigationController?.popViewController(animated: true)
            }
        }
        self.statisticButton.setViewModel(viewModel.statisticButtonVM)
        self.viewModel.statisticButtonVM.action = { [weak self] in
            guard let self else { return }
            let statisticVC = StatisticController(viewModel: .init(), players: self.viewModel.allPlayers)
            present(statisticVC, animated: true)
        }
    }
    
    private func confettiAnimation() {
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc, .heart, .star], duration: 5)
    }
    
    @objc private func tapOnWinnerView() {
        guard let winnerPlayer = viewModel.winnerPlayer else { return }
        let historyVC = HistoryController(viewModel: .init(), player: winnerPlayer)
        present(historyVC, animated: true)
        Vibration.selection.vibrate()
    }
    
    @objc private func backAction() {
        ConfirmPopupController.show(titleText: "Выйти из игры?", position: .center) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        Vibration.viewTap.vibrate()
    }
    
}

extension WinController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playersWithoutWinner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let playerCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BasicCollectionViewCell<PlayerCollectionCell>.self),
            for: indexPath
        ) as? BasicCollectionViewCell<PlayerCollectionCell> else { return .init() }
        
        playerCell.mainView.isActive(true)
        playerCell.mainView.setPlayer(player: viewModel.playersWithoutWinner[indexPath.row], winsCounter: true)
        
        return playerCell
    }
}

extension WinController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: playersCollection.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.playersWithoutWinner.count {
        case 1:
            return 0
        case 2:
            return 30
        default:
            return (mainContentStack.frame.size.width - 100 * 3) / 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard viewModel.playersWithoutWinner.count < 3 else { return .init() }
        var spacing = 0
        viewModel.playersWithoutWinner.count == 2 ? (spacing = 30) : (spacing = 0)
        
        let cellsNumber = collectionView.numberOfItems(inSection: section)
        let totalCellWidth = 100 * CGFloat(cellsNumber) + CGFloat(spacing)
        let leftInset = ((collectionView.frame.width - CGFloat(totalCellWidth)) / 2)
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
    }
}

extension WinController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let historyVC = HistoryController(viewModel: .init(), player: viewModel.playersWithoutWinner[indexPath.row])
        present(historyVC, animated: true)
        Vibration.selection.vibrate()
    }
}
