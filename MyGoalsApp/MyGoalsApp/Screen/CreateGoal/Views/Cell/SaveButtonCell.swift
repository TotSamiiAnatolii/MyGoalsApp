//
//  SaveButtonCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class SaveButtonCell: UITableViewCell {

    static let identifire = "SaveButtonCell"

    private let buttonLable = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.forHeader)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        buttonLable.textColor = .white
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(buttonLable)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
extension SaveButtonCell: ConfigurableView {
    func configure(with model: ModelSaveButtonCell) {
        self.buttonLable.text = model.header
        contentView.backgroundColor = model.validation ? Colors.activSaveButton : Colors.noActivSaveButton
    }
    typealias Model = ModelSaveButtonCell
}
