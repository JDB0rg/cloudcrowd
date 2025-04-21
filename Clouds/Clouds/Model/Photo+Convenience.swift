//
//  Photo+Convenience.swift
//  Clouds
//
//  Created by Jonah  on 8/9/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import CoreData
import Foundation
import UIKit


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

public class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error)")
        } else {
            print("Image saved successfully")
        }
    }
}

