//
//  TransformedColors+CoreDataProperties.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//
//

import Foundation
import CoreData


extension TransformedColors {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransformedColors> {
        return NSFetchRequest<TransformedColors>(entityName: "TransformedColors")
    }

    @NSManaged public var bottomColor: Data
    @NSManaged public var buttonColor: Data
    @NSManaged public var topColor: Data
    @NSManaged public var visualColor: Data
    @NSManaged public var goals: MyGoalApp?

}

extension TransformedColors : Identifiable {

}
