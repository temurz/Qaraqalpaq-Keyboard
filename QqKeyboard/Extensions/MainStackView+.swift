//
//  MainStackView+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func addMainStackView(arrangedSubviews: [UIView]) {
        
        self.mainStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        mainStackView.removeFromSuperview()
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: keyboardHeight-4).isActive = true
    }
}
