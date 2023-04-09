//
//  Extensions.swift
//  QaraqalpaqKeyboard
//
//  Created by Temur on 03/02/2023.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

extension UIInputView: UIInputViewAudioFeedback {
    
    public var enableInputClicksWhenVisible: Bool {
        get {
            return true
        }
    }
    
    func playInputClick​() {
        UIDevice.current.playInputClick()
    }
    
}
