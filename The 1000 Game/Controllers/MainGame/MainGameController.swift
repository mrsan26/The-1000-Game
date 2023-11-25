//
//  MainGameController.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.10.2023.
//

import UIKit
import Combine

class MainGameController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: MainGameControllerModel
    
    private lazy var mainContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var topView = UIView()
    private lazy var nameLabel = BasicLabel(font: .RobotronDot, fontSize: 30)
    private lazy var indicatorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    private lazy var pointsLabel = BasicLabel(font: .AlfaSlabOne, fontSize: 20)
    private lazy var pointsProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .systemBlue
        progressView.progress = 0.5 //vremenno
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
        return progressView
    }()
    private lazy var currentPointsProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .systemGreen
        progressView.progress = 0.6 //vremenno
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
//        progressView.backgroundColor = .white.withAlphaComponent(0.25)
        return progressView
    }()
    private lazy var shadowProgressView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .white.withAlphaComponent(0.5)
        shadowView.layer.cornerRadius = 8
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius = 4
        return shadowView
    }()
    
    private lazy var diceMainView = UIView()
    private lazy var firstDie = BasicImgView(name: nil, image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .one, withColor: .withPointsStandart), height: 70, width: 70, withShadow: true)
    private lazy var secondDie = BasicImgView(name: nil, image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .two, withColor: .withPointsStandart), height: 70, width: 70, withShadow: true)
    private lazy var thirdDie = BasicImgView(name: nil, image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .three, withColor: .withPointsStandart), height: 70, width: 70, withShadow: true)
    private lazy var fourthDie = BasicImgView(name: nil, image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .four, withColor: .withPointsStandart), height: 70, width: 70, withShadow: true)
    private lazy var fifthDie = BasicImgView(name: nil, image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .five, withColor: .withPointsStandart), height: 70, width: 70, withShadow: true)
    
    private lazy var commonActionLabelsView = UIView()
    private lazy var centerActionLabelsView = UIView()
    private lazy var currentActionInfoLabel = BasicLabel(font: .RobotronDot, fontSize: 20)
    private lazy var currentPointsLabel = BasicLabel(font: .AlfaSlabOne, fontSize: 20)
    
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
    
    private lazy var endOfTurnButtonView = UIView()
    private lazy var endOfTurnButton = BasicButton(style: .red, titleFontSize: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    init(viewModel: MainGameControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.view.addSubview(mainContentStack)
        
        mainContentStack.addArrangedSubview(topView)
        topView.addSubview(nameLabel)
        topView.addSubview(indicatorStack)
        topView.addSubview(pointsLabel)
        topView.addSubview(shadowProgressView)
        topView.addSubview(currentPointsProgressView)
        topView.addSubview(pointsProgressView)
        
        mainContentStack.addArrangedSubview(diceMainView)
        diceMainView.addSubview(firstDie)
        diceMainView.addSubview(secondDie)
        diceMainView.addSubview(thirdDie)
        diceMainView.addSubview(fourthDie)
        diceMainView.addSubview(fifthDie)
        
        mainContentStack.addArrangedSubview(commonActionLabelsView)
        commonActionLabelsView.addSubview(centerActionLabelsView)
        centerActionLabelsView.addSubview(currentActionInfoLabel)
        centerActionLabelsView.addSubview(currentPointsLabel)
        
        mainContentStack.addArrangedSubview(playersCollection)
        
        mainContentStack.addArrangedSubview(endOfTurnButtonView)
        endOfTurnButtonView.addSubview(endOfTurnButton)
    }
    
    override func makeConstraints() {
        mainContentStack.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(6)
            make.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-6)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
        }
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(nameLabel)
        }
        indicatorStack.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(-10)
            make.centerY.equalTo(nameLabel)
        }
        let progressView = [currentPointsProgressView, pointsProgressView]
        progressView.forEach { progressView in
            progressView.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.height.equalTo(16)
            }
        }
        shadowProgressView.snp.updateConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(17)
            make.bottom.equalToSuperview()
        }
        
        diceMainView.snp.makeConstraints { make in
            make.height.equalTo(self.view.frame.size.height / 3.2)
        }
        firstDie.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
        }
        secondDie.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        thirdDie.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        fourthDie.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
        }
        fifthDie.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        
        centerActionLabelsView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        currentActionInfoLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(currentPointsLabel.snp.leading).offset(-10)
        }
        currentPointsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(currentActionInfoLabel)
            make.trailing.equalToSuperview()
            make.leading.equalTo(currentActionInfoLabel.snp.trailing).offset(10)
        }
        
        endOfTurnButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        playersCollection.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
        
        self.currentActionInfoLabel.setViewModel(viewModel.currentActionInfoLabelVM)
        self.currentPointsLabel.setViewModel(viewModel.currentPointsLabelVM)
        
        self.endOfTurnButton.setViewModel(viewModel.endOfTurnButtonVM)
    }

}


extension MainGameController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let playerCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BasicCollectionViewCell<PlayerCollectionCell>.self),
            for: indexPath
        ) as? BasicCollectionViewCell<PlayerCollectionCell> else { return .init() }
        
        playerCell.mainView.isActive(indexPath.row == 1)
        playerCell.mainView.setPlayer(player: viewModel.players[indexPath.row])
        
        return playerCell
    }
}

extension MainGameController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: playersCollection.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (mainContentStack.frame.size.width - 100 * 3) / 2
    }
}

extension MainGameController: UICollectionViewDelegate {
}
