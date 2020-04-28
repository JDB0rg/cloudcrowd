//
//  IdentifyCollectionViewCell.swift
//  Clouds
//
//  Created by Madison Waters on 3/3/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit

class IdentifyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CloudImageView: UIImageView!
    
    var photo: Photo? {
        didSet{
            updateViews()
            setCloud()
        }
    }
    weak var delegate: CloudImageDelegate?
    
    private func setCloud() {
        delegate?.setCloudImage(on: self)
    }
    
    private func updateViews() {
        guard let photo = photo else { return }
        let cellImage = UIImage(data: photo.image ?? Data())
        self.CloudImageView.image = cellImage
    }

}

