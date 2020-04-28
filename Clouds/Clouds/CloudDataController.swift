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
        //saveToPersistentStore()
        
    }
    
    func createCloud(category: String, subcategory: String, name: String, prefix: String, composition: String, formation: String, appearance: String, atmosphere: String, notes: String, facts: String, elevation: Int16, height: Int16) {
        
        let _ = Cloud(category: category, subcategory: subcategory, name: name, prefix: prefix, composition: composition, formation: formation, appearance: appearance, atmosphere: atmosphere, notes: notes, facts: facts, elevation: elevation, height: height)
    }
    
    func readCloudJson(_ fileName: String) {

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            NSLog("URL not useable")
            return }

            do {
                let cloudData = try Data(contentsOf: url)
                let decodedCloud = try JSONDecoder().decode([CloudObject].self, from: cloudData)
                clouds = decodedCloud
                
                for cloud in self.clouds {
                                        
                    guard let subcategory = cloud.subcategory,
                        let name = cloud.name,
                        let prefix = cloud.prefix,
                        let formation = cloud.formation,
                        let appearance = cloud.appearance,
                        let atmosphere = cloud.atmosphere,
                        let notes = cloud.notes,
                        let elevation = cloud.elevation,
                        let height = cloud.height
                    else { return }
                    
                    //let composition = clouds[0].composition,
                    // let facts = clouds[0].facts,
                    
                    self.createCloud(category: cloud.category, subcategory: subcategory, name: name, prefix: prefix, composition: "\(cloud.composition)", formation: formation, appearance: appearance, atmosphere: atmosphere, notes: notes, facts: "\(String(describing: cloud.facts))", elevation: Int16(elevation), height: Int16(height))
                }
                
                //saveToPersistentStore()
            } catch {
                NSLog("Error reading Cloud data from JSON file \(#line)")
            }
    }
}
