//
//  MainView.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class MainView: UIView {
    
    private var onACtion: (()-> Void)?
    
    public var collectionView: UICollectionView!
    
    private lazy var addButton = AddButton()
        .setTarget(
            method: #selector(buttonAddAction),
            target: self,
            event: .touchUpInside)
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Colors.mainBackgroundColor
        collectionView.clipsToBounds = false
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        collectionView.register(MyGoalsCell.self, forCellWithReuseIdentifier: MyGoalsCell.identifire)
        collectionView.register(CompletionCell.self, forCellWithReuseIdentifier: CompletionCell.identifire)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifire)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setupCollectionView()
        setViewHierarhy()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View hierarchy
    private func setViewHierarhy() {
        self.addSubview(collectionView)
        self.addSubview(addButton)
    }
    
    //MARK: Constraints
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 45),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    @objc func buttonAddAction() {
        onACtion?()
    }
}
extension MainView: ConfigurableView {
    func configure(with model: ModelMain2View) {
        self.onACtion = model.onAction
    }
    
    typealias Model = ModelMain2View
    
    
}
