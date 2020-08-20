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
        return fetchedResultsController.fetchedObjects?.count ?? 0
        //return cloudDataController?.clouds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: IdentifyCollectionViewCell.reuseIdentifier, for: indexPath) as? IdentifyCollectionViewCell else { fatalError("Error dequeueing Cloud Image Cell in file: \(#file) at line: \(#line)") }
        
        let cloudCells = fetchedResultsController.object(at: indexPath) // cloudDataController?.clouds[indexPath.row]
        
        let cellImage = UIImage(data: cloudCells.image!)
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
    
}
