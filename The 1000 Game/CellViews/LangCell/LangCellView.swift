//
//  LangCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 14.01.2024.
//

import UIKit
import SnapKit
import Combine

class LangCellView: BasicCellView {
    
    var cancellables: Set<AnyCancellable> = []
    
    private lazy var mainView: BasicView = {
        let view = BasicView()
        view.snp.removeConstraints()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = UIScreen.main.bounds.size.height / 11 / 3
        return view
    }()
    
    private lazy var labelView = UIView()
    private lazy var langLabel = BasicLabel(font: .RobotronDot, fontSize: 30)
    private lazy var emojiLabel = BasicLabel(font: .RobotronDot, fontSize: 45)
    
    private lazy var chooseIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIScreen.main.bounds.size.height / 11 / 3
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseLang)))
        return view
    }()

    let viewModel = ViewModel()
    
    var chooseIndex: Int?
    var chooseClosure: ((Int) -> Void)?
    @Published var choosen: Bool = false
    
    init() {
        super.init(frame: .zero)
        setViewModel(viewModel)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeLayout() {
        self.addSubview(mainView)
        labelView.addSubview(langLabel)
        labelView.addSubview(emojiLabel)
        mainView.addSubview(labelView)
        
        mainView.addSubview(chooseIndicatorView)
    }
    
    override func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12))
            make.height.equalTo((Int(UIScreen.main.bounds.size.height / 11)))
        }
        
        labelView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width / 5)
            make.trailing.equalToSuperview().offset(-UIScreen.main.bounds.width / 5)
        }
        langLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(emojiLabel).offset(-30)
        }
        emojiLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(langLabel)
        }
        
        chooseIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func chooseLang() {
        guard !choosen, let chooseIndex else { return }
        choosen.toggle()
        chooseClosure?(chooseIndex)
        Vibration.viewTap.vibrate()
    }
    
    override func binding() {
        self.$choosen.sink { [weak self] choosen in
            guard let self else { return }
            switch choosen {
            case true:
                self.chooseIndicatorView.backgroundColorChangingAnimate(to: .black.withAlphaComponent(0))
            case false:
                self.chooseIndicatorView.backgroundColorChangingAnimate(to: .black.withAlphaComponent(0.2))
            }
        }
        .store(in: &cancellables)
    }
    
    func setInfo(langName: String, langEmoji: String) {
        self.viewModel.setInfo(langName: langName, langEmoji: langEmoji)
    }
    
    func setItemIndex(index: Int) {
        self.chooseIndex = index
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        langLabel.setViewModel(viewModel.langLabelVM)
        emojiLabel.setViewModel(viewModel.emojiLabellVM)
    }
    
}
