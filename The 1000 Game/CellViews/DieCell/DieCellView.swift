//
//  DieCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 23.11.2023.
//

import UIKit
import SnapKit
import Combine

class DieCellView: BasicCellView {
    
    var cancellables: Set<AnyCancellable> = []
    
    private lazy var mainView: BasicView = {
        let view = BasicView()
        view.snp.removeConstraints()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 25
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var firstDie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var secondDie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var chooseIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseDie)))
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
        mainView.addSubview(contentStack)
        contentStack.addArrangedSubview(firstDie)
        contentStack.addArrangedSubview(secondDie)
        mainView.addSubview(chooseIndicatorView)
    }
    
    override func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12))
        }
        
        contentStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        let dice = [firstDie, secondDie]
        dice.forEach { die in
            die.snp.makeConstraints { make in
                make.height.width.equalTo(120)
            }
        }
        
        chooseIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func chooseDie() {
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
    
    func setImages(firstDieImg: UIImage, secondDieImg: UIImage) {
        self.firstDie.image = firstDieImg
        self.secondDie.image = secondDieImg
    }
    
    func setItemIndex(index: Int) {
        self.chooseIndex = index
    }
    
    func setViewModel(_ viewModel: ViewModel) {
    }
    
}
