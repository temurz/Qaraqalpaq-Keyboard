//
//  KeyboardViewController.swift
//  QqKeyboard
//
//  Created by Temur on 28/01/2023.
//

import UIKit

fileprivate enum UppercaseStates {
    case up
    case low
    case alwaysUp
}

final class KeyboardViewController: UIInputViewController {
    
    private var nextKeyboardButton: UIButton!
    private var mainStackView: UIStackView!
    private var allTextButtons = [KeyboardButton]()
    
    private var capButton: KeyboardButton!
    private var numericButton: KeyboardButton!
    private var deleteButton: KeyboardButton!
    private var latinCyrillButton: KeyboardButton!
    private var returnButton: KeyboardButton!
    private var spaceButton: KeyboardButton!
    private var dotButton: KeyboardButton!
    private var commaButton: KeyboardButton!
    
    private var keyboardHeight: CGFloat = 215
    private var themeColors: KBColors! = KBColors(colorScheme: .dark)
    
    private var backspaceTimer: Timer?
    private var backspaceCounter: Int = 0
    
    private var firstTapTime: Date?
    
    private var keyboardState = UppercaseStates.up {
        didSet {
            switch keyboardState {
            case .low:
                capButton.setImage(#imageLiteral(resourceName: "captial1"), for: .normal)
                for button in allTextButtons {
                    if let title = button.currentTitle {
                        if title == "Í" {
                            button.setTitle("ı", for: .normal)
                            if let bg = button.superview as? UIButton {
                                bg.setTitle("ı", for: .normal)
                            }
                        }else {
                            button.setTitle(title.lowercased(), for: .normal)
                        }
                    }
                }
            case .up:
                capButton.setImage(#imageLiteral(resourceName: "captial"), for: .normal)
                for button in allTextButtons {
                    if let title = button.currentTitle {
                        if title == "ı" {
                            button.setTitle("Í", for: .normal)
                            if let bg = button.superview as? UIButton {
                                bg.setTitle("Í", for: .normal)
                            }
                        }else {
                            button.setTitle(title.uppercased(), for: .normal)
                        }
                    }
                }
            case .alwaysUp:
                capButton.setImage(#imageLiteral(resourceName: "captial2"), for: .normal)
                for button in allTextButtons {
                    if let title = button.currentTitle {
                        if title == "ı" {
                            button.setTitle("Í", for: .normal)
                            if let bg = button.superview as? UIButton {
                                bg.setTitle("Í", for: .normal)
                            }
                        }else {
                            button.setTitle(title.uppercased(), for: .normal)
                        }
                    }
                }
            }
        }
    }
    
    private var areCyrillLetters = false {
        didSet {
            areLettersShowing = true
        }
    }
    
    private var areLettersShowing = true {
        didSet{
            for view in mainStackView.arrangedSubviews {
                view.removeFromSuperview()
            }
            if areLettersShowing {
                if areCyrillLetters {
                    self.addCyrillKeyboardButtons()
                }else {
                    self.addKeyboardButtons()
                }
            }else {
                displayNumericKeys()
            }
            setColorScheme()
        }
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.addKeyboardButtons()
        self.setColorScheme()
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: keyboardHeight)
        ])
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
    
    private func addKeyboardButtons() {
        //My Custom Keys...
        allTextButtons.removeAll()
        if keyboardState == .low || !shouldMakeUppercasedKeyboard().makeUpper {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["á","ǵ", "ú", "ń", "ı", "ó"], isAdditional: true)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["q","w","e","r","t","y","u","i","o","p"])
            let secondRowView = addRowsOnKeyboard(kbKeys: ["a","s","d","f","g","h","j","k","l"])
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["z","x","c","v","b","n","m"])
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }else {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["Á","Ǵ", "Ú", "Ń", "Í", "Ó"], isAdditional: true)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["Q","W","E","R","T","Y","U","I","O","P"])
            let secondRowView = addRowsOnKeyboard(kbKeys: ["A","S","D","F","G","H","J","K","L"])
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["Z","X","C","V","B","N","M"])
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }
    }
    
    private func addCyrillKeyboardButtons() {
        //My Custom Keys...
        allTextButtons.removeAll()
        if keyboardState == .low || !shouldMakeUppercasedKeyboard().makeUpper {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["ә","ў", "ү", "қ", "ң", "ғ", "ө","ъ","ҳ"], isAdditional: true)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["й","ц","у","к","е","н","г","ш","щ","з", "х"])
            let secondRowView = addRowsOnKeyboard(kbKeys: ["ф","ы","в","а","п","р","о","л","д", "ж","э"])
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["я","ч","с","м","и","т","ь","б","ю"])
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }else {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["Ә","Ғ", "Қ", "Ң", "Ө", "Ү", "Ў","Ҳ","Ъ"], isAdditional: true)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["Й","Ц","У","К","Е","Н","Г","Ш","Щ","З", "Х"])
            let secondRowView = addRowsOnKeyboard(kbKeys: ["Ф","Ы","В","А","П","Р","О","Л","Д", "Ж","Э"])
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["Я","Ч","С","М","И","Т","Ь","Б","Ю"])
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }
    }
    
    private func displayNumericKeys(firstPage: Bool = true) {
        
        for view in mainStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let additional = ["[","]","{","}","\\","%","^","*","+","="]
        let nums = ["1","2","3","4","5","6","7","8","9","0"]
//        let splChars1 = firstPage ? ["-","/",":",";","(",")","$","&","@","\""] : ["_","\\","|","~","<",">","€","£","¥","•"]
        let splChars1 = firstPage ? ["-","_",":",";","(",")","$","&","@","\""] : ["_","\\","|","~","<",">","€","£","¥","•"]
        let splChars2 = [".",",","?","!","#", "/"]
        
        let additionalRow = self.addRowsOnKeyboard(kbKeys: additional)
        let numsRow = self.addRowsOnKeyboard(kbKeys: nums)
        let splChars1Row = self.addRowsOnKeyboard(kbKeys: splChars1)
        let splChars2Row = self.addRowsOnKeyboard(kbKeys: splChars2)
        
        let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: splChars2Row)
        
        mainStackView.addArrangedSubview(additionalRow)
        mainStackView.addArrangedSubview(numsRow)
        mainStackView.addArrangedSubview(splChars1Row)
        mainStackView.addArrangedSubview(thirdRowSV)
        mainStackView.addArrangedSubview(fourthRowSV)
        
    }
    
    private func addRowsOnKeyboard(kbKeys: [String], spacing: CGFloat = 5, isAdditional: Bool = false) -> UIView {
        
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
        keysView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: RowStackView)
        keysView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: RowStackView)
        return keysView
    }
    
    private func addMainStackView(arrangedSubviews: [UIView]) {
        
        self.mainStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        mainStackView.removeFromSuperview()
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: keyboardHeight-4).isActive = true
    }
    
    // Creates Buttons on Keyboard...
    private func createButtonWithTitle(title: String) -> UIButton {
        let button = KeyboardButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = themeColors.buttonBackgroundColor
        button.setTitleColor(themeColors.buttonTextColor, for: .normal)
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        allTextButtons.append(button)
        
        let bgButton = createBackgroundButton(subView: button)
        bgButton.setTitle(title, for: .normal)
        bgButton.isUserInteractionEnabled = true
        bgButton.backgroundColor = view.backgroundColor
        bgButton.setTitleColor(.clear, for: .normal)
        bgButton.addTarget(self, action: #selector(didTapButton(sender: )), for: .touchUpInside)
        return bgButton
    }
    
    private func accessoryButtons(title: String?, img: UIImage?, tag: Int) -> KeyboardButton {
        
        let button = KeyboardButton.init(type: .system)
        button.setTitleColor(themeColors.buttonTextColor, for: .normal)
        button.tintColor = themeColors.buttonTintColor
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        
        if let buttonTitle = title {
            button.setTitle(buttonTitle, for: .normal)
        }
        
        if let buttonImage = img {
            button.setImage(buttonImage.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        
        switch button.tag {
        case 1:
            //For Capitals...
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCapitalsAndLowerCase))
            singleTapGesture.numberOfTapsRequired = 1
            button.addGestureRecognizer(singleTapGesture)
            
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
            
        case 2:
            //For BackDelete Key // Install Once Only..
            let longPressRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(onLongPressOfBackSpaceKey(longGestr:)))
            
            longPressRecognizer.minimumPressDuration = 0.5
            longPressRecognizer.cancelsTouchesInView = false
            button.addGestureRecognizer(longPressRecognizer)
            button.addTarget(self, action: #selector(handleBackDeleteSingleTap), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
        case 3:
            //Switch to and From Letters & Numeric Keys
            button.addTarget(self, action: #selector(handleSwitchingNumericsAndLetters(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
            return button
        case 4:
            //Next Keyboard Button... Globe Button Usually...
            button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            return button
        case 5:
            //Handle Latin or Cyrill Karakalpak alphabet
            
            button.addTarget(self, action: #selector(handleLatinCyrillButton), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
        case 6:
            //White Space Button...
            button.defaultBackgroundColor = themeColors.buttonBackgroundColor
            button.addTarget(self, action: #selector(insertWhiteSpace), for: .touchUpInside)
            //            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            return button
        case 7:
            button.addTarget(self, action: #selector(handleReturnKey(sender:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 75).isActive = true
            return button
        case 8:
            //additional symbols
            button.addTarget(self, action: #selector(handleAdditionalSymbolicKey), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
        case 9:
            button.addTarget(self, action: #selector(handleDotButton), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
        case 10:
            button.addTarget(self, action: #selector(handleCommaButton), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            return button
        default:
            return button
        }
    }
    
    private func serviceKeys(midRow: UIView) -> (UIStackView, UIStackView) {
//        if areLettersShowing {
            if keyboardState == .low {
                self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial1"), tag: 1)
            }else {
                self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial"), tag: 1)
            }
            
//        }else {
//            self.capButton = accessoryButtons(title: "_\\", img: nil, tag: 8)
//        }
        self.deleteButton = accessoryButtons(title: nil, img: UIImage(named: "backspace"), tag: 2)
        
        capButton.translatesAutoresizingMaskIntoConstraints = false
        let capBgView = createBackgroundButton(subView: capButton)
        capBgView.addTarget(self, action: #selector(handleCapitalsAndLowerCase), for: .touchUpInside)
        
        
        let deleteBgView = createBackgroundButton(subView: deleteButton)
        deleteBgView.addTarget(self, action: #selector(handleBackDeleteSingleTap), for: .touchUpInside)
        
        let thirdRowSV = UIStackView(arrangedSubviews: [capBgView, midRow, deleteBgView])
        thirdRowSV.distribution = .fillProportionally
        thirdRowSV.spacing = 0
        
        if !areCyrillLetters {
            self.latinCyrillButton = accessoryButtons(title: "Ққ", img: nil, tag: 5)
            self.spaceButton = accessoryButtons(title: "bos orın", img: nil, tag: 6)
            self.returnButton = accessoryButtons(title: "kiritiw", img: nil, tag: 7)
            self.numericButton = areLettersShowing ? accessoryButtons(title: "123", img: nil, tag: 3) : accessoryButtons(title: "ABC", img: nil, tag: 3)
        }else {
            self.latinCyrillButton = accessoryButtons(title: "Qq", img: nil, tag: 5)
            self.spaceButton = accessoryButtons(title: "бос орын", img: nil, tag: 6)
            self.returnButton = accessoryButtons(title: "киритиў", img: nil, tag: 7)
            self.numericButton = areLettersShowing ? accessoryButtons(title: "123", img: nil, tag: 3) : accessoryButtons(title: "АБВ", img: nil, tag: 3)
        }
        
        self.nextKeyboardButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "globe"), tag: 4)
        self.dotButton = accessoryButtons(title: ".", img: nil, tag: 9)
        self.commaButton = accessoryButtons(title: ",", img: nil, tag: 10)
        
        let (numbericBgButton, nextBgButton, dotBgButton, spaceBgButton, latinCyrBgButton, commaBgButton, returnBgButton) = (
            createBackgroundButton(subView: numericButton),
            createBackgroundButton(subView: nextKeyboardButton),
            createBackgroundButton(subView: dotButton),
            createBackgroundButton(subView: spaceButton),
            createBackgroundButton(subView: latinCyrillButton),
            createBackgroundButton(subView: commaButton),
            createBackgroundButton(subView: returnButton))
        
        numbericBgButton.addTarget(self, action: #selector(handleSwitchingNumericsAndLetters), for: .touchUpInside)
        nextBgButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .touchUpInside)
        spaceBgButton.addTarget(self, action: #selector(insertWhiteSpace), for: .touchUpInside)
        latinCyrBgButton.addTarget(self, action: #selector(handleLatinCyrillButton), for: .touchUpInside)
        dotBgButton.addTarget(self, action: #selector(handleDotButton), for: .touchUpInside)
        commaBgButton.addTarget(self, action: #selector(handleCommaButton), for: .touchUpInside)
        returnBgButton.addTarget(self, action: #selector(handleReturnKey), for: .touchUpInside)
        
//        if nextKeyboardButton.isHidden {
//            let fourthRowSV = UIStackView(arrangedSubviews: [numbericBgButton, dotBgButton, spaceBgButton, commaBgButton, latinCyrBgButton, returnBgButton])
//            fourthRowSV.distribution = .fillProportionally
//            fourthRowSV.spacing = 0
//            
//            return (thirdRowSV,fourthRowSV)
//        }else {
            let fourthRowSV = UIStackView(arrangedSubviews: [numbericBgButton, nextBgButton, spaceBgButton, latinCyrBgButton, returnBgButton])
            fourthRowSV.distribution = .fillProportionally
            fourthRowSV.spacing = 0
            
            return (thirdRowSV,fourthRowSV)
//        }
    }
    
    private func setColorScheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            themeColors = KBColors(colorScheme: .dark)
        } else {
            themeColors = KBColors(colorScheme: .light)
        }
        
        self.capButton.defaultBackgroundColor = themeColors.buttonBackgroundColor
        self.capButton.tintColor = themeColors.buttonTintColor
        self.deleteButton.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        self.deleteButton.tintColor = themeColors.buttonTintColor
        self.numericButton.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        self.latinCyrillButton.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        self.returnButton.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        (self.nextKeyboardButton as? KeyboardButton)?.defaultBackgroundColor = themeColors.serviceButtonBackgroundColor
        (self.nextKeyboardButton as? KeyboardButton)?.tintColor = themeColors.buttonTintColor
        self.dotButton.defaultBackgroundColor = themeColors.buttonBackgroundColor
        self.dotButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        self.commaButton.defaultBackgroundColor = themeColors.buttonBackgroundColor
        self.commaButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        self.spaceButton.defaultBackgroundColor = themeColors.buttonBackgroundColor
        
        self.capButton.highlightBackgroundColor = themeColors.buttonHighlightColor
        self.deleteButton.highlightBackgroundColor = themeColors.buttonBackgroundColor
        self.returnButton.highlightBackgroundColor = themeColors.buttonBackgroundColor
        self.numericButton.highlightBackgroundColor = themeColors.buttonBackgroundColor
        self.latinCyrillButton.highlightBackgroundColor = themeColors.buttonBackgroundColor
        (self.nextKeyboardButton as? KeyboardButton)?.highlightBackgroundColor = themeColors.buttonBackgroundColor
        self.spaceButton.highlightBackgroundColor = themeColors.buttonHighlightColor
        self.dotButton.highlightBackgroundColor = themeColors.buttonHighlightColor
        self.commaButton.highlightBackgroundColor = themeColors.buttonHighlightColor
        
        
        self.numericButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        self.spaceButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        self.latinCyrillButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        self.returnButton.setTitleColor(themeColors.buttonTextColor, for: .normal)
        
        for button in allTextButtons {
            button.tintColor = themeColors.buttonTintColor
            button.defaultBackgroundColor = themeColors.buttonBackgroundColor
            button.highlightBackgroundColor = themeColors.buttonHighlightColor
            button.setTitleColor(themeColors.buttonTextColor, for: .normal)
            
        }
        
    }
    
    //MARK: - Actions
    @objc private func didTapButton(sender: UIButton) {
        
        let button = sender as UIButton
        //        self.manageShadowsOnKeys(button: button, isShadowsNeeded: false)
        guard let title = button.titleLabel?.text else { return }
        let proxy = self.textDocumentProxy
        if keyboardState == .low {
            proxy.insertText(title.lowercased())
        }else {
            proxy.insertText(title.uppercased())
        }
        
        button.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
        self.inputView?.playInputClick​()
        button.transform = CGAffineTransform.identity
        
        keyboardState = keyboardState == .up ? .low : keyboardState
        
        if title == "." || title == "?" || title == "!" {
            if keyboardState != .alwaysUp {
                keyboardState = .up
            }
        }
    }
    
    @objc private func handleCapitalsAndLowerCase(sender: UIButton) {
        if let firstTapTime = firstTapTime {
            let timeDifference = Date().timeIntervalSince(firstTapTime)
            if timeDifference < 0.3 {
                keyboardState = .alwaysUp
            }else {
                self.firstTapTime = Date()
                keyboardState = keyboardState == .low ? .up : .low
            }
        }else {
            firstTapTime = Date()
            keyboardState = keyboardState == .low ? .up : .low
        }
        
    }
    
    @objc private func handleBackDeleteSingleTap() {
        self.textDocumentProxy.deleteBackward()
//        if self.shouldMakeUppercasedKeyboard().makeUpper {
//            if keyboardState != .alwaysUp {
//                keyboardState = .up
//            }
//        }else if keyboardState != .alwaysUp {
//            keyboardState = .low
//        }
    }
    
    @objc private func onLongPressOfBackSpaceKey(longGestr: UILongPressGestureRecognizer) {
        switch longGestr.state {
            case .began:
            backspaceCounter = 0 // Reset the backspace counter
            backspaceTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(backspaceTimerFired), userInfo: nil, repeats: true)
            case .ended, .cancelled:
                backspaceTimer?.invalidate()
                backspaceTimer = nil
                backspaceCounter = 0
            default:
                break
            }
    }
    
    @objc private func handleLatinCyrillButton() {
        self.areCyrillLetters = !areCyrillLetters
    }
    
    @objc private func insertWhiteSpace() {
        let proxy = self.textDocumentProxy
        proxy.insertText(" ")
        if shouldMakeUppercasedKeyboard() == (true, true) {
            if keyboardState != .alwaysUp {
                keyboardState = .up
            }
            proxy.deleteBackward()
            proxy.deleteBackward()
            proxy.insertText(".")
            proxy.insertText(" ")
        }
    }
    
    @objc private func handleReturnKey(sender: UIButton) {
        //        if let _ = self.textDocumentProxy.documentContextBeforeInput {
        self.textDocumentProxy.insertText("\n")
        //        }
        if keyboardState != .alwaysUp {
            keyboardState = .up
        }
    }
    
    @objc private func handleSwitchingNumericsAndLetters(sender: UIButton) {
        areLettersShowing = !areLettersShowing
    }
    
    @objc private func handleAdditionalSymbolicKey() {
//        additionalSymbols = !additionalSymbols
//        displayNumericKeys(firstPage: additionalSymbols)
//        if additionalSymbols {
//            self.capButton.setTitle("_\\", for: .normal)
//        }else {
//            self.capButton.setTitle("-/", for: .normal)
//        }
    }
    
    @objc private func handleDotButton() {
        textDocumentProxy.insertText(".")
        if keyboardState != .alwaysUp {
            keyboardState = .up
        }
    }
    
    @objc private func handleCommaButton() {
        textDocumentProxy.insertText(",")
    }
    
    @objc private func backspaceTimerFired() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if backspaceCounter < 25 { // Delete letters for first 5 presses
            proxy.deleteBackward()
        } else { // Delete entire word after 5 presses
            let wordRange = proxy.documentContextBeforeInput?.rangeOfCharacter(from: .whitespacesAndNewlines, options: .backwards)
            if let range = wordRange {
                for _ in 0...range.upperBound.utf16Offset(in: proxy.documentContextBeforeInput!) {
                    proxy.deleteBackward()
                }
            } else {
                for _ in 0..<(proxy.documentContextBeforeInput?.count ?? 0) {
                    proxy.deleteBackward()
                }
            }
        }
        backspaceCounter += 1
    }
}


//MARK: - Helper methods
extension KeyboardViewController {
    private func createBackgroundButton(subView: UIView) -> UIButton {
        let button = UIButton()
        subView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subView)
        subView.fullConstraint(top: 4, bottom: -4, leading: 2, trailing: -2)
        return button
    }
    
    private func shouldMakeUppercasedKeyboard() -> (makeUpper: Bool, addDot: Bool) {
        guard let text = getTextFromCurrentInput() else {return (makeUpper: false, addDot: false)}
        
        if text.isEmpty {
            return (makeUpper: true, addDot: false)
        }
        var lastNonSpaceCharacter: Character?
        var foundSpaces = 0
        for character in text.reversed() {
            if character == " " {
                foundSpaces += 1
            } else if character == "." ||
                        character == "!" ||
                        character == "?" {
                return (makeUpper: true, addDot: false)
            } else {
                lastNonSpaceCharacter = character
                break
            }
        }
        
        if foundSpaces <= 1 && (lastNonSpaceCharacter != "." ||
                                lastNonSpaceCharacter != "!" ||
                                lastNonSpaceCharacter != "?") {
            return (makeUpper: false, addDot: false)
        }else if foundSpaces > 1 && lastNonSpaceCharacter != "." {
            return (makeUpper: true, addDot: true)
        }
        
        return (makeUpper: false, addDot: false)
    }
    
    private func getTextFromCurrentInput() -> String? {
        let documentContextBeforeInput = textDocumentProxy.documentContextBeforeInput ?? ""
        let documentContextAfterInput = textDocumentProxy.documentContextAfterInput ?? ""
        
        return documentContextBeforeInput + documentContextAfterInput
    }
}
