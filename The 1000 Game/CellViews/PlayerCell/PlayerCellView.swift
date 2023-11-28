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
        let img = BasicImgView(name: .named("trash_img"), height: 23, width: 23, tintColor: .systemPink)
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deletePlayer)))
        img.isUserInteractionEnabled = true
        return img
    }()
    private lazy var nameLabel = BasicLabel(aligment: .center, font: .RobotronDot, fontSize: 20)
    private lazy var renameImg: BasicImgView = {
        let img = BasicImgView(name: .named("edit_img"), height: 23, width: 23, tintColor: .systemBlue)
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(renamePlayer)))
        img.isUserInteractionEnabled = true
        return img
    }()

    let viewModel = ViewModel()
    
    var deletePlayerAction: ((Player) -> Void)?
    var renamingPlayerDidFinish: ((Player) -> Void)?
    var longPressViewClosure: VoidBlock?
    var tapViewClosure: VoidBlock?
    
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
        self.addSubview(renameImg)
    }
    
    private func makeConstraints() {
        let subviews = [trashImg, nameLabel, renameImg]
        subviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
        }
        
        trashImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
        }
        
        renameImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(trashImg.snp.trailing).offset(10).priority(1000)
            make.trailing.equalTo(renameImg.snp.leading).offset(-10).priority(1000)
        }
    }
    
    @objc private func renamePlayer() {
        guard let player = viewModel.player else { return }
        RenamePopupController.show(playerForEditing: player) { [ weak self ] in
            self?.viewModel.nameLabelVM.textValue = .text(player.name)
        }
        Vibration.viewTap.vibrate()
    }
    
    @objc private func deletePlayer() {
        guard let player = viewModel.player else { return }
        deletePlayerAction?(player)
        Vibration.viewTap.vibrate()
    }
    
    @objc private func longPressView() {
        longPressViewClosure?()
        Vibration.selection.vibrate()
    }
    
    @objc private func tapView() {
        tapViewClosure?()
        Vibration.selection.vibrate()
    }
    
    func setPlayer(player: Player) {
        viewModel.player = player
        viewModel.nameLabelVM.textValue = .text(player.name)
    }
    
    func setViewModel(_ viewModel: ViewModel) {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
    }
    
}
