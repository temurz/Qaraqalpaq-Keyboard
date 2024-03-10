//
//  Letters+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func addLatinKeyboardButtons() {
        allTextButtons.removeAll()
        let screenWidth = view.window?.windowScene?.screen.bounds.width ?? 390
        let buttonWidth = (screenWidth - 40) / 10
        if keyboardState == .low {
            
            let additionalRow = addRowsOnKeyboard(kbKeys: ["á","ǵ", "ú", "ń", "ı", "ó"], buttonWidth: buttonWidth)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["q","w","e","r","t","y","u","i","o","p"], buttonWidth: buttonWidth)
            let secondRowView = addRowsOnKeyboard(kbKeys: ["a","s","d","f","g","h","j","k","l"], buttonWidth: buttonWidth)
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["z","x","c","v","b","n","m"], buttonWidth: buttonWidth)
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }else {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["Á","Ǵ", "Ú", "Ń", "Í", "Ó"], buttonWidth: buttonWidth)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["Q","W","E","R","T","Y","U","I","O","P"], buttonWidth: buttonWidth)
            let secondRowView = addRowsOnKeyboard(kbKeys: ["A","S","D","F","G","H","J","K","L"], buttonWidth: buttonWidth)
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["Z","X","C","V","B","N","M"], buttonWidth: buttonWidth)
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }
    }
    
    func addCyrillKeyboardButtons() {
        //My Custom Keys...
        allTextButtons.removeAll()
        let screenWidth = view.window?.windowScene?.screen.bounds.width ?? 390
        let buttonWidth = (screenWidth - 44) / 11
        if keyboardState == .low {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["ә","ў", "ү", "қ", "ң", "ғ", "ө","ъ","ҳ"], buttonWidth: buttonWidth)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["й","ц","у","к","е","н","г","ш","щ","з", "х"], buttonWidth: buttonWidth)
            let secondRowView = addRowsOnKeyboard(kbKeys: ["ф","ы","в","а","п","р","о","л","д", "ж","э"], buttonWidth: buttonWidth)
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["я","ч","с","м","и","т","ь","б","ю"], buttonWidth: buttonWidth)
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }else {
            let additionalRow = addRowsOnKeyboard(kbKeys: ["Ә","Ғ", "Қ", "Ң", "Ө", "Ү", "Ў","Ҳ","Ъ"], buttonWidth: buttonWidth)
            let firstRowView = addRowsOnKeyboard(kbKeys: ["Й","Ц","У","К","Е","Н","Г","Ш","Щ","З", "Х"], buttonWidth: buttonWidth)
            let secondRowView = addRowsOnKeyboard(kbKeys: ["Ф","Ы","В","А","П","Р","О","Л","Д", "Ж","Э"], buttonWidth: buttonWidth)
            
            let thirdRowkeysView = addRowsOnKeyboard(kbKeys: ["Я","Ч","С","М","И","Т","Ь","Б","Ю"], buttonWidth: buttonWidth)
            
            let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: thirdRowkeysView)
            addMainStackView(arrangedSubviews: [additionalRow,firstRowView,secondRowView,thirdRowSV,fourthRowSV])
        }
    }

    //MARK: - Actions
    @objc func didTapButton(sender: UIButton) {
        
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
        
        if areLettersShowing {
            keyboardState = keyboardState == .up ? .low : keyboardState
        }
        
        if title == "." || title == "?" || title == "!" {
            if keyboardState != .alwaysUp {
                keyboardState = .up
            }
        }
    }
}
