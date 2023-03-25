//
//  UIImageView+MyStyle.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

extension UIImageView {
    
    public func setMyStyle() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        return self
    }
    
    public func setImage(image: UIImage?) -> Self {
        self.image = image
      
        return self
    }
}
