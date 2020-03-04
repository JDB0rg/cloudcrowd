//
//  IdentifyViewController.swift
//  Clouds
//
//  Created by Madison Waters on 11/13/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class IdentifyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    private var comparisonImage: UIImage?
    var comparisonCell: IdentifyCollectionViewCell?
    var photo: Photo?
    
    // MARK: - Outlets
    @IBOutlet weak var comparisonView: UIView!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func addPhotoTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library is unavailable")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func compareTapped(_ sender: Any) {
        
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
    
    // MARK: UIImage Picker Controller Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        comparisonImage = info[.originalImage] as? UIImage
        comparisonCell?.CloudImageView.image = comparisonImage
        
        let imageData = comparisonImage?.pngData()
        guard let photo = photo else { return }
        photo.image = imageData
        CoreDataStack.saveContext()
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Collection View Controller Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    let reuseIdentifier = "ComparisonImageCell"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? IdentifyCollectionViewCell else {
            fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)")
        }
        let comparisonImage = fetchedResultsController.object(at: indexPath)
        let cellImage = UIImage(data: comparisonImage.image ?? Data())
        cell.CloudImageView.image = cellImage
        
        return cell
    }
    
    // MARK: - Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        //photoCollectionView.
    }
    
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
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        //photoCollectionView.endUpdates()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
