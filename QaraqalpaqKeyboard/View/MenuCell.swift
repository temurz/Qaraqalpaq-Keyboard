//
//  MenuCell.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 11/10/2023.
//

import UIKit
class MenuCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = UIColor(named: "cell_background_color")
        self.selectionStyle = .none
        
        titleLabel.textColor = UIColor(named: "text_color")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .lightGray
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(arrowImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16)
        ])
    }
    
    func updateModel(title: String) {
        titleLabel.text = title
    }
}
