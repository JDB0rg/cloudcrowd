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
    
    var photo: Photo?
    var cloud: Cloud? {
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
        
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let cloud = cloud else { return }
        
        nameLabel.text = "Real Cool Cloud Guy" //cloud.name
        subcategoryLabel.text = cloud.subcategory
        
        heightLabel.text = String(describing: cloud.height)
        elevationLabel.text = "Real tall like a few thousand feet or so" //String(describing: cloud.elevation)
        compositionLabel.text = String(describing: cloud.composition)
        
//        let mainImage = UIImage(named: "lukasz-lada-unsplash-cloud")
//        mainImageView.image = mainImage
    }

}
