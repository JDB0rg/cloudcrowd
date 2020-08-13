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
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var prefixLabel: UILabel!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var formationLabel: UILabel!
    @IBOutlet weak var appearanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheme()
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let cloud = cloud,
        let name = cloud.name else { return }
        
        logoImageView.image = UIImage(named: name.lowercased())?.circleMasked
        
        nameLabel.text = cloud.name
        subcategoryLabel.text = cloud.category
        prefixLabel.text = cloud.prefix
        
        heightLabel.text = "Tall boy" //String(describing: cloud.height)
        elevationLabel.text = "~" + String(describing: cloud.elevation) + " ft."
        guard let compositionArr = cloud.composition else { return }
            let temp = compositionArr
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: "\"", with: "")
        
        compositionLabel.text = temp
        formationLabel.text = cloud.formation
        appearanceLabel.text = cloud.appearance
    }
    
     private func setupTheme() {
            let backgroundImage = UIImage(named: "sunsetgradient")
            let imageView = UIImageView(image: backgroundImage)
//            self.backgroundView.backgroundView = imageView
        self.backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "graygradient")!)
        
        //nameLabel.font = Appearance.ramabhadra
        
        compositionLabel.font = Appearance.robotoBody
        formationLabel.font = Appearance.robotoBody
        appearanceLabel.font = Appearance.robotoBody
    }
}
