//
//  ModelMyGoalsCell.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

struct ModelMyGoalsCell: Hashable {
    let id: UUID
    let name: String
    let date: Date
    let cheak: Int
    let counti: Int
    let color: UIColor
    let onAction: ((UIButton) -> Void)
    var state: Int {
        if counti > 0 {
            return Int((cheak * 100) / counti)
        }
        return 0
    }
    
    static func == (lhs: ModelMyGoalsCell, rhs: ModelMyGoalsCell) -> Bool {
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
