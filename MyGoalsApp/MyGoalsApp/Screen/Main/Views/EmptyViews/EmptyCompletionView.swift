//
//  EmptyCompletionView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class EmptyCompletionView: UIView {

    private let motivationLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .center,
            font: Fonts.motivationEmptyView)
    
    private let smileImageView = UIImageView()
        .setMyStyle()

    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setupView()
        setViewHierarhies()
        setupConstraints()
        configure(with: ModelEmtyCompletionView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Colors.mainBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setViewHierarhies() {
        self.addSubview(containerStackView)
        containerStackView.addArrangedSubview(smileImageView)
        containerStackView.addArrangedSubview(motivationLabel)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            smileImageView.widthAnchor.constraint(equalToConstant: 40),
            smileImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
extension EmptyCompletionView: ConfigurableView {
    func configure(with model: ModelEmtyCompletionView) {
        self.motivationLabel.text = model.title
        self.smileImageView.image = model.image
    }
    typealias Model = ModelEmtyCompletionView
}
