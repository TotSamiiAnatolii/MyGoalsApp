//
//  UIButton+MyStyle.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

extension UIButton {
    
    func setMyStyle(backgroundColor: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.contentMode = .scaleAspectFill
        return self
    }
    
    func setMyTitle(text: String, state: State) -> Self {
        self.setTitle(text, for: state)
        return self
    }
    
    func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {
        self.addTarget(target, action: methodDown.self, for: event)
        return self
    }
}
extension UIImage {
    func withAlpha(_ alpha: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: alpha)
        }
    }
}
