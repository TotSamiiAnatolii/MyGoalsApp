//
//  EnumFroProject.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import Foundation

import Foundation

enum TypeDataSection: Int {
    case goalsName
    case goalsParametrs
    case goalsColor
    case goalsSave
    
    var numberOfRowsInSection: Int {
        switch self {
        case .goalsName:
            return 1
        case .goalsParametrs:
            return 3
        case .goalsColor:
            return 1
        case .goalsSave:
            return 1
        }
    }
}

enum TypeCell: Int {
    case quanti
    case step
    case check
    
    var nameCell: String {
        switch self {
        case .quanti:
            return "Количество"
        case .step:
            return "Шаг"
        case .check:
            return "Счет"
        }
    }
}

enum SelectGoals: String {
    case goals = "Edit"
    case editGoals = "Cancel"
}

enum Section: Int {
    case completion
    case main
    
    func setTitle() -> String {
        switch self {
        case .completion:
            return "Сompleted goals"
        case .main:
            return "Сurrent goals"
        }
    }
}

enum TextFieldsType: String {
    case name = "Твоя цель"
    case quanti = "Количество"
    case step =  "Шаг"
    case check = "Счет"
}

enum MainButton {
    case addButton
    case finished
}
