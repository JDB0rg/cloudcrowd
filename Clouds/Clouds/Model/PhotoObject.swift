//
//  PhotoObject.swift
//  Clouds
//
//  Created by Jonah  on 6/3/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import Foundation

struct PhotoObject: Codable {
    var imageData: Data?
    var title: String?
    var note: String?
    var timeStamp: Date
}
