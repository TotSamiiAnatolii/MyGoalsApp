//
//  ModelGoalValidation.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import Foundation

struct GoalValidation {
    
    var name: String = ""
    var quanti: Int16 = 0
    var step: Int16 = 0
    var check: Int16 = 0
    
    var topColor = Colors.greenColor.topColor.encode()
    var bottomColor = Colors.greenColor.bottomColor.encode()
    var buttonColor = Colors.greenColor.buttonColor.encode()
    var visualColor = Colors.greenColor.visualColor.encode()
    
    func isValidate() -> Bool {
        if !self.name.isEmpty &&
            self.quanti > 0 &&
            self.step > 0 &&
            self.check >= 0 {
            return true
        }
        return false
    }
    
    mutating func setNewColor(color: TransformedColor) {
        self.topColor = color.topColor.encode()
        self.bottomColor = color.bottomColor.encode()
        self.buttonColor = color.buttonColor.encode()
        self.visualColor = color.visualColor.encode()
    }
}
