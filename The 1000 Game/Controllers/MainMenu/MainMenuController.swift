//
//  MainMenuController.swift
//  The 1000 Game
//
//  Created by Sanchez on 26.10.2023.
//

import UIKit
import Combine

class MainMenuController: BasicViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: MainMenuControllerModel
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 13
        return stack
    }()
    
    private lazy var mainNameLabelView = UIView()
    private lazy var mainNameLabel: BasicLabel = {
        let label = BasicLabel(aligment: .center, font: .AlfaSlabOne, fontSize: 60)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        return label
    }()
    
    private lazy var playersGestureView: BasicView = {
        let view = BasicView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playersGestureAction)))
        return view
    }()
    private lazy var playersLabel = BasicLabel(font: .RobotronDot, fontSize: 16)
    private lazy var playersChevronImg = BasicImgView(name: .named("right_schevron"), height: 17, width: 17)
    private lazy var playersCountLabel = BasicLabel(font: .AlfaSlabOne, fontSize: 16)
    
    private lazy var dicesChoiseGestureView: BasicView = {
        let view = BasicView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dicesChoiseGestureAction)))
        return view
    }()
    private lazy var dicesChoiseLabel = BasicLabel(font: .RobotronDot, fontSize: 16)
    private lazy var diceChoosenImg = BasicImgView(
        name: nil,
        image: diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .six, withColor: .withPointsStandart),
        height: 30,
        width: 30,
        tintColor: .systemPink
    )
    private lazy var dicesChoiseChevronImg = BasicImgView(name: .named("right_schevron"), height: 17, width: 17)
    
    private lazy var bochkiToogleView = BasicView()
    private lazy var bochkiLabel = BasicLabel(font: .RobotronDot, fontSize: 16)
    private lazy var bochkiSwitcher = BasicSwitcher()
    
    private lazy var botsToogleView = BasicView()
    private lazy var botsLabel = BasicLabel(font: .RobotronDot, fontSize: 16)
    private lazy var botsSwitcher = BasicSwitcher()
    
    private lazy var startGameButtonView = UIView()
    private lazy var startGameButton = BasicButton(style: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    init(viewModel: MainMenuControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        viewModel.playersCountLabelVM.textValue = .text((UserManager.read(key: .amountOfPlayers) ?? BasicRools.Constants.playersAmountDefault).toString())
        diceChoosenImg.image = diceSkins[UserManager.read(key: .dieSkinIndex) ?? 0].getDie(number: .six, withColor: .withPointsStandart)
    }

    private func setupNavBar() {
        let roolsImgView = BasicImgView(name: .named("rools_img"), height: 38, width: 38)
        roolsImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(roolsAction)))
        let roolButton = UIBarButtonItem(customView: roolsImgView)
        navigationItem.rightBarButtonItem = roolButton
        
        let mainLangView = UIView()
        let langLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "Ru"
            label.font = UIFont(name: "inter-black", size: 26)
            return label
        }()
        mainLangView.addSubview(langLabel)
        langLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainLangView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(langAction)))
        let langButton = UIBarButtonItem(customView: mainLangView)
        navigationItem.leftBarButtonItem = langButton
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "robotrondotmatrix", size: 0)!
        ]
        title = "1000"
    }
    
    @objc private func roolsAction() {
    }
    
    @objc private func langAction() {
    }
    
    @objc private func playersGestureAction() {
        let playersVC = PlayersAmountController(viewModel: .init())
        self.navigationController?.pushViewController(playersVC, animated: true)
    }
    
    @objc private func dicesChoiseGestureAction() {
        let diceVC = DiceController(viewModel: .init())
        self.navigationController?.pushViewController(diceVC, animated: true)
    }
    
    override func makeLayout() {
        self.view.addSubview(buttonsStackView)
        self.view.addSubview(mainNameLabelView)
        mainNameLabelView.addSubview(mainNameLabel)
        
        buttonsStackView.addArrangedSubview(playersGestureView)
        playersGestureView.addSubview(playersLabel)
        playersGestureView.addSubview(playersChevronImg)
        playersGestureView.addSubview(playersCountLabel)
        
        buttonsStackView.addArrangedSubview(dicesChoiseGestureView)
        dicesChoiseGestureView.addSubview(dicesChoiseLabel)
        dicesChoiseGestureView.addSubview(diceChoosenImg)
        dicesChoiseGestureView.addSubview(dicesChoiseChevronImg)
        
        buttonsStackView.addArrangedSubview(bochkiToogleView)
        bochkiToogleView.addSubview(bochkiLabel)
        bochkiToogleView.addSubview(bochkiSwitcher)
        
        buttonsStackView.addArrangedSubview(botsToogleView)
        botsToogleView.addSubview(botsLabel)
        botsToogleView.addSubview(botsSwitcher)
        
        self.view.addSubview(startGameButtonView)
        startGameButtonView.addSubview(startGameButton)
    }
    
    override func makeConstraints() {
        mainNameLabelView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(buttonsStackView.snp.top)
        }
        
        mainNameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainNameLabelView)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
        
        playersCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playersChevronImg.snp.leading).offset(-7)
        }
        
        diceChoosenImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(dicesChoiseChevronImg.snp.leading).offset(-4)
        }
        
        let namelabels = [playersLabel, dicesChoiseLabel, bochkiLabel, botsLabel]
        for label in namelabels {
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(26)
                make.centerY.equalToSuperview()
            }
        }
        
        let switchers = [bochkiSwitcher, botsSwitcher]
        for switcher in switchers {
            switcher.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-26)
                make.centerY.equalToSuperview()
            }
        }
        
        let chevrons = [playersChevronImg, dicesChoiseChevronImg]
        for chevron in chevrons {
            chevron.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-26)
            }
        }
        
        startGameButtonView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        startGameButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(startGameButtonView)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.startGameButton.setViewModel(viewModel.startGameButton)
        self.viewModel.startGameButton.action = { [weak self] in
            let mainGameVC = MainGameController(viewModel: .init())
            self?.navigationController?.pushViewController(mainGameVC, animated: true)
        }
        
        self.mainNameLabel.setViewModel(viewModel.mainNameLabelVM)
        self.playersLabel.setViewModel(viewModel.playersLabelVM)
        self.playersCountLabel.setViewModel(viewModel.playersCountLabelVM)
        self.dicesChoiseLabel.setViewModel(viewModel.dicesChoiseLabelVM)
        self.bochkiLabel.setViewModel(viewModel.bochkiLabelVM)
        self.botsLabel.setViewModel(viewModel.botsLabelVM)
    }

}
