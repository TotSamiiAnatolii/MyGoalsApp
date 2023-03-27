//
//  RealizationGoalView.swift
//  MyGoalsApp
//
//  Created by APPLE on 27.03.2023.
//

import UIKit

final class RealizationGoalView: UIView {
    
    private var colors: TransformedColors
    
    private var constraint: NSLayoutConstraint?
    
    private var gradientView: GradientView
    
    private var onAction: ((MainButton) -> Void)?
    
    private let labelState = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.countGoals2)

    private let mainStackView = UIStackView()
        .myStyleStack(spacing: 20,
                      alignment: .center,
                      axis: .vertical,
                      distribution: .equalSpacing,
                      userInteraction: true)
    
    private let nameGoalsLable = UILabel()
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .center,
            font: Fonts.nameGoals)
        .setLineBreakMode(lineBreak: .byTruncatingHead)
    
    private lazy var addButton = AddButton(color: UIColor.decode(with: colors.buttonColor))
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var finishButton = UIButton()
        .setMyStyle(backgroundColor: UIColor.decode(with: colors.buttonColor))
        .setMyTitle(text: "Готово", state: .normal)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: TransformedColors, frame: CGRect) {
        self.gradientView = GradientView(color: color, frame: .zero)
        self.colors = color
        super.init(frame: frame)
        self.backgroundColor = .white
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        finishButton.isHidden = true
        setViewHierarhies()
        setConstraints()
    }
                
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }

    private func setViewHierarhies() {
        self.addSubview(gradientView)
        self.addSubview(mainStackView)
        self.addSubview(addButton)
        self.addSubview(finishButton)
        mainStackView.addArrangedSubview(nameGoalsLable)
        mainStackView.addArrangedSubview(labelState)
    }
  
    
    private func setConstraints() {
      let height = self.frame.height / 6
        
        NSLayoutConstraint.activate([
            gradientView.leftAnchor.constraint(equalTo: self.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: self.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        constraint = NSLayoutConstraint(item: gradientView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 0)
        constraint!.isActive = true
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -height)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.widthAnchor.constraint(equalToConstant: 200),
            finishButton.heightAnchor.constraint(equalToConstant: 50),
            finishButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            finishButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -height)
        ])

        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            mainStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        switch sender {
        case addButton:
            onAction?(.addButton)
        case finishButton:
            onAction?(.finished)
        default:
            break
        }
    }
    
    func manageLayer(count: CGFloat) {
        constraint?.constant = count
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
                self.gradientView.layoutIfNeeded()
        }, completion: nil)
    }
}
extension RealizationGoalView: ConfigurableView {
    
    func configure(with model: RealizationGoalViewModel) {
        
        self.nameGoalsLable.text = model.name
        self.labelState.text = "\(model.currentState) / \(model.counti)"
        self.constraint?.constant = model.height
        self.onAction = model.onAction
        if model.finish {
            addButton.isHidden = true
            labelState.text = "Winner"
            finishButton.isHidden = false
        }
    }
    
    typealias Model = RealizationGoalViewModel
}
