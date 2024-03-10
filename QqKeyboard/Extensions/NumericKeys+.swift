//
//  NumericKeys+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func displayNumericKeys(firstPage: Bool = true) {
        let screenWidth = view.window?.windowScene?.screen.bounds.width ?? 390
        let buttonWidth = (screenWidth - 40) / 10
        
        for view in mainStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let additional = ["[","]","{","}","\\","%","^","*","+","="]
        let nums = ["1","2","3","4","5","6","7","8","9","0"]
//        let splChars1 = firstPage ? ["-","/",":",";","(",")","$","&","@","\""] : ["_","\\","|","~","<",">","€","£","¥","•"]
        let splChars1 = firstPage ? ["-","_",":",";","(",")","$","&","@","\""] : ["_","\\","|","~","<",">","€","£","¥","•"]
        let splChars2 = [".",",","?","!","#", "/"]
        
        let additionalRow = self.addRowsOnKeyboard(kbKeys: additional,buttonWidth: buttonWidth)
        let numsRow = self.addRowsOnKeyboard(kbKeys: nums,buttonWidth: buttonWidth)
        let splChars1Row = self.addRowsOnKeyboard(kbKeys: splChars1,buttonWidth: buttonWidth)
        let splChars2Row = self.addRowsOnKeyboard(kbKeys: splChars2,buttonWidth: buttonWidth)
        
        let (thirdRowSV,fourthRowSV) = serviceKeys(midRow: splChars2Row)
        
        mainStackView.addArrangedSubview(additionalRow)
        mainStackView.addArrangedSubview(numsRow)
        mainStackView.addArrangedSubview(splChars1Row)
        mainStackView.addArrangedSubview(thirdRowSV)
        mainStackView.addArrangedSubview(fourthRowSV)
        
    }
}
