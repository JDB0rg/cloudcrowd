//
//  CloudImageController.swift
//  Clouds
//
//  Created by Madison Waters on 12/10/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudImageController {
    
    var localCloudImages: [Photo] = []
    var remoteCloudImages: [UIImage] = []
    
    func createPhoto() {
        let moc = CoreDataStack.context
        CoreDataStack.saveContext()
//        var temp = photo
//        guard let imageIndex = localCloudImages.firstIndex(of: photo) else { return }
//        temp = UIImage(data: localCloudImages[imageIndex].image ?? Data() )
        
    }
    
    func addPhoto(image: Photo) {
        
        
    }
}

//func flip(lightSwitch: Light) {
//    guard let lightIndex = switches.firstIndex(of: lightSwitch) else { return }
//    switches[lightIndex].isOn.toggle()
//}
