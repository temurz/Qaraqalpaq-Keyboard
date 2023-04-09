//
//  Themes+Colors.swift
//  SecNinjazKeyboard
//
//  Created by Leela Prasad on 30/04/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit

enum KBColorScheme {
    case dark
    case light
}

struct KBColors {
    
    let buttonTextColor: UIColor
    let buttonBackgroundColor: UIColor
    let buttonHighlightColor: UIColor
    let buttonTintColor: UIColor
    let serviceButtonBackgroundColor: UIColor
    
    init(colorScheme: KBColorScheme) {
        switch colorScheme {
        case .light:
            buttonTextColor = .black
            buttonTintColor = .black
            buttonBackgroundColor = .white
            buttonHighlightColor = UIColor(red: 174/255, green: 179/255, blue: 190/255, alpha: 1.0)
            serviceButtonBackgroundColor = UIColor(red: 171/255, green: 177/255, blue: 186/255, alpha: 1.0)
        case .dark:
            buttonTextColor = .white
            buttonTintColor = .white
            buttonBackgroundColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
            buttonHighlightColor = UIColor(white: 104/255, alpha: 1.0)
            serviceButtonBackgroundColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0)
        }
    }
    
}


//MARK: Color Constatnts

//let containerPrimaryViewColor = UIColor.white
//let containerSubViewBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
