//
//  ViewController.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 28/01/2023.
//

import UIKit
import StoreKit
class ViewController: UIViewController {
    private let tableView = UITableView()
//    private let textField = UITextField()
    private let logoImageView = UIImageView()
    private var items = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Қарақалпақша клавиатура"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.enableMultilineTitle()
        setItems()
        initialize()
    }
    
    private func setItems() {
        items.append(MenuModel(title: "Көрсетпе", image: UIImage(systemName: "gear")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)))
        
        items.append(MenuModel(title: "Байланыс ушын", image: UIImage(systemName: "text.bubble.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)))
        
        items.append(MenuModel(title: "Баҳа бериў", image: UIImage(systemName:"hand.thumbsup.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)))
    }
    
    private func initialize() {
        self.view.backgroundColor = UIColor(named: "background_color")
        
        tableView.rowHeight = 50
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        logoImageView.image = UIImage(named: "new_logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.backgroundColor = .clear
//        logoImageView.layer.cornerRadius = (view.frame.height / 2) * 0.1
//        logoImageView.clipsToBounds = true
        self.view.addSubview(logoImageView)
        
//        textField.placeholder = "Text something"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            textField.heightAnchor.constraint(equalToConstant: 50),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25),
            logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -16),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1),
            
            tableView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.updateModel(title: items[indexPath.row].title, image: items[indexPath.row].image)
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
        if indexPath.row == 0  {
            cell.layer.cornerRadius = 12
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }else if indexPath.row == items.count - 1 {
            cell.layer.cornerRadius = 12
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.removeLine()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = InstructionsController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ContactsController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            //Support project
//            let alert = UIAlertController(title: "Қоллап қуўатлаў", message: "", preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "Артқа", style: .cancel)
            
            
//            let donate = UIAlertAction(title: "Донат жибериў", style: .default)
//            let rate = UIAlertAction(title: "Баҳа бериў", style: .default) { _ in
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    DispatchQueue.main.async {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
//            }
            
//            alert.addAction(donate)
//            alert.addAction(rate)
//            alert.addAction(cancel)
//            self.present(alert, animated: true)
        default:
            break
        }
    }
}

extension UINavigationItem {
   
   func enableMultilineTitle() {
      setValue(true, forKey: "__largeTitleTwoLineMode")
   }
   
}


struct MenuModel {
    let title: String
    let image: UIImage?
}
