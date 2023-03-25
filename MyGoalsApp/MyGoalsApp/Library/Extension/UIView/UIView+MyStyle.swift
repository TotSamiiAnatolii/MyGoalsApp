//
//  UIView+MyStyle.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

extension UIView {
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    public func setStyle(color: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
        return self
    }

    public func setShadow(color: CGColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float ) -> Self {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        return self
    }
}
