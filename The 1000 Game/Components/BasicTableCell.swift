//
//  BasicTableCell.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit
import SnapKit

class BasicTableCell<T: UIView>: UITableViewCell {
    let mainView = T()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayout()
        makeConstraints()
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.contentView.addSubview(mainView)
        self.contentView.addSubview(separatorView)
    }
    
    private func makeConstraints() {
        self.mainView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(separatorView.snp.top)
        }
        self.separatorView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview()
            make.height.equalTo(10)
        }
    }
}
