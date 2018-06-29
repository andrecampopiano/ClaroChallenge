//
//  TrailerCollectionViewCell.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import Clappr
import AVFoundation

class TrailerCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?

    let baseURL = "https://www.youtube.com/watch?v="
    override func awakeFromNib() {
        
    }
    
    func setup(trailer: Trailer) {
        titleLabel?.text = trailer.name
        let photoService = PhotoServices.shared
        if let url = URL(string: baseURL+trailer.key) {
            let image = photoService.getThumbnailFrom(path: url)
            if image != nil {
                self.imageView?.image = image
            } else {
                self.imageView?.image = UIImage(named: "claquete")
            }
        }
    }
}
