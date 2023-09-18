//
//  CoreDataManager.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "MyGoalApp")
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func receiveGoals() -> [MyGoalApp] {
        
        let request: NSFetchRequest<MyGoalApp> = MyGoalApp.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \MyGoalApp.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteGoals(goals: MyGoalApp) {
        
        viewContext.delete(goals)
        saveMyGoals()
    }
    
    func deleteColors(goals: TransformedColors) {
        
        viewContext.delete(goals)
        saveMyGoals()
    }
    
    func saveMyGoals() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch  {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func load(complition: (()->())? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            complition?()
        }
    }
}
