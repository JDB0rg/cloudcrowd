//
//  CloudDataController.swift
//  Clouds
//
//  Created by Madison Waters on 10/22/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation

class CloudDataController {
    
    init() {
        self.decodeClouds()
    }
    
    var clouds: [CloudObject] = []
    
    var cloudDataArray: [String] = ["Cumulus", "Cumulonimbus"]
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func decodeClouds() {
        readCloudJson("CloudData")
        saveToPersistentStore()
        
    }
    
    func readCloudJson(_ fileName: String) {

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            NSLog("URL not useable")
            return }

            do {
                let cloudData = try Data(contentsOf: url)
                let decodedCloud = try JSONDecoder().decode([CloudObject].self, from: cloudData)
                clouds = decodedCloud
                saveToPersistentStore()
            } catch {
                NSLog("Error reading Cloud data from JSON file")
            }
        }

}
