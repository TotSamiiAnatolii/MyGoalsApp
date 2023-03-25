//
//  ModelCompletionCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

struct ModelCompletionCell: Hashable {
    let id: UUID
    let name: String
    let cheak: Int
    let counti: Int
    let color: TransformedColors
    let onAction: ((UIButton) -> Void)
    
    
    static func == (lhs: ModelCompletionCell, rhs: ModelCompletionCell) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.cheak == rhs.cheak &&
        lhs.counti == rhs.counti &&
        lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
