//
//  Cloud.swift
//  Clouds
//
//  Created by Madison Waters on 5/24/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation

struct CloudObject: Codable {
 
    var category: String
    var subcategory: String?
    var name: String?
    var prefix: String?
    
    var composition: [String]
    var formation: String?
    var appearance: String?
    
    var weather: WeatherObject?
    var atmosphere: String?
    
    var notes: String?
    var facts: [String]?
    var elevation: String?
    var height: Int?
    
    var warning: Bool = true
    var warningMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case category
        case subcategory
        case name
        case prefix
        
        case composition
        case formation
        case appearance
        
        case weather
        case atmosphere
        
        case notes
        case facts
        case elevation
        case height
        
        case warning
        case warningMessage
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        category = try container.decode(String.self, forKey: .category)
        subcategory = try container.decode(String.self, forKey: .subcategory)
        name = try container.decode(String.self, forKey: .name)
        prefix = try container.decode(String.self, forKey: .prefix)
        
        composition = [String]()
        if container.contains(.composition) {
            var compositionContainer = try container.nestedUnkeyedContainer(forKey: .composition)
            while !compositionContainer.isAtEnd {
                let component = try compositionContainer.decode(String.self)
                composition.append(component)
            }
        }
        formation = try container.decode(String.self, forKey: .formation)
        appearance = try container.decode(String.self, forKey: .appearance)
        
        atmosphere = try container.decode(String.self, forKey: .atmosphere)
        
        notes = try container.decode(String.self, forKey: .notes)
        facts = [String]()
        if container.contains(.facts) {
            var factsContainer = try container.nestedUnkeyedContainer(forKey: .facts)
            while !factsContainer.isAtEnd {
                let fact = try factsContainer.decode(String.self)
                facts?.append(fact)
            }
        }
        elevation  = try container.decode(String.self, forKey: .elevation)
        height = try container.decode(Int.self, forKey: .height)
        
        warningMessage = try container.decode(String.self, forKey: .warningMessage)
    }
}
