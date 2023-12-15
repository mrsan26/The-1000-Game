//
//  BasicTableCell.swift
//  The 1000 Game
//
//  Created by Sanchez on 21.11.2023.
//

import UIKit
import SnapKit

class BasicTableCell<T: BasicCellView>: UITableViewCell {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.prepareForReuse()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.contentView.addSubview(mainView)
//        self.contentView.addSubview(separatorView)
    }
    
    private func makeConstraints() {
        self.mainView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview() //.offset(12)
//            make.trailing.equalToSuperview() //.offset(-12)
//            make.bottom.equalTo(separatorView.snp.top)
            make.edges.equalToSuperview()
        }
//        self.separatorView.snp.makeConstraints { make in
//            make.bottom.trailing.leading.equalToSuperview()
//            make.height.equalTo(10)
//        }
    }
}
