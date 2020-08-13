//
//  Photo+Convenience.swift
//  Clouds
//
//  Created by Jonah  on 8/9/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    convenience init(
        image: Data?,
        title: String?,
        note: String?,
        timestamp: Date?,
        context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.image = image
        self.title = title
        self.note = note
        self.timestamp = timestamp
        
    }
}

