//
//  MyCompositionalLayout.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

class MyCompositionalLayout {
    
    func setCompletionGoalsFlowLayout() -> NSCollectionLayoutSection  {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(100)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        return section
    }
    
    func setCurrentGoalsFlowLayout() -> NSCollectionLayoutSection {
        
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let items = NSCollectionLayoutItem(layoutSize: itemsSize)
        
        let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.36))
        
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupsSize, subitem: items, count: 1)
        
        let section = NSCollectionLayoutSection(group: groups)
        
        section.interGroupSpacing = 18
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind:  UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        return section
    }
    
     func setLayoutCollection() -> UICollectionViewLayout {
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let items = NSCollectionLayoutItem(layoutSize: itemsSize)
        
        let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.36))
        
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupsSize, subitem: items, count: 1)
        
        let section = NSCollectionLayoutSection(group: groups)
        
        section.interGroupSpacing = 18
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
