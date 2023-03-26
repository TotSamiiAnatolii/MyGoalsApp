//
//  ColorCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    static let identifire = "ColorCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        self.colorView.layer.cornerRadius = self.frame.height / 2
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    private func stateCell(isSelected: Bool) {
        guard let color = colorView.backgroundColor else {return}
        if isSelected  {
            contentView.layer.borderColor = color.cgColor
            contentView.layer.borderWidth = 2
            colorView.transform = CGAffineTransform(scaleX: 0.55, y: 0.55)
        } else {
            contentView.layer.borderWidth = 0
            colorView.transform = CGAffineTransform.identity
        }
    }
        
    override var isSelected: Bool {
        didSet {
            stateCell(isSelected: isSelected)
        }
    }
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setViewHierarhies() {
        contentView.addSubview(colorView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leftAnchor.constraint(equalTo: self.leftAnchor),
            colorView.rightAnchor.constraint(equalTo: self.rightAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
  
    public func configureCell(color: UIColor) {
        colorView.backgroundColor = color
    }
}

