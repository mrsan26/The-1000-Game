//
//  Methods.swift
//  The 1000 Game
//
//  Created by Sanchez on 30.12.2023.
//

import UIKit
import SnapKit

func doesObjectExist(index objectIndex: Int, in array: [Any]) -> Bool {
    return objectIndex >= 0 && objectIndex < array.count
}

func noticeAction(text: String, image: UIImage?) {
    guard let image else { return }
    let sideSize = UIScreen.main.bounds.size.width / 2
    
    let mainView = BasicView(standartSize: false)
    mainView.frame = CGRect(x: UIScreen.main.bounds.midX - sideSize / 2,
                            y: UIScreen.main.bounds.midY - sideSize / 2,
                            width: sideSize,
                            height: sideSize)
    mainView.alpha = 0
    mainView.backgroundColor = .systemGray5
    
    let textLabel = BasicLabel(color: .white,
                               aligment: .center,
                               font: .AlfaSlabOne, 
                               fontSize: 20)
    textLabel.text = text
    textLabel.alpha = 0
    textLabel.shadowOffset = .init(width: 1, height: 2)
    textLabel.shadowColor = .systemGray2
    
    let imageView = UIImageView(image: image)
    imageView.alpha = 0
    imageView.contentMode = .scaleAspectFill
    
    mainView.addSubview(imageView)
    mainView.addSubview(textLabel)
    
    imageView.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(16)
        make.centerX.equalToSuperview()
        make.height.width.equalTo(sideSize / 1.5)
    }
    textLabel.snp.makeConstraints { make in
        make.top.equalTo(imageView.snp.bottom).offset(0)
        make.leading.equalToSuperview().offset(16)
        make.trailing.bottom.equalToSuperview().offset(-16)
    }
    
    // Добавляем imageView на главный экран
    if let window = UIApplication.shared.windows.first {
        window.addSubview(mainView)
    }
    
    // Анимация появления
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
        mainView.alpha = 1
        textLabel.alpha = 1
        imageView.alpha = 1
    }) { (_) in
        // Анимация исчезновения
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
            mainView.alpha = 0
            textLabel.alpha = 0
            imageView.alpha = 0
        }) { (_) in
            // После завершения анимации исчезновения удаляем imageView из представления
            mainView.removeFromSuperview()
        }
    }
}
