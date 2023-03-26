//
//  UITextField+MyStyle.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

extension UITextField {
    
    public func setMyStyle(textAligment: NSTextAlignment, font: UIFont) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAligment
        self.borderStyle = .none
        self.font = font
        self.backgroundColor = .white
        return self
    }
    
    public func setLeftViewMode(viewMode: UITextField.ViewMode, view: UIView) -> Self {
        self.leftViewMode = viewMode
        self.leftView = view
        
        return self
    }
    
    public func setTarget(method: Selector, target: Any, event: UIControl.Event) -> Self {
        self.addTarget(target, action: method, for: event)
        return self
    }
}
