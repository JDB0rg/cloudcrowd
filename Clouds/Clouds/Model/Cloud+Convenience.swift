//
//  Cloud+Convenience.swift
//  Clouds
//
//  Created by Madison Waters on 3/3/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import Foundation
import CoreData

extension Cloud {
    
    convenience init(category: String,
                    subcategory: String?,
                    name: String?,
                    prefix: String?,
    
                    composition: String,
                    formation: String?,
                    appearance: String?,
    
                    //weather: Weather,
                    atmosphere: String?,
    
                    notes: String?,
                    facts: String?,
                    elevation: Int16,
                    height: Int16,
                    warning: Bool = true,
                    message: String = "",
                    
                    context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.category = category
        self.subcategory = subcategory
        self.name = name
        self.prefix = prefix
        
        self.composition = composition
        self.formation = formation
        self.appearance = appearance
        
        //self.weather = weather
        self.atmosphere = atmosphere
        
        self.notes = notes
        self.facts = facts
        self.elevation = elevation
        self.height = height
        self.warning = warning
        self.message = message
    }
}
