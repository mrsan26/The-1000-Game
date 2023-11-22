//
//  PlayerCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit
import SnapKit

class PlayerCellView: BasicView {
    private lazy var trashImg: BasicImgView = {
        let img = BasicImgView(name: .named("trash_img"), height: 23, width: 23)
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deletePlayer)))
        img.isUserInteractionEnabled = true
        return img
    }()
    private lazy var nameLabel = BasicLabel(font: .RobotronDot, fontSize: 20)
    private lazy var renameLabel: BasicLabel = {
        let label = BasicLabel(font: .InterBlack, fontSize: 16)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(renamePlayer)))
        label.isUserInteractionEnabled = true
        return label
    }()

    let viewModel = ViewModel()
    
    var deletePlayerClosure: ((Player) -> Void)?
    var renamePlayerClosure: ((Player) -> Void)?
    var longPressViewClosure: Completion?
    var tapViewClosure: Completion?
    
    init() {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        setViewGestures()
        setViewModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewGestures() {
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressView)))
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapView)))
    }
    
    private func makeLayout() {
        self.addSubview(trashImg)
        self.addSubview(nameLabel)
        self.addSubview(renameLabel)
    }
    
    private func makeConstraints() {
        let subviews = [trashImg, nameLabel, renameLabel]
        subviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
        }
        
        trashImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
        }
        
        renameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(trashImg.snp.trailing).offset(10).priority(1000)
            make.trailing.equalTo(renameLabel.snp.leading).offset(-10).priority(1000)
        }
    }
    
    func renameLabelIsHidden(_ isHidden: Bool) {
        renameLabel.isHidden = isHidden
    }
    
    @objc private func renamePlayer() {
        guard let player = viewModel.player else { return }
        renamePlayerClosure?(player)
    }
    
    @objc private func deletePlayer() {
        guard let player = viewModel.player else { return }
        deletePlayerClosure?(player)
    }
    
    @objc private func longPressView() {
        longPressViewClosure?()
    }
    
    @objc private func tapView() {
        tapViewClosure?()
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.renameLabel.setViewModel(viewModel.renameLabelVM)
    }
    
}
