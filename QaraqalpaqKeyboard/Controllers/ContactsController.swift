//
//  ContactsController.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 11/10/2023.
//

import UIKit
class ContactsController: UIViewController {
    private let mainTextLabel = UILabel()
    private let telegramImageView = UIImageView()
    private let telegramTextLabel = UILabel()
    private let mailImageView = UIImageView()
    private let mailTextLabel = UILabel()
    private let backgroundView = UIView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Байланыс ушын"
        self.view.backgroundColor = UIColor(named: "background_color")
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let text = mainTextLabel.text {
            let height = text.height(withConstrainedWidth: self.view.frame.width - 32, font: .systemFont(ofSize: 16)) + 350.0
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width - 32, height: height)
            scrollView.isScrollEnabled = height > UIScreen.main.bounds.height ? true : false
        }
    }
    
    private func initialize() {
        backgroundView.backgroundColor = UIColor(named: "cell_background_color")
        backgroundView.layer.cornerRadius = 12
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        if scrollView.contentOffset.x>0 {
//            scrollView.contentOffset.x = 0
//        }
        scrollView.backgroundColor = UIColor(named: "cell_background_color")
        scrollView.layer.cornerRadius = 12
        scrollView.isScrollEnabled = true
        self.view.addSubview(scrollView)
        
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.textColor = UIColor(named: "text_color")
        mainTextLabel.textAlignment = .left
        mainTextLabel.font = .systemFont(ofSize: 18)
        mainTextLabel.text = "Бул бағдарлама кеўилли түрде ислеп шығылмақта. Бағдарламаның баслы мақсети iOS операцион системасын қолланыўшылар ушын Қарақалапақ тилинде жазыў қолайлығын жаратыў. Бағдарламаны қолланыў даўамында қате кемшиликлер табыўыңыз мүмкин, илтимас сондай жағдайларда төмендеги силтемелер арқалы бағдарламашы менен байланыссаңыз, оннан тысқары өзиңиздиң усынысларыңызды билдирсеңиз болады!"
        mainTextLabel.numberOfLines = 0
        self.scrollView.addSubview(mainTextLabel)
        
        telegramImageView.contentMode = .scaleAspectFit
        telegramImageView.image = UIImage(systemName: "paperplane.circle.fill")
        telegramImageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(telegramImageView)
        
        telegramTextLabel.translatesAutoresizingMaskIntoConstraints = false
        telegramTextLabel.textColor = .systemBlue
        telegramTextLabel.font = .systemFont(ofSize: 16)
        telegramTextLabel.text = "Telegram"
        telegramTextLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(telegramTapped))
        telegramTextLabel.addGestureRecognizer(tap)
        let attributedText = NSMutableAttributedString(string: "Telegram")
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: "Telegram".count))
        telegramTextLabel.attributedText = attributedText
        self.scrollView.addSubview(telegramTextLabel)
        
        mailImageView.image = UIImage(systemName: "envelope.fill")
        mailTextLabel.contentMode = .scaleAspectFit
        mailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(mailImageView)
        
        mailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mailTextLabel.textColor = .systemBlue
        mailTextLabel.isUserInteractionEnabled = true
        let attributedTextMail = NSMutableAttributedString(string: "zaitovtemur98@gmail.com")
        attributedTextMail.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: "zaitovtemur98@gmail.com".count))
        mailTextLabel.attributedText = attributedTextMail
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(mailTapped))
        mailTextLabel.addGestureRecognizer(mailTap)
        self.scrollView.addSubview(mailTextLabel)
        
        
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
            
            mainTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainTextLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainTextLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            telegramImageView.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 12),
            telegramImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            telegramImageView.heightAnchor.constraint(equalToConstant: 24),
            telegramImageView.widthAnchor.constraint(equalTo: telegramImageView.heightAnchor, multiplier: 1),
            
            telegramTextLabel.leadingAnchor.constraint(equalTo: telegramImageView.trailingAnchor, constant: 12),
            telegramTextLabel.centerYAnchor.constraint(equalTo: telegramImageView.centerYAnchor),
            telegramTextLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            mailImageView.topAnchor.constraint(equalTo: telegramImageView.bottomAnchor, constant: 12),
            mailImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            mailImageView.heightAnchor.constraint(equalToConstant: 24),
            mailImageView.widthAnchor.constraint(equalTo: mailImageView.heightAnchor, multiplier: 1),
            
            mailTextLabel.leadingAnchor.constraint(equalTo: mailImageView.trailingAnchor, constant: 12),
            mailTextLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mailTextLabel.centerYAnchor.constraint(equalTo: mailImageView.centerYAnchor),
            
        ])
    }
    
    @objc private func telegramTapped() {
        let appURL = NSURL(string: "tg://resolve?domain=timurcm")! as URL
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        }else if let webURL = URL(string: "https://t.me/timurcm"), UIApplication.shared.canOpenURL(webURL) {
            UIApplication.shared.open(webURL)
        }
    }
    
    @objc private func mailTapped() {
        let email = "zaitovtemur98@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
}
