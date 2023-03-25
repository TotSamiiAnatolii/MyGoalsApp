//
//  Formatter.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import Foundation

extension Date {
    
    func dateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate.uppercased()
    }
}
