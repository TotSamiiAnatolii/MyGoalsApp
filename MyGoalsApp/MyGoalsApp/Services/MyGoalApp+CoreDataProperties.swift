//
//  MyGoalApp+CoreDataProperties.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//
//

import Foundation
import CoreData


extension MyGoalApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyGoalApp> {
        return NSFetchRequest<MyGoalApp>(entityName: "MyGoalApp")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var step: Int16
    @NSManaged public var totalCompleted: Int16
    @NSManaged public var colors: TransformedColors

}

extension MyGoalApp : Identifiable {

}
