//
//  Rows+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func addRowsOnKeyboard(kbKeys: [String], spacing: CGFloat = 0, buttonWidth: CGFloat = 26) -> UIView {
        
        let RowStackView = UIStackView.init()
        RowStackView.spacing = spacing
        RowStackView.axis = .horizontal
        RowStackView.alignment = .center
        RowStackView.distribution = .equalSpacing
        
        for key in kbKeys {
            let button = createButtonWithTitle(title: key, buttonWidth: buttonWidth)
            RowStackView.addArrangedSubview(button)
        }
        
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        
        //            keysView.addConstraintsWithFormatString(formate: "H:|-(16)-[v0]-(16)-|", views: RowStackView)
        //            keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        NSLayoutConstraint.activate([
            RowStackView.topAnchor.constraint(equalTo: keysView.topAnchor),
            RowStackView.leadingAnchor.constraint(greaterThanOrEqualTo: keysView.leadingAnchor),
            RowStackView.trailingAnchor.constraint(lessThanOrEqualTo: keysView.trailingAnchor),
            RowStackView.centerXAnchor.constraint(equalTo: keysView.centerXAnchor)
        ])
        return keysView
        
        
    }
}
