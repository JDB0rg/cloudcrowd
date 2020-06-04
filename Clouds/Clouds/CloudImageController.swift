//
//  CloudImageController.swift
//  Clouds
//
//  Created by Madison Waters on 12/10/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class CloudImageController {
    
    var localCloudImages: [String] = ["cumulus", "cumulonimbus"]
    var remoteCloudImages: [UIImage] = []
    var photo: Photo?
    var cloudImage: UIImage?
    var tempImage: UIImage?
    
    func createPhoto() {
        for cloud in localCloudImages {
            cloudImage = UIImage(named: cloud)
            remoteCloudImages.append(cloudImage ?? UIImage() )
            
            if let imgData = photo?.image {
                cloudImage = UIImage(data: imgData)
            }
        }
    }
    
    func addPhoto(image: Photo) {
        let moc = CoreDataStack.context
        let pic = Photo(context: moc)
        
        
    }
    
    func populateImages() -> UIImage? {
        for image in localCloudImages {
            tempImage = UIImage(named: image)
        }
        return tempImage
    }
}

//func flip(lightSwitch: Light) {
//    guard let lightIndex = switches.firstIndex(of: lightSwitch) else { return }
//    switches[lightIndex].isOn.toggle()
//}
