//
//  AddButton.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class AddButton: UIButton {

    private var colors: UIColor?
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                transformButton(isHighlighted: true)
            case false:
                transformButton(isHighlighted: false)
            }
        }
    }
    
    init(color: UIColor) {
        self.colors = color
        super.init(frame: .zero)
        configure(color: color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(color: .black)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func transformButton(isHighlighted: Bool) {
        switch isHighlighted {
        case true:
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        case false:
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func configure(color: UIColor) {
        let image = UIImage(named: "addButton")?.withTintColor(color)
        let highlighted = image!.withAlpha(0.7)
        
        self.setImage(image, for: .normal)
        self.setImage(highlighted, for: .highlighted)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.layer.cornerRadius = 25
        self.contentMode = .scaleAspectFill
    }
}
