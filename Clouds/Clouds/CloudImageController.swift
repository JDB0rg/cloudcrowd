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
    
    var localCloudImages: [String] = [
        "altocumulus-lenticularis","cumulus","cumulonimbus","altocumulus2","stratocumulus_stratiformis_perlucidus_translucidus","cirrus","cirrus2","altostratus","cirrostratus","cirrocumulus","altocumulus","nimbostratus"
    ]
    var remoteCloudImages: [UIImage] = []
    var photo: Photo?
    var cloudImage: UIImage?
    var tempImage: UIImage?
    
    func createPhoto() -> UIImage {
        var returnImage: UIImage?
        let moc = CoreDataStack.context
        let pic = Photo(context: moc)
        
        for cloud in localCloudImages {
            cloudImage = UIImage(named: cloud)
            remoteCloudImages.append(cloudImage ?? UIImage() )
            cloudImage = returnImage
            if let imgData = photo?.image {
                cloudImage = UIImage(data: imgData)
            }
        }
        return cloudImage ?? UIImage()
    }
    
//    func getCategoryImage(from category: String) {
//        let imageString = category.split(separator: " ")
//        iconImage = UIImage(named: "C-\(imageString[0])")
//    }
}

