//
//  CloudImageController.swift
//  Clouds
//
//  Created by Madison Waters on 12/10/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudImageController {
    
    var localCloudImages: [UIImage] = []
    var remoteCloudImages: [UIImage] = []
    
    func add(image: UIImage) {
        localCloudImages.append(image)
    }
}
