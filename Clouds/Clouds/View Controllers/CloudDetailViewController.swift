//
//  CloudDetailViewController.swift
//  Clouds
//
//  Created by Madison Waters on 11/13/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudDetailViewController: UIViewController {

    var cloudController: CloudDataController?
    
    var cloud: CloudObject? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subcategoryLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let cloudData = cloudController?.readCloudJson("Cumulus")
    }
    
    private func updateViews() {
        guard let cloud = cloud,
        isViewLoaded else { return }
        
        nameLabel.text = cloud.name
        subcategoryLabel.text = cloud.subcategory
        
        heightLabel.text = String(describing: cloud.height)
        elevationLabel.text = String(describing: cloud.elevation)
        let compString = cloud.composition.map({ $0 })
        compositionLabel.text = "\(compString)"
    }

}
