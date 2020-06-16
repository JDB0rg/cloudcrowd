//
//  IdentifyViewController.swift
//  Clouds
//
//  Created by Madison Waters on 11/13/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class IdentifyViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    let context = CIContext(options: nil)
    var comparisonImage: UIImage?
    var photo: Photo?
    var cloud: Cloud?
    
    // MARK: - Controllers
    let cloudImageController = CloudImageController()
    
    // MARK: - Outlets
    @IBOutlet weak var compareCollectionView: UICollectionView!
    @IBOutlet weak var comparisonView: UIView!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cloudImageController.createPhoto()
        print("Remote cloud images: \(cloudImageController.remoteCloudImages)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()
        
        compareCollectionView.delegate = self
        compareCollectionView.dataSource = self
        compareCollectionView.reloadData()
        
        cloudImageController.createPhoto()
    }
    
    func setCloudImage(on cell: IdentifyCollectionViewCell) {
        cloudImageController.createPhoto()
    }
    
    // MARK: - Actions
    @IBAction func addPhotoTapped(_ sender: Any) {
        presentImagePickerController()
    }
    
    @IBAction func compareTapped(_ sender: Any) {
        
    }
    
    // MARK:  Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compareCloudCount = cloudImageController.localCloudImages.count
        if collectionView == compareCollectionView {
            return compareCloudCount
        }
        
        return compareCloudCount //fetchedIdentityResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: IdentifyCollectionViewCell.reuseIdentifier, for: indexPath) as? IdentifyCollectionViewCell else { fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)") }
//        
//        let cloudCells = fetchedIdentityResultsController.object(at: indexPath)
//        
//        let cellImage = UIImage(data: cloudCells.image ?? Data())
//        cell.CloudImageView.image = cellImage
//        cell.testLabel.text = "nice test!"
//        
//        if collectionView == compareCollectionView {
            guard let cell = compareCollectionView.dequeueReusableCell(withReuseIdentifier: CompareCollectionViewCell.reuseIdentifier, for: indexPath) as? CompareCollectionViewCell else { fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)") }
            //let cloudPhoto = cloudImageController.localCloudImages[indexPath.row]
            
            cell.compareImageView.image = cloudImageController.createPhoto()//.populateImages() 
            cell.testLabel.text = "This is a test"
            
            return cell
        //}
        
        return cell
    }
    
    // MARK: - Fetched Results Controller
    lazy var fetchedIdentityResultsController: NSFetchedResultsController<Photo> = {
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
        
        comparisonImage = info[.originalImage] as? UIImage
        //: FIXIT - setting test image here
        //testImageView.image = comparisonImage //// Set new image like this
        
        let imageData = comparisonImage?.pngData()
        photo?.image = imageData
        CoreDataStack.saveContext()
        
        // 1. Convert to binary data which can be saves to CoreData
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
}
