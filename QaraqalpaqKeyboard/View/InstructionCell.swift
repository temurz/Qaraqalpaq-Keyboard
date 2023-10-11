//
//  InstructionCell.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 11/10/2023.
//

import UIKit
class InstructionCell: UITableViewCell {
    let stepView = UIView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        stepView.layer.cornerRadius = 8
        stepView.backgroundColor = UIColor(named: "step_color")
        stepView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stepView)
        
        titleLabel.textColor = UIColor(named: "text_color")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stepView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stepView.heightAnchor.constraint(equalToConstant: 16),
            stepView.widthAnchor.constraint(equalTo: stepView.heightAnchor, multiplier: 1),
            stepView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: stepView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func updateModel(title: String) {
        titleLabel.text = title
    }
}
