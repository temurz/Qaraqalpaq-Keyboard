//
//  ViewController.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 28/01/2023.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
//    private let textField = UITextField()
    
    private var items = [["Қолланба"], ["Байланыс ушын"], ["Жойбарды қоллап қуўатлаў"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "KarKey"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        initialize()
    }
    
    private func initialize() {
        self.view.backgroundColor = UIColor(named: "background_color")
        
        tableView.rowHeight = 50
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
//        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        
//        textField.placeholder = "Text something"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            textField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.updateModel(title: items[indexPath.section][indexPath.row])
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
