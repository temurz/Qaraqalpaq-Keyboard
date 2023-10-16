//
//  InstructionsController.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 11/10/2023.
//

import UIKit
class InstructionsController: UIViewController {
    private let tableView = UITableView()
    private var items = ["Сазламаларды ашын", "Баслы сазламалар", "Клавиатуралар", "Клавиатура косыу", "\"KarKey\" ды сайлан"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Көрсетпе"
        initialize()
    }
    
    private func initialize() {
        self.view.backgroundColor = UIColor(named: "background_color")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(InstructionCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension InstructionsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! InstructionCell
        cell.updateModel(title: items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
