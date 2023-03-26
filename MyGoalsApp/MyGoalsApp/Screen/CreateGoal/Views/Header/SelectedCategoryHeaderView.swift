//
//  SelectedCategoryHeaderView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class SelectedCategoryHeaderView: UIView {
    
    private let indent: CGFloat = 5
    
    var isSelected: Bool = true {
        didSet {
            warningLabel.isHidden = !isSelected
        }
    }
    
    private let warningLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.warnigMessage)
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.mainBackgroundColor
        warningLabel.isHidden = true
        warningLabel.textColor = .red
        setViewHierarhies()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(warningLabel)
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            warningLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -indent)
        ])
    }
    
    func setWarningLabel(category name: String?, isHidden: Bool) {
        guard let nameCategory = name else {
            self.warningLabel.text = nil
            return
        }
        warningLabel.text = "Значение \(nameCategory) должно быть больше 0, попробуйте еще раз"
        self.isSelected = isHidden
    }
}
