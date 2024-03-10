//
//  KeyboardViewController.swift
//  QqKeyboard
//
//  Created by Temur on 28/01/2023.
//

import UIKit

enum UppercaseStates {
    case up
    case low
    case alwaysUp
}

final class KeyboardViewController: UIInputViewController {
    var nextKeyboardButton: UIButton!
    var mainStackView: UIStackView!
    var allTextButtons = [KeyboardButton]()
    
    var capButton: KeyboardButton!
    var numericButton: KeyboardButton!
    var deleteButton: KeyboardButton!
    var latinCyrillButton: KeyboardButton!
    var returnButton: KeyboardButton!
    var spaceButton: KeyboardButton!
    var dotButton: KeyboardButton!
    var commaButton: KeyboardButton!
    
    var keyboardHeight: CGFloat = 255
    var themeColors: KBColors! = KBColors(colorScheme: .dark)
    
    var backspaceTimer: Timer?
    var backspaceCounter: Int = 0
    
    var firstTapTime: Date?
    
    var keyboardState = UppercaseStates.up {
        didSet {
            areLettersShowing = true
        }
    }
    
    var areCyrillLetters = true {
        didSet {
            areLettersShowing = true
        }
    }
    
    var areLettersShowing = true {
        didSet {
            for view in mainStackView.arrangedSubviews {
                view.removeFromSuperview()
            }
            if areLettersShowing {
                if areCyrillLetters {
                    self.addCyrillKeyboardButtons()
                }else {
                    self.addLatinKeyboardButtons()
                }
            }else {
                displayNumericKeys()
            }
            setColorScheme()
        }
        
    }
    
    var additionalSymbols = false 
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: keyboardHeight)
        ])
        if textDocumentProxy.hasText {
            keyboardState = .low
        }
        
        view.backgroundColor = UIColor(named: "key_bg_color")
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.addCyrillKeyboardButtons()
        self.setColorScheme()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setColorScheme()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        self.setColorScheme()
    }
}
