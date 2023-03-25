//
//  CompletionCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class CompletionCell: UICollectionViewCell {
    
    static let identifire = "CompletionCell"
    
    private var onAction: ((UIButton) -> Void)?
    
    private let gradientLayer = CAGradientLayer()
    
    private let nameTypeLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .center,
            font: Fonts.nameGoalsCompletion)
        .setLineBreakMode(lineBreak: .byTruncatingMiddle)
    
    private let questionCountLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.stateInCellCompletion)
        .setTextColor(color: .gray)
    
    private let stackViewContainer = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .center,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        setViewHierarhies()
        setupConstraints()
        setupShadowCell()
        setupCorenerRadiusCell()
        setBackGroundColor(color: .white)
        closeButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradientLayer.frame = self.bounds
    }
    
    var isEditing: Bool = false {
        didSet {
            self.closeButton.isHidden = isEditing ? false : true
        }
    }
    
    private func setGradientLayer(with layer: CAGradientLayer, colorSet: [CGColor], locations: [Double]) {
        layer.cornerRadius = self.contentView.layer.cornerRadius
        layer.frame.origin = .zero
        
        let layerLocations = locations.map { $0 as NSNumber }
        layer.colors = colorSet
        layer.locations = layerLocations
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(nameTypeLable)
        stackViewContainer.addArrangedSubview(questionCountLable)
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        contentView.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            closeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackViewContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackViewContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    private func setupShadowCell() {
        let radius: CGFloat = 20
        layer.shadowColor = Colors.shadowColor
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 20
        contentView.layer.cornerRadius = radius
        contentView.clipsToBounds = false
    }
    
    private func setBackGroundColor(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    @objc func closeButtonAction(sender: UIButton) {
        onAction?(sender)
    }
}
extension CompletionCell: ConfigurableView {
    func configure(with model: ModelCompletionCell) {
        self.onAction = model.onAction
        self.nameTypeLable.text = model.name
        self.questionCountLable.text = "\(model.cheak) / \(model.counti)"
        
        let colors = [UIColor.decode(with: model.color.topColor).cgColor,
                      UIColor.decode(with: model.color.bottomColor).cgColor]
        setGradientLayer(with: gradientLayer, colorSet: colors, locations: [0.6, 1])
    }
    
    typealias Model = ModelCompletionCell
}
