//
//  Cloud.swift
//  Clouds
//
//  Created by Madison Waters on 5/24/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation

struct Cloud: Codable {
    
    var name: String
    var prefix: String
    
    var composition: String
    var appearance: String
    var description: String
    
    var weather: String
    var atmosphere: String
    
    var notes: String
    var facts: [String]
    var elevation: Int
    var height: Int
    var warning: Bool
    
}
