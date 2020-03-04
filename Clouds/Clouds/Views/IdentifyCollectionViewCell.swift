//
//  IdentifyCollectionViewCell.swift
//  Clouds
//
//  Created by Madison Waters on 3/3/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit

class IdentifyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CloudImageView: UIImageView!
}

extension IdentifyCollectionViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        guard let image = info[.originalImage] as? UIImage else { return }
        let processedImage = image
        CloudImageView.image = processedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
