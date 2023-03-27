//
//  RealizationGoalViewModel.swift
//  MyGoalsApp
//
//  Created by APPLE on 27.03.2023.
//

import UIKit

struct RealizationGoalViewModel {
    
    let name: String
    var currentState: String
    let counti: String
    let topColor: CGColor
    let bottomColor: CGColor
    let buttonColor: UIColor
    let height: CGFloat
    let finish: Bool
    let onAction: ((MainButton) -> Void)
}
