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
    private lazy var nameLabel = BasicLabel(font: .RobotronDot, fontSize: 25)
    private lazy var indicatorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    private lazy var pointsLabel = BasicLabel(font: .AlfaSlabOne, fontSize: 20)
    private lazy var pointsProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .systemBlue
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
        return progressView
    }()
    private lazy var maybePointsProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .systemGreen
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
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
    
    private lazy var firstBoltView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        return view
    }()
    private lazy var secondBoltView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var diceMainView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnDiceView)))
        return view
    }()
    private lazy var firstDie = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: 1, withColor: .withPointsStandart),
        height: 70,
        width: 70,
        withShadow: true
    )
    private lazy var secondDie = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: 2, withColor: .withPointsStandart),
        height: 70,
        width: 70,
        withShadow: true
    )
    private lazy var thirdDie = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: 3, withColor: .withPointsStandart),
        height: 70,
        width: 70,
        withShadow: true
    )
    private lazy var fourthDie = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: 4, withColor: .withPointsStandart),
        height: 70,
        width: 70,
        withShadow: true
    )
    private lazy var fifthDie = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: 5, withColor: .withPointsStandart),
        height: 70,
        width: 70,
        withShadow: true
    )
    
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
    
    private var currentDiceSkin = diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0]
    private var diceArray: [BasicImgView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addRoolsButtonInNavBar()
        
        diceArray = [firstDie, secondDie, thirdDie, fourthDie, fifthDie]
        
        viewModel.actionsBeforeTurn()
        updateUIBeforeTurn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    init(viewModel: MainGameControllerModel) {
        self.viewModel = viewModel
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
        self.view.addSubview(mainContentStack)
        
        mainContentStack.addArrangedSubview(topView)
        topView.addSubview(nameLabel)
        topView.addSubview(indicatorStack)
        indicatorStack.addArrangedSubview(firstBoltView)
        indicatorStack.addArrangedSubview(secondBoltView)
        topView.addSubview(pointsLabel)
        topView.addSubview(shadowProgressView)
        topView.addSubview(maybePointsProgressView)
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
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.size.height / 80)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(6)
            make.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-6)
        }
        print(self.view.frame.size.height)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
        }
        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(nameLabel)
        }
        indicatorStack.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(15)
//            make.trailing.equalTo(pointsLabel.snp.leading).offset(-10)
            make.centerY.equalTo(nameLabel)
        }
        let progressView = [maybePointsProgressView, pointsProgressView]
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
        
        let boltViews = [firstBoltView, secondBoltView]
        boltViews.forEach { boltView in
            boltView.snp.makeConstraints { make in
                make.height.width.equalTo(24)
            }
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
            make.height.equalTo(154)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.pointsLabel.setViewModel(viewModel.pointsLabelVM)
        
        self.currentActionInfoLabel.setViewModel(viewModel.currentActionInfoLabelVM)
        self.currentPointsLabel.setViewModel(viewModel.currentPointsLabelVM)
        
        self.endOfTurnButton.setViewModel(viewModel.endOfTurnButtonVM)
        self.viewModel.endOfTurnButtonVM.action = { [weak self] in
            guard let self else { return }
            RoolsCheck().checkOvertake(currentPlayer: self.viewModel.currentPlayer,
                                       playersArray: self.viewModel.players)
            self.viewModel.actionsAfterTurn()
            
            guard !self.viewModel.currentPlayer.winStatus else {
                self.winnerAction()
                return
            }
            
            self.viewModel.updatePlayersOrder()
            self.playersCollection.reloadDataWithAnimation(duration: 0.1)
            
            self.viewModel.actionsBeforeTurn()
            self.updateUIBeforeTurn()
        }
    }
    
    @objc private func tapOnDiceView() {
        guard !viewModel.currentPlayer.turnIsFinish else {
            endOfTurnButton.pulseAnimation(duration: 0.3)
            return
        }
        self.viewModel.roll()
        self.viewModel.actionsAfterRoll()
        updateUIAfterRoll()
    }

    @objc private func backAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// методы обновления ui во время игры
extension MainGameController {
    
