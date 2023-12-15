//
//  BasicCellView.swift
//  The 1000 Game
//
//  Created by Sanchez on 15.12.2023.
//

import UIKit

class BasicCellView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() {}
    func makeConstraints() {}
    func binding() {}
    
    func prepareForReuse() {}
}
