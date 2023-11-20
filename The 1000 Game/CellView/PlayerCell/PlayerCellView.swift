//
//  PlayerCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit
import SnapKit

class PlayerCellView: BasicView {
    private lazy var trashImg = BasicImgView(name: .named("trash_img"), height: 23, width: 23)
    private lazy var nameLabel = BasicLabel(font: .RobotronDot, fontSize: 20)
    private lazy var renameLabel = BasicLabel(font: .AlfaSlabOne, fontSize: 16)
    private lazy var renameLabel2: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    let viewModel = ViewModel()
    
    init() {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        setViewModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setViewModel(_ viewModel: ViewModel) {
        self.nameLabel.setViewModel(viewModel.nameLabelVM)
        self.renameLabel.setViewModel(viewModel.renameLabelVM)
    }
    
}
