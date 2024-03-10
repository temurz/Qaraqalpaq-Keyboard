//
//  KeyboardViewController+Helpers.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func createBackgroundButton(subView: UIView) -> UIButton {
        let button = UIButton()
        subView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subView)
        subView.fullConstraint(top: 4, bottom: -4, leading: 2, trailing: -2)
        return button
    }
    
    func shouldMakeUppercasedKeyboard() -> (makeUpper: Bool, addDot: Bool) {
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
    
    func getTextFromCurrentInput() -> String? {
        let documentContextBeforeInput = textDocumentProxy.documentContextBeforeInput ?? ""
        let documentContextAfterInput = textDocumentProxy.documentContextAfterInput ?? ""
        
        return documentContextBeforeInput + documentContextAfterInput
    }
}
