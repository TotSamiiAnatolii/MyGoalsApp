//
//  EmptyDiffableDataSource.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

final class EmptyDiffableDataSource<S, T>: UICollectionViewDiffableDataSource<S, T> where S: Hashable, T: Hashable {
    
    private var collectionView: UICollectionView
    
    private var mainEmptyView: UIView
    private var completionEmptyView: UIView
    
    private var copletionHeader = UIView()
    private var mainHeader = UIView()
    
    init(collectionView: UICollectionView,
         cellProvider: @escaping UICollectionViewDiffableDataSource<S, T>.CellProvider,
         mainEmptyView: UIView, completionEmptyView: UIView
    ) {
        self.collectionView = collectionView
        self.mainEmptyView = mainEmptyView
        self.completionEmptyView = completionEmptyView
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    override func apply(_ snapshot: NSDiffableDataSourceSnapshot<S, T>, animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
        super.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
 
        collectionView.subviews.forEach { view in
            
            guard let header = view as? HeaderView else {
                return
            }
            
            switch header.type {
            case .completion:
                copletionHeader = view
            case .main:
                mainHeader = view
            case .none:
                break
            }
        }
        
        guard let copletionSection = Section.completion as? S else {
            return
        }
        
        if snapshot.numberOfItems(inSection: copletionSection) == 0 {

            collectionView.addSubview(completionEmptyView)
            
            NSLayoutConstraint.activate([
                completionEmptyView.topAnchor.constraint(equalTo: copletionHeader.bottomAnchor),
                completionEmptyView.trailingAnchor.constraint(equalTo: collectionView.layoutMarginsGuide.trailingAnchor),
                completionEmptyView.bottomAnchor.constraint(equalTo: mainHeader.topAnchor),
                completionEmptyView.leadingAnchor.constraint(equalTo: collectionView.layoutMarginsGuide.leadingAnchor)
            ])
        } else {
            completionEmptyView.removeFromSuperview()
        }
        
        guard let mainSection = Section.main as? S else {
            return
        }
        
        if snapshot.numberOfItems(inSection: mainSection) == 0 {
                        
            collectionView.addSubview(mainEmptyView)
            
            NSLayoutConstraint.activate([
                mainEmptyView.topAnchor.constraint(equalTo: mainHeader.layoutMarginsGuide.bottomAnchor),
                mainEmptyView.trailingAnchor.constraint(equalTo: collectionView.layoutMarginsGuide.trailingAnchor),
                mainEmptyView.bottomAnchor.constraint(equalTo: collectionView.layoutMarginsGuide.bottomAnchor),
                mainEmptyView.leadingAnchor.constraint(equalTo: collectionView.layoutMarginsGuide.leadingAnchor)
            ])
        } else {
            mainEmptyView.removeFromSuperview()
        }
    }
}
