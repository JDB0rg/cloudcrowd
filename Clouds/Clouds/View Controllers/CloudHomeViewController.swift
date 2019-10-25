//
//  ViewController.swift
//  Clouds
//
//  Created by Madison Waters on 5/24/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum CellType: String {
        case contentCell
        case headerCell
    }
    
    @IBOutlet weak var cloudLogoView: UIView!
    @IBOutlet weak var cloudTableView: UITableView!
    
    var cloudController = CloudDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cloudTableView.separatorStyle = .none
        cloudTableView.delegate = self
        cloudTableView.dataSource = self
        
        decodeCloud("Cumulus")
    }
    
    // MARK: - TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cloudController.cloudArray.count
    }
    
    let reuseIdentifier = "CloudCell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CloudHomeTableViewCell else { fatalError() }
        
        let cloud = cloudController.cloudArray[indexPath.row]
        
        cell.titleLabel.text = cloud.subcategory
        cell.subtitleLabel.text = cloud.category
        cell.infoLabel.text = cloud.description
        
        setupCellTheme(cell)
        
        return cell
    }
    
    // MARK: - Private Methods
    private func decodeCloud(_ file: String) {
        cloudController.readCloudJson(file)
    }
    
    private func setupCellTheme(_ cell: CloudHomeTableViewCell) {
    
    cell.containerView.setViewShadow(color: UIColor.black, opacity: 0.3, offset: CGSize(width: 1, height: 3), radius: 5, viewCornerRadius: 20)
    cell.contentView.clipsToBounds = true
    cell.cloudImageView.layer.cornerRadius = 20
    }
}

