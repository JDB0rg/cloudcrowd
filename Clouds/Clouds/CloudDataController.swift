//
//  CloudDataController.swift
//  Clouds
//
//  Created by Madison Waters on 10/22/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation

class CloudDataController {
    
    var cloudArray: [Cloud] = []
    
    func readCloudJson(_ fileName: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            NSLog("URL not useable")
            return }
        
            do {
                let cloudData = try Data(contentsOf: url)
                let cloudObject = try JSONDecoder().decode(Cloud.self, from: cloudData)
                cloudArray.append(cloudObject)
            } catch {
                NSLog("Error reading Cloud data from JSON file")
            }
        }

}
