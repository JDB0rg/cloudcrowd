//
//  ViewController.swift
//  Clouds
//
//  Created by Madison Waters on 5/24/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit
import CoreData

class CloudHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    enum CellType: String {
        case contentCell
        case headerCell
    }
    
    @IBOutlet weak var cloudLogoView: UIView!
    @IBOutlet weak var cloudTableView: UITableView!
    
    var cloudController = CloudDataController()
    var weatherController = WeatherController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        cloudTableView.separatorStyle = .none
        cloudTableView.delegate = self
        cloudTableView.dataSource = self
        
        print(cloudController.readCloudJson("CloudData"))
        
        //weatherController.fetchWeather(lon: 139, lat: 35)
    }
    
    // MARK: - Fetched Results Controller
    lazy var fetchedResultsController: NSFetchedResultsController<Cloud> = {
        let fetchRequest: NSFetchRequest<Cloud> = Cloud.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "category", ascending: true)]
        
        let moc = CoreDataStack.context
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()
    
    // MARK: - TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
        //return cloudController.clouds.count
    }
    
    let reuseIdentifier = "CloudCell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CloudHomeTableViewCell else {
            fatalError("Error dequeueing Cloud Cell in file: \(#file) at line: \(#line)")
        }
        
        let cloud = fetchedResultsController.object(at: indexPath)
        //let cloud = cloudController.clouds[indexPath.row]
        
        cell.titleLabel.text = cloud.name
        cell.subtitleLabel.text = cloud.category
        cell.infoLabel.text = cloud.description
        
        setupCellTheme(cell)
        
        return cell
    }
    
    // MARK: - Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        cloudTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            guard let indexPath = newIndexPath else { return }
            cloudTableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            cloudTableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            cloudTableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            cloudTableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError("Error: Unknown type case in file: \(#file) at line: \(#line)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        cloudTableView.endUpdates()
    }
    
    // MARK: - Private Methods
    private func decodeCloud(_ file: String) {
        cloudController.readCloudJson(file)
    }
    
    private func setupCellTheme(_ cell: CloudHomeTableViewCell) {
        cell.contentView.clipsToBounds = true
        cell.cloudImageView.layer.cornerRadius = 20
        cell.containerView.setViewShadow(color: UIColor.black,
                                         opacity: 0.3,
                                         offset: CGSize(width: 1, height: 3),
                                         radius: 5,
                                         viewCornerRadius: 20)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCloudDetail" {
            guard let cloudDetailVC = segue.destination as? CloudDetailViewController,
            let indexPath = cloudTableView.indexPathForSelectedRow else { return }
            let cloud = cloudController.clouds[indexPath.row]
            cloudDetailVC.cloud = cloud
            cloudDetailVC.cloudController = cloudController
        }
    }
}

