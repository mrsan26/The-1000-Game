//
//  BasicCollectionCell.swift
//  The 1000 Game
//
//  Created by Sanchez on 25.11.2023.
//

import UIKit
import SnapKit

class BasicCollectionViewCell<T: UIView>: UICollectionViewCell {
    let mainView = T()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.contentView.addSubview(mainView)
    }
    
    private func makeConstraints() {
        self.mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
