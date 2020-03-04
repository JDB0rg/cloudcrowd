//
//  CoreDataStack.swift
//  Clouds
//
//  Created by Madison Waters on 2/20/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Clouds")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error with Core Data Stack\(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    class func saveContext() {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error saving Core Data context\(error), \(nsError.userInfo)")
        }
    }
}
