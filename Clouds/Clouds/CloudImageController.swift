//
//  CloudImageController.swift
//  Clouds
//
//  Created by Madison Waters on 12/10/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudImageController {
    
    var localCloudImages: [String] = ["cumulus", "cumulonimbus"]
    var remoteCloudImages: [UIImage] = []
    var photo: Photo?
    var cloudImage: UIImage?
    
    func createPhoto() {
        for clouds in localCloudImages {
            cloudImage = UIImage(named: clouds)
            remoteCloudImages.append(cloudImage ?? UIImage() )
        }
    }
    
    func addPhoto(image: Photo) {
        
        
    }
}

//func flip(lightSwitch: Light) {
//    guard let lightIndex = switches.firstIndex(of: lightSwitch) else { return }
//    switches[lightIndex].isOn.toggle()
//}
