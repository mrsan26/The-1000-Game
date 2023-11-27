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
        return view
    }()
    private lazy var winerEmojiLabel = BasicLabel(aligment: .center, font: .InterBlack, fontSize: 100)
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
    private lazy var resetButton = BasicButton(style: .red, titleFontSize: 20)
    
    private var resetGameClosure: VoidBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        setupNavBar()
        addRoolsButtonInNavBar()
        self.view.fadeInAnimation { [weak self] _ in
            self?.confettiAnimation()
        }
    }
    
    init(viewModel: WinControllerModel, winnerPlayer: Player, allPlayers: [Player], resetGameClosure: VoidBlock?) {
        self.viewModel = viewModel
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
        circleView.addSubview(winerEmojiLabel)
        winnerContentStack.addArrangedSubview(mainCircleView)
        playersInfoLabelsView.addSubview(nameLabel)
        playersInfoLabelsView.addSubview(pointsLabel)
        mainContentStack.addArrangedSubview(playersInfoLabelsView)
        mainContentStack.addArrangedSubview(playersCollection)
        resetButtonView.addSubview(resetButton)
        mainContentStack.addArrangedSubview(resetButtonView)
    }
    
    override func makeConstraints() {
        mainContentStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(6)
            make.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-6)
        }
        
        circleView.snp.makeConstraints { make in
            make.height.width.equalTo(self.view.frame.size.width / 2)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
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
            make.height.equalTo(134)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.winWordLabel.setViewModel(viewModel.winWordLabelVM)
        self.winerEmojiLabel.setViewModel(viewModel.winerEmojiLabelVM)
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
        self.resetButton.setViewModel(viewModel.resetButtonVM)
        self.viewModel.resetButtonVM.action = { [weak self] in
            self?.resetGameClosure?()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func confettiAnimation() {
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc, .heart, .star], duration: 5)
    }
    
    @objc private func backAction() {
        navigationController?.popToRootViewController(animated: true)
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
        
        playerCell.mainView.setPlayer(player: viewModel.playersWithoutWinner[indexPath.row])
        
        return playerCell
    }
}

extension WinController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: playersCollection.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if viewModel.playersWithoutWinner.count < 3 {
            return 20
        } else {
            return (mainContentStack.frame.size.width - 100 * 3) / 2
        }
    }
}

extension WinController: UICollectionViewDelegate {
    
}
