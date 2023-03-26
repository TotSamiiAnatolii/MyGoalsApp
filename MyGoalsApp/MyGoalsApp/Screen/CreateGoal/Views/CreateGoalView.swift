//
//  CreateGoalView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class CreateGoalView: UIView {
    
    public var tableView: UITableView!
    
    private var onAction:(() -> Void)?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.register(NameGoalCell.self, forCellReuseIdentifier: NameGoalCell.identifire)
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.identifire)
        tableView.register(TableColorCell.self, forCellReuseIdentifier: TableColorCell.identifire)
        tableView.register(SaveButtonCell.self, forCellReuseIdentifier: SaveButtonCell.identifire)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setupTableView()
        setViewHierarhies()
        setConstraints()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(closeButton)
        self.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func closeButtonAction() {
        onAction?()
    }
}
extension CreateGoalView: ConfigurableView {
    
    func configure(with model: ModelCreateGoalView) {
        self.onAction = model.onAction
    }
    
    typealias Model = ModelCreateGoalView
}
