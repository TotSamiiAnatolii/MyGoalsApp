//
//  UIColor+MyStyle.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

extension UIColor {
    
   class func decode(with data: Data) -> UIColor {
        let colorData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        
        guard let color = colorData as? UIColor  else {
            return UIColor()
        }
        return color
    }
    
    func encode() -> Data {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) else {
            return Data()
        }
        return data
    }
}
