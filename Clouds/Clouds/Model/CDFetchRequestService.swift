//
//  CDFetchRequestService.swift
//  Clouds
//
//  Created by Jonah on 4/24/25.
//  Copyright © 2025 EmPact. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FetchedResultsControllerSingleton {
       // Shared instance of the singleton
    
    static let shared = FetchedResultsControllerSingleton()
    let managedContext: NSManagedObjectContext
    let fetchRequest: NSFetchRequest<Cloud>

       // Private initializer to prevent direct instantiation
    private init() {
        // Get the managed object context from your Core Data stack
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        self.managedContext = appDelegate.moc

        // Initialize the fetch request for the 'Cloud' entity
        let request: NSFetchRequest<Cloud> = Cloud.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)] // adjust key as needed
        self.fetchRequest = request
    }

    private lazy var fetchedResultsController: NSFetchedResultsController<Cloud> = {
        let managedObjectContext = managedContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: managedContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()

   // Accessor for the fetched results controller
   func getFetchedResultsController() -> NSFetchedResultsController<Cloud> {
       return fetchedResultsController
   }

   // Function to perform the initial fetch (called once when needed)
   func performInitialFetch() throws {
       try fetchedResultsController.performFetch()
   }
}

class CDFetchRequestService {
    let managedContext: NSManagedObjectContext
    let fetchRequest: NSFetchRequest<Cloud>

    lazy var fetchedResultsController: NSFetchedResultsController<Cloud> = {
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                            managedObjectContext: managedContext,
                                            sectionNameKeyPath: nil,
                                            cacheName: nil)
        return frc
    }()

    init(managedContext: NSManagedObjectContext, fetchRequest: NSFetchRequest<Cloud>) {
        self.managedContext = managedContext
        self.fetchRequest = fetchRequest
    }
}
