//
//  MenuCell.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 11/10/2023.
//

import UIKit
class MenuCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var iconImageView = UIImageView()
    private lazy var arrowImageView = UIImageView()
    private lazy var separatorLine = UIView()
    
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
        
        separatorLine.backgroundColor = .systemGray2
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(separatorLine)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 4
        iconImageView.tintColor = .gray
        self.contentView.addSubview(iconImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16),
            
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5),
            separatorLine.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
    
    func updateModel(title: String, image: UIImage?) {
        titleLabel.text = title
        iconImageView.image = image
        
    }
    
    func removeLine() {
        separatorLine.isHidden = true
    }
}
