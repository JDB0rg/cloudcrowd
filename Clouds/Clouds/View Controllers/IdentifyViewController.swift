//
//  IdentifyViewController.swift
//  Clouds
//
//  Created by Madison Waters on 11/13/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class IdentifyViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CloudImageDelegate {
    
    // MARK: - Properties
    let context = CIContext(options: nil)
    var comparisonImage: UIImage?
    var comparisonCell: IdentifyCollectionViewCell?
    var photo: Photo?
    var cell: IdentifyCollectionViewCell?
    
    // MARK: - Controllers
    let cloudImageController = CloudImageController()
    
    // MARK: - Outlets
    @IBOutlet weak var comparisonView: UIView!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    func setCloudImage(on cell: IdentifyCollectionViewCell) {
        //guard let indexPath = photoCollectionView.indexPath(for: cell) else { return }
        guard let photo = photo else { return }
        cloudImageController.createPhoto()
    }
    
    // MARK: - Actions
    @IBAction func addPhotoTapped(_ sender: Any) {
        presentImagePickerController()
    }
    
    @IBAction func compareTapped(_ sender: Any) {
        
    }
        
    // MARK: Collection View Controller Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      fetchedResultsController.fetchedObjects?.count ?? 0
    }

    let reuseIdentifier = "ComparisonImageCell"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard var cell = cell else {
          fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)")
      }
      cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IdentifyCollectionViewCell
      
      let comparisonImage = fetchedResultsController.object(at: indexPath)
      let cellImage = UIImage(data: comparisonImage.image ?? Data())
      cell.CloudImageView.image = cellImage
      
      return cell
    }
    
    // MARK: - Fetched Results Controller
    lazy var fetchedResultsController: NSFetchedResultsController<Photo> = {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "image", ascending: true) ]
        
        let moc = CoreDataStack.context
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()
    
    // MARK: - Fetched Results Controller Delegate Methods
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { return }
            photoCollectionView.insertItems(at: [indexPath])//.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            photoCollectionView.deleteItems(at: [indexPath])
        case .move:
            guard let oldIndexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            photoCollectionView.moveItem(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            photoCollectionView.reloadItems(at: [indexPath])
        @unknown default:
            fatalError("Error: Unknown type case in file: \(#file) at line: \(#line)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
        guard let image = info[.originalImage] as? UIImage else { return }
        
        testImageView.image = image
        cell?.CloudImageView.image = image
        CoreDataStack.saveContext()
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
}
