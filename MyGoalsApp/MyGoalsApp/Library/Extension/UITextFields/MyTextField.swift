//
//  MyTextField.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class MyTextField: UITextField {
    
    var typeCell: TextFieldsType?
    
    private let height: CGFloat = 0.5
    
    private let borderView = UIView()
        .setStyle(color: .red)
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.white.cgColor
           
        }
    }

    init(type: TextFieldsType) {
        self.typeCell = type
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .none
        borderView.isHidden = true
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(borderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addBottomBorder(isHidden: Bool) {
        borderView.isHidden = !isHidden
    }
}
