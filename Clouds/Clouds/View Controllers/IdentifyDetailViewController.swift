//
//  IdentifyDetailViewController.swift
//  Clouds
//
//  Created by Jonah  on 8/15/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit

class IdentifyDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    let context = CIContext(options: nil)
    var comparisonImage: UIImage?
    var photo: Photo?
    
    // MARK: - Controllers
    var cloudImageController: CloudImageController?
    
    // MARK: - Outlets
    @IBOutlet weak var CloudImageView: UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TitleInputLabel: UILabel!
    @IBOutlet weak var TitleTextField: UITextField!
    
    @IBOutlet weak var NotesLabel: UILabel!
    @IBOutlet weak var NotesInputLabel: UILabel!
    @IBOutlet weak var NotesTextView: UITextView!
    
    @IBOutlet weak var EditButton: UIBarButtonItem!
    @IBOutlet weak var AddPhotoButton: UIButton!
    
    @IBAction func EditButtonTapped(_ sender: Any) {
        toggleHidden()
    }
    
    @IBAction func AddPhotoTapped(_ sender: Any) {
        presentImagePickerController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleTextField.isHidden = true
        NotesTextView.isHidden = true
        setupTheme()
    }
    
    private func toggleHidden() {
        TitleTextField.isHidden = !TitleTextField.isHidden
        NotesTextView.isHidden = !NotesTextView.isHidden
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func presentImagePickerController() {
        
        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
                
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alert.addAction(photoLibraryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alert.addAction(cameraAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        comparisonImage = info[.originalImage] as? UIImage
        //: FIXIT - setting test image here
        
        guard let image = comparisonImage else { return }
        guard let imageData = image.pngData() else { return }
        
        photo?.image = imageData
        cloudImageController?.createPhoto(image: imageData, title: "", note: "")
        CoreDataStack.saveContext()
        
        
        // 1. Convert to binary data which can be saved to CoreData
        // 2. Fetch from CD and put into the Collection view.
        //let photo = Photo(entity: NSEntityDescription, insertInto: NSManagedObjectContext?)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func grayscaleImage(_ image: UIImage) -> UIImage? {
        
        if let imageFilter = CIFilter(name: "CIColorControls") {
            let startImage = CIImage(image: image)
            imageFilter.setValue(startImage, forKey: kCIInputImageKey)
            imageFilter.setValue(0.0, forKey: "inputSaturation")
            
            guard let outputImage = imageFilter.outputImage,
                let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    private func setupTheme() {
        AddPhotoButton.layer.cornerRadius = 0.5 * AddPhotoButton.bounds.size.width
        AddPhotoButton.clipsToBounds = true
    }
}
