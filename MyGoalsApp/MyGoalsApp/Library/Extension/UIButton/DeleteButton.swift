//
//  DeleteButton.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class DeleteButton: UIButton {
    
    

    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? .black.withAlphaComponent(0.5) : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                self.setImage(Images.select, for: .normal)
            case false:
                self.setImage(UIImage(), for: .normal)
            }
        }
    }
}
