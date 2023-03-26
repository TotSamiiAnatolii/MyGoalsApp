//
//  NameGoalCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class NameGoalCell: UITableViewCell {
    
    static let identifire = "NameGoalsCell"
    
    public lazy var mainTextField = MyTextField(type: .name)
        .setMyStyle(
            textAligment: .left,
            font: UIFont.boldSystemFont(ofSize: 20))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViewHierarhies() {
        contentView.addSubview(mainTextField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
extension NameGoalCell: ConfigurableView {
    func configure(with model: ModelNameGoalsCell) {
        mainTextField.attributedPlaceholder = NSAttributedString(string: model.placeholder, attributes: [NSAttributedString.Key.font : Fonts.forHeader])
    }
    
    typealias Model = ModelNameGoalsCell
}
