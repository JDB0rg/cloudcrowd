//
//  Identify+Image.swift
//  Clouds
//
//  Created by Jonah  on 3/18/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit
import CoreData

//extension IdentifyViewController: //UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
//    func presentImagePickerController() {
//        
//        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
//        
//        let imagePicker = UIImagePickerController()
//        
//        imagePicker.delegate = self
//        
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//        
//            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
//                
//                imagePicker.sourceType = .photoLibrary
//                
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//            
//            alert.addAction(photoLibraryAction)
//        }
//        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            
//            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
//                
//                imagePicker.sourceType = .camera
//                
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//            
//            alert.addAction(cameraAction)
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//    }
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    
//        guard let image = info[.originalImage] as? UIImage else { return }
//        //guard let photo = photo else { return }
//        
//        //let processedImage = image
//        cell?.CloudImageView.image = image // processedImage
//        
//        
//        let imageData = cell?.CloudImageView?.image?.pngData()
//        photo?.image = imageData
//        CoreDataStack.saveContext()
//        
//        picker.dismiss(animated: true, completion: nil)
//
//        
//    }
//    
//    func grayscaleImage(_ image: UIImage) -> UIImage? {
//        
//        if let imageFilter = CIFilter(name: "CIColorControls") {
//            
//            let startImage = CIImage(image: image)
//            imageFilter.setValue(startImage, forKey: kCIInputImageKey)
//            
//            imageFilter.setValue(0.0, forKey: "inputSaturation")
//            
//            guard let outputImage = imageFilter.outputImage,
//                let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
//            
//            return UIImage(cgImage: cgImage)
//        }
//        
//        return nil
//    }
//}

