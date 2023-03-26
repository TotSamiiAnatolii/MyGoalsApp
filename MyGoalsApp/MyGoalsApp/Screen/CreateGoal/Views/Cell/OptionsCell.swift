//
//  OptionsCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class OptionsCell: UITableViewCell {
    
    static let identifire = "OptionsCell"

    private let categoryLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.optionsCell)
    
    public lazy var mainTextField = MyTextField()
        .setMyStyle(
            textAligment: .center,
            font: Fonts.forHeader)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        mainTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.font : Fonts.forHeader])
        mainTextField.keyboardType = .decimalPad
     
        mainTextField.layer.cornerRadius = 10
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(categoryLable)
        contentView.addSubview(mainTextField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            mainTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            mainTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25)
        ])
    }
}
extension OptionsCell: ConfigurableView {
    func configure(with model: ModelOptionsCell) {
        self.categoryLable.text = model.nameCategory
        self.mainTextField.typeCell = model.typeCell
    }
    typealias Model = ModelOptionsCell
}
