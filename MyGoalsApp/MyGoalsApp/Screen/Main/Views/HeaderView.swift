//
//  HeaderView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    static let identifire = "HeaderView"
    
    public var onAction: (() -> Void)?
    
    public var type: Section!
    
    private let header: UILabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.title)
    
    private lazy var removeAllButton = UIButton()
        .setMyStyle(backgroundColor: .red)
        .setMyTitle(text: "Remove all", state: .normal)
        .setTarget(method: #selector(removeAllButtonAction), target: self, event: .touchUpInside)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setupConstraints()
        removeAllButton.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(header)
        self.addSubview(removeAllButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            header.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            removeAllButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            removeAllButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            removeAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            removeAllButton.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    @objc func removeAllButtonAction() {
        onAction?()
    }
}
extension HeaderView: ConfigurableView {
    func configure(with model: ModelHeader) {
        self.header.text = model.header
    }
    
    typealias Model = ModelHeader
}
