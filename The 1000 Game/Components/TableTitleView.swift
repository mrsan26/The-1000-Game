//
//  TableTitleView.swift
//  The 1000 Game
//
//  Created by Sanchez on 10.01.2024.
//

import UIKit
import SnapKit

class TableTitleView: UIView {
    
    lazy var turnNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    lazy var pointsNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    lazy var pointsChangesNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.addSubview(turnNumberLabel)
        self.addSubview(pointsNumberLabel)
        self.addSubview(pointsChangesNumberLabel)
    }
    
    private func makeConstraints() {
        turnNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        pointsNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        pointsChangesNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
