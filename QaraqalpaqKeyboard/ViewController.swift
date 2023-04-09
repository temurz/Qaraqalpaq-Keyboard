//
//  ViewController.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 28/01/2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
    }
    
    private func initialize() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Text a message"
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

