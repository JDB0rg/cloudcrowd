//
//  IdentifyViewController.swift
//  Clouds
//
//  Created by Madison Waters on 11/13/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class IdentifyViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,  Injectable{
    
   
        // MARK: - Properties
        let context = CIContext(options: nil)
        var comparisonImage: UIImage?
        var photo: Photo?
        var cloud: Cloud?
        
        // MARK: - Controllers
        var cloudImageController: CloudImageController?
        var cloudDataController: CloudDataController?
        
        // MARK: - Outlets
        @IBOutlet weak var photoCollectionView: UICollectionView!
        
        override func viewDidAppear(_ animated: Bool) {
            photoCollectionView?.reloadData()
            
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
            photoCollectionView.reloadData()
            
            cloudImageController?.setIdCloudImages()
        }
        
        // MARK: - Actions
        @IBAction func addPhotoTapped(_ sender: Any) {
            //presentImagePickerController()
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
        
        // MARK:  Collection View
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //return fetchedResultsController.fetchedObjects?.count ?? 0
            return cloudImageController?.deviceCloudImages.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: IdentifyCollectionViewCell.reuseIdentifier, for: indexPath) as? IdentifyCollectionViewCell else { fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)") }
            
            let cloudCells = cloudImageController?.deviceCloudImages[indexPath.row]
            // fetchedResultsController.object(at: indexPath) // cloudDataController?.clouds[indexPath.row]
            
            let cellImage = cloudCells
            cell.testLabel.text = "nice test!"
            cell.CloudImageView?.image = cellImage
            
            return cell
        }
        
        func inject(data: AnyObject) {
            self.cloudImageController = data as? CloudImageController
            self.cloudDataController = data as? CloudDataController
            
        }
        
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
        
        
         // MARK: - Navigation
              override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
        
    
//    // MARK: - Properties
//
//    let fetchRequestSingleton = FetchedResultsControllerSingleton.shared
//    lazy var fetchedResultsController = fetchRequestSingleton.getFetchedResultsController()
//    var stuff: NSFetchedResultsController<Cloud>?
//
//    let context = CIContext(options: nil)
//    var comparisonImage: UIImage?
//    var photo: Photo?
//    var cloud: Cloud?
//
//    // MARK: - Controllers
//    var cloudImageController: CloudImageController?
//    var cloudDataController: CloudDataController?
//
//    // MARK: - Outlets
//    @IBOutlet weak var photoCollectionView: UICollectionView!
//
//    override func viewDidAppear(_ animated: Bool) {
//        photoCollectionView?.reloadData()
//
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        photoCollectionView.delegate = self
//        photoCollectionView.dataSource = self
//        photoCollectionView.reloadData()
//
//        cloudImageController?.setIdCloudImages()
//
//        stuff = fetchRequestSingleton.getFetchedResultsController()
//    }
//
//    // MARK: - Actions
//    @IBAction func addPhotoTapped(_ sender: Any) {
//        //presentImagePickerController()
//    }
//
//    // MARK: - Fetched Results Controller
//
//
//    // MARK:  Collection View
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return stuff?.fetchedObjects?.count ?? 0 // fetchRequestSingleton.fetchedResultsController.fetchedObjects?.count ?? 0
////        return cloudImageController?.deviceCloudImages.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: IdentifyCollectionViewCell.reuseIdentifier, for: indexPath) as? IdentifyCollectionViewCell else { fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)") }
//
////        let cloudCells = cloudImageController?.deviceCloudImages[indexPath.row]
////        fetchedResultsController.object(at: indexPath) // cloudDataController?.clouds[indexPath.row]
//
//        let cloud = fetchedResultsController.object(at: indexPath)
//
////        let cellImage = cloudCells
////        cell.CloudImageView?.image = cloud
//
//        guard let name = cloud.name else { return UICollectionViewCell() }
//        cell.CloudImageView?.image = UIImage(named: name.lowercased())?.circleMasked
//        cell.testLabel.text = cloud.name
//
//        return cell
//    }
//
//    func inject(data: AnyObject) {
//        self.cloudImageController = data as? CloudImageController
//        self.cloudDataController = data as? CloudDataController
//
//    }
//
//    // MARK: - Fetched Results Controller Delegate Methods
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//        switch type {
//        case .insert:
//            guard let indexPath = newIndexPath else { return }
//            photoCollectionView.insertItems(at: [indexPath])//.insertRows(at: [indexPath], with: .automatic)
//        case .delete:
//            guard let indexPath = indexPath else { return }
//            photoCollectionView.deleteItems(at: [indexPath])
//        case .move:
//            guard let oldIndexPath = indexPath else { return }
//            guard let newIndexPath = newIndexPath else { return }
//            photoCollectionView.moveItem(at: oldIndexPath, to: newIndexPath)
//        case .update:
//            guard let indexPath = indexPath else { return }
//            photoCollectionView.reloadItems(at: [indexPath])
//        @unknown default:
//            fatalError("Error: Unknown type case in file: \(#file) at line: \(#line)")
//        }
//    }
//
//
//     // MARK: - Navigation
//          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
    
}
