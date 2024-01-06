//
//  RoolsController.swift
//  The 1000 Game
//
//  Created by Sanchez on 27.10.2023.
//

import Foundation
import UIKit
import Combine

class RoolsController: BasicPresentController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: RoolsControllerModel
    
    private lazy var titleLabel = BasicLabel(font: .RobotronDot, fontSize: 30)
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var roolsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "all_rools_ru_img")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        makeLayout()
        makeConstraints()
    }
    
    init(viewModel: RoolsControllerModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        mainView.addSubview(titleLabel)
        mainView.addSubview(scrollView)
        scrollView.addSubview(roolsImageView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.top).offset(-8)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        roolsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(self.view.frame.size.width - 24)
            make.top.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        self.titleLabel.setViewModel(viewModel.titleLabelVM)
    }
}
