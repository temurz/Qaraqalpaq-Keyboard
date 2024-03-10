//
//  NumericKeys+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func displayNumericKeys(firstPage: Bool = true) {
        
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
}
