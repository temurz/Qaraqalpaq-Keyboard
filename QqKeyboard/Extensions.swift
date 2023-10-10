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
    
    func fullConstraint(view:UIView? = nil, top:CGFloat! = 0, bottom:CGFloat! = 0, leading:CGFloat! = 0, trailing:CGFloat! = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: (view ?? self.superview!).topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: (view ?? self.superview!).bottomAnchor, constant: bottom),
            self.leadingAnchor.constraint(equalTo: (view ?? self.superview!).leadingAnchor, constant: leading),
            self.trailingAnchor.constraint(equalTo: (view ?? self.superview!).trailingAnchor, constant: trailing),
        ])
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
