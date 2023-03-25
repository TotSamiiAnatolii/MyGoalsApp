//
//  EmptyMainView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class EmptyMainView: UIView {
    
    private let messageLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .center,
            font: Fonts.messageEmptyView)
    
    private let motivationLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .center,
            font: Fonts.motivationEmptyView)
    
    private let arrowImageView = UIImageView()
        .setMyStyle()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setViewHierarhies()
        setupConstraints()
        configure(with: ModelEmptyMainView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Colors.mainBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setViewHierarhies() {
        self.addSubview(messageLabel)
        self.addSubview(motivationLabel)
        self.addSubview(arrowImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: 70),
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 70),
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -10),
            messageLabel.centerYAnchor.constraint(equalTo: arrowImageView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            motivationLabel.leftAnchor.constraint(equalTo: messageLabel.leftAnchor),
            motivationLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
            motivationLabel.rightAnchor.constraint(equalTo: messageLabel.rightAnchor)
        ])
    }
}
extension EmptyMainView: ConfigurableView {
    func configure(with model: ModelEmptyMainView) {
        self.messageLabel.text = model.title
        self.motivationLabel.text = model.subTitle
        self.arrowImageView.image = model.image
    }
    
    typealias Model = ModelEmptyMainView
}
