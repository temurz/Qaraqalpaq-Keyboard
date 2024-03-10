//
//  Colors+.swift
//  QqKeyboard
//
//  Created by Temur on 10/03/2024.
//

import UIKit
extension KeyboardViewController {
    func setColorScheme() {
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
}