    private func updateUIAfterRoll() {
        updateIndicatorsImg()
        updateCubesImg()
        updateMaybeProgressLine()
        
        // переписать с помощью замыкания на проверки правила болтов в модели
        if viewModel.currentPlayer.isBoltsCrash {
            viewModel.pointsLabelVM.textValue = .text(viewModel.currentPlayer.points.toString())
            playersCollection.reloadItems(at: [IndexPath(row: 1, section: 0)])
        }
    }
    
    private func updateUIBeforeTurn() {
        nameLabel.flyInFromLeftAnimation()
        pointsLabel.flyInFromRightAnimation()
        currentActionInfoLabel.fadeInAnimation()
        
        updateIndicatorsImg()
        indicatorStack.fadeInAnimation()
        maybePointsProgressView.progress = 0
        
        for (index, die) in diceArray.enumerated() {
            die.image = currentDiceSkin.getDie(number: index + 1, withColor: .unactive)
            die.isHidden = false
            die.fadeInAnimation()
        }
        
        playersCollection.reloadItems(at: [IndexPath(row: 1, section: 0)])
        
        updateMainProgressLine()
    }
    
    private func updateCubesImg() {
        let plusCubesArray = BasicMechanics().getResult(cubeDigits: viewModel.currentPlayer.curentRoll).plusCubesArray
        
        var diceColorWithPoints: DieColors = .withPointsStandart
        var diceColorWithoutPoints: DieColors = .withoutPointsStandart
        
        if viewModel.currentPlayer.isItInYama {
            diceColorWithPoints = .withPointsInYama
            diceColorWithoutPoints = .withoutPointsInYama
        }
        
        // в зависимости от количества последнего доступного количества кубиков (перед броском) выставление значений видимости у кубов
        for (index, die) in diceArray.enumerated() {
            if index < viewModel.currentPlayer.lastAmountOfCubes {
                die.isHidden = false
                die.fadeInAnimation()
                die.rotateAnimation(rotations: 1)
                die.pulseAnimation()
            } else {
                die.fadeOutAnimation()
                die.isHidden = true
            }
            
        }
        // придавание кубам фактического значения и выделение их соответствующим цветом в зависимости от значений массива положительных значений (и статуса нахождения игрока в яме)
        for (index, number) in viewModel.currentPlayer.curentRoll.enumerated() {
            if plusCubesArray.contains(number) {
                diceArray[index].image = currentDiceSkin.getDie(number: number, withColor: diceColorWithPoints)
            } else {
                diceArray[index].image = currentDiceSkin.getDie(number: number, withColor: diceColorWithoutPoints)
            }
        }
    }
    
    private func updateIndicatorsImg() {
        firstBoltView.isHidden = !(viewModel.currentPlayer.bolts >= 1)
        secondBoltView.isHidden = !(viewModel.currentPlayer.bolts == 2)
    }
    
    private func updateMainProgressLine() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            self.pointsProgressView.setProgress(self.viewModel.currentPlayer.points.toFloat() / 1000.0, animated: true)
        }
    }
    
    private func updateMaybeProgressLine() {
        let maybePoints = (viewModel.currentPlayer.points + viewModel.currentPlayer.currentPoints).toFloat() / 1000.0
        UIView.animate(withDuration: 0.7) { [weak self] in
            self?.maybePointsProgressView.setProgress(maybePoints, animated: true)
        }
    }
    
    private func winnerAction() {
        let winVC = WinController(
            viewModel: .init(),
            winnerPlayer: viewModel.currentPlayer,
            allPlayers: viewModel.players) { [weak self] in
                guard let self else { return }
                
                self.viewModel.players.forEach { player in
                    player.resetStats()
                }
                
                UserManager.read(key: .randomOrderPlayers) ?
                self.viewModel.players.shuffle() :
                self.viewModel.players.sort(by: {$0.positionNumber < $1.positionNumber})
                guard let lastPlayer = self.viewModel.players.last else { return }
                self.viewModel.players.removeLast()
                self.viewModel.players.insert(lastPlayer, at: 0)
                
                self.viewModel.actionsBeforeTurn()
                self.playersCollection.reloadData()
                self.updateUIBeforeTurn()
            }
        
        self.navigationController?.pushViewController(winVC, animated: false)
    }
}

// методы коллекции
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let historyVC = HistoryController(viewModel: .init(), player: viewModel.players[indexPath.row])
        present(UINavigationController(rootViewController: historyVC), animated: true)
    }
}
