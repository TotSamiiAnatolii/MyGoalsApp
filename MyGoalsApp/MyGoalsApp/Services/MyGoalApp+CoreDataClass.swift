//
//  MyGoalApp+CoreDataClass.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//
//

import Foundation
import CoreData

@objc(MyGoalApp)
public class MyGoalApp: NSManagedObject {
    var finish: Bool {
        return self.totalCompleted == self.amount
    }
}
