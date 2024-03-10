//
//  ServiceKeys+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func accessoryButtons(title: String?, img: UIImage?, tag: Int) -> KeyboardButton {
        
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
    
    func serviceKeys(midRow: UIView) -> (UIStackView, UIStackView) {
        //        if areLettersShowing {
        switch keyboardState {
        case .low:
            self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial1"), tag: 1)
        case .up:
            self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial"), tag: 1)
        case .alwaysUp:
            self.capButton = accessoryButtons(title: nil, img: #imageLiteral(resourceName: "captial2"), tag: 1)
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
        let fourthRowSV = UIStackView(arrangedSubviews: [numbericBgButton, dotBgButton, spaceBgButton, latinCyrBgButton, returnBgButton])
        fourthRowSV.distribution = .fillProportionally
        fourthRowSV.spacing = 0
        
        return (thirdRowSV,fourthRowSV)
        //        }
    }
    
    //MARK: - Actions
    @objc func handleCapitalsAndLowerCase(sender: UIButton) {
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
    
    @objc func handleBackDeleteSingleTap() {
        self.textDocumentProxy.deleteBackward()
        //        if self.shouldMakeUppercasedKeyboard().makeUpper {
        //            if keyboardState != .alwaysUp {
        //                keyboardState = .up
        //            }
        //        }else if keyboardState != .alwaysUp {
        //            keyboardState = .low
        //        }
    }
    
    
    
    @objc func handleLatinCyrillButton() {
        self.areCyrillLetters = !areCyrillLetters
    }
    
    @objc func insertWhiteSpace() {
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
    
    @objc func handleReturnKey(sender: UIButton) {
        //        if let _ = self.textDocumentProxy.documentContextBeforeInput {
        self.textDocumentProxy.insertText("\n")
        //        }
        if keyboardState != .alwaysUp {
            keyboardState = .up
        }
    }
    
    @objc func handleSwitchingNumericsAndLetters(sender: UIButton) {
        areLettersShowing = !areLettersShowing
    }
    
    @objc func handleAdditionalSymbolicKey() {
        //        additionalSymbols = !additionalSymbols
        //        displayNumericKeys(firstPage: additionalSymbols)
        //        if additionalSymbols {
        //            self.capButton.setTitle("_\\", for: .normal)
        //        }else {
        //            self.capButton.setTitle("-/", for: .normal)
        //        }
    }
    
    @objc func handleDotButton() {
        textDocumentProxy.insertText(".")
        if keyboardState != .alwaysUp {
            keyboardState = .up
        }
    }
    
    @objc func handleCommaButton() {
        textDocumentProxy.insertText(",")
    }
    
    @objc func onLongPressOfBackSpaceKey(longGestr: UILongPressGestureRecognizer) {
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
    
    @objc private func backspaceTimerFired() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if backspaceCounter < 15 { // Delete letters for first 5 presses
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
