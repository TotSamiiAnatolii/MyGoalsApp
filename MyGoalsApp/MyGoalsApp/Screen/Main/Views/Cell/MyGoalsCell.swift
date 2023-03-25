//
//  MyGoalsCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

let π = CGFloat.pi

final class MyGoalsCell: UICollectionViewCell {
    
    static let identifire = "MyGoalsCell"
    
    private var onAction: ((UIButton) -> Void)?
    
    private let colore = #colorLiteral(red: 0.8906016935, green: 0.8906016935, blue: 0.8906016935, alpha: 1)
    
    private var shapeLayer = CAShapeLayer()
    
    private var shapeLayerBackground = CAShapeLayer()
    
    private let indent: CGFloat = 20
    
    var isEditing: Bool = false {
        didSet {
            self.deleteButton.isHidden = isEditing ? false : true
            self.isSelected = isEditing ? false : true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.deleteButton.isSelected = isSelected ? true : false
        }
    }
    
    private let viewContainer = UIView()
        .setStyle(color: .white)
    
    private let nameTypeLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.cellNameGoals)
        .setLineBreakMode(lineBreak: .byTruncatingMiddle)
    
    private let questionCountLable = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.stateInCell)
        .setTextColor(color: .gray)
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
        .setLayoutMargins(top: 0, left: 25, bottom: 0, right: 0)
    
    private let stateLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.percent)
    
    private let dateLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.date)
    
    private lazy var deleteButton = DeleteButton()
        .setShadow(color: UIColor.black.cgColor,
                    width: 0.1,
                    height: 2.0,
                    radius: 3,
                    opacity: 3)
        .setTarget(method: #selector(deleteButtonAction), target: self, event: .touchDown)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackGroundColor(color: .white)
 
        self.deleteButton.isHidden = false
        setupShadowCell()
        setupCorenerRadiusCell()
        setViewHierarhies()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        trajectoryShape()
        progressBar()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var view = deleteButton.hitTest(deleteButton.convert(point, from: self), with: event)
        
        if view == nil {
            view = super.hitTest(point, with: event)
        }
        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) {
            return true
        }
        return !deleteButton.isHidden && deleteButton.point(inside: deleteButton.convert(point, from: self), with: event)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
        viewContainer.layer.cornerRadius =  viewContainer.frame.height / 2
        addDropShadow(color: colore , offset: CGSize(width: 1, height: 1), btnLayer: shapeLayerBackground)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.deleteButton.isSelected = false
    }
    
    private func addDropShadow(color: UIColor, offset: CGSize, btnLayer: CALayer) {
        btnLayer.masksToBounds = false
        btnLayer.shadowColor = color.cgColor
        btnLayer.shadowOpacity = 4
        btnLayer.shadowOffset = offset
        btnLayer.shadowRadius = 2
    }
    
    private func trajectoryShape() {
        let radius: CGFloat = 45
        let centr = CGPoint(x: viewContainer.frame.width / 2, y: viewContainer.frame.height / 2)
        let startAngle = -π / 2
        let endAngle = (3 * π) / 2
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayerBackground.path = circularPath.cgPath
        shapeLayerBackground.lineWidth = 9
        shapeLayerBackground.fillColor = UIColor.clear.cgColor
        shapeLayerBackground.strokeEnd = 1
        shapeLayerBackground.strokeColor = Colors.circularProgress
        shapeLayerBackground.lineCap = .round
    }
    
    private func progressBar() {
        let radius: CGFloat = 45
        let centr = CGPoint(x: viewContainer.frame.width / 2, y: viewContainer.frame.height / 2)
        let startAngle = -π / 2
        let endAngle = (3 * π) / 2
        
        let circularPath = UIBezierPath(arcCenter: centr, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 9
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
    }
    
    private func recognizer (value: Float) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = value / 100
        basicAnimation.duration = 0.1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urS")
    }
    
    private func setViewHierarhies() {
        
        contentView.addSubview(viewContainer)
        contentView.addSubview(containerStackView)
        contentView.addSubview(dateLabel)
      
        viewContainer.addSubview(stateLabel)
        viewContainer.layer.addSublayer(shapeLayerBackground)

        viewContainer.layer.addSublayer(shapeLayer)
        containerStackView.addArrangedSubview(nameTypeLable)
        containerStackView.addArrangedSubview(questionCountLable)
        contentView.addSubview(deleteButton)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            viewContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            viewContainer.widthAnchor.constraint(equalTo: viewContainer.heightAnchor),
            viewContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indent)
        ])

        NSLayoutConstraint.activate([
            containerStackView.leftAnchor.constraint(equalTo: viewContainer.rightAnchor),
            containerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent)
        ])

        NSLayoutConstraint.activate([
            stateLabel.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            stateLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 22)
        ])
    }
    
    @objc func deleteButtonAction(sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        onAction?(sender)
    }
}
extension MyGoalsCell: ConfigurableView {
    func configure(with model: ModelMyGoalsCell) {
        self.nameTypeLable.text = model.name
        self.questionCountLable.text = "\(model.cheak) / \(model.counti)"
        self.shapeLayer.strokeColor = model.color.cgColor
        self.stateLabel.text = "\(model.state)%"
        self.onAction = model.onAction
        self.recognizer(value: Float(model.state))
        self.dateLabel.text = model.date.dateFormatter()
    }
    typealias Model = ModelMyGoalsCell
}
