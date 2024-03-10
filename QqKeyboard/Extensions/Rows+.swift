//
//  Rows+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func addRowsOnKeyboard(kbKeys: [String], spacing: CGFloat = 5, isAdditional: Bool = false, isMiddle: Bool = false) -> UIView {
        
        let RowStackView = UIStackView.init()
        RowStackView.spacing = 0
        RowStackView.axis = .horizontal
        RowStackView.alignment = .center
        RowStackView.distribution = .fillEqually
        if isAdditional {
            RowStackView.addArrangedSubview(UIView())
            for key in kbKeys {
                let button = createButtonWithTitle(title: key)
                RowStackView.addArrangedSubview(button)
            }
            RowStackView.addArrangedSubview(UIView())
        }else {
            for key in kbKeys {
                let button = createButtonWithTitle(title: key)
                RowStackView.addArrangedSubview(button)
            }
        }
        
        
        
        let keysView = UIView()
        keysView.backgroundColor = .clear
        keysView.addSubview(RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        if isMiddle {
            keysView.addConstraintsWithFormatString(formate: "H:|-(16)-[v0]-(16)-|", views: RowStackView)
            return keysView
        }else {
            keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
            return keysView
        }
        
    }
}
