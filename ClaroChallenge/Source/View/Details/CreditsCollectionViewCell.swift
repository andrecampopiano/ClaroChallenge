//
//  CreditsCollectionViewCell.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import Kingfisher

class CreditsCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTileLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var title: String?
    var subTitle: String?
    var image: String?
    
    /// Setup cell
    ///
    /// - Parameters:
    ///   - title: Main title, people name
    ///   - subTitle: subtitle, job or character
    ///   - image: profile image
    func setup(title: String?, subTitle: String?, image: String?) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        
        setup()
    }
    
    private func setup() {
        let placeholder = UIImage(named: "profile")
        
        self.imageView.image = placeholder
        self.imageView.contentMode = .center
        
        if let path = image {
            let url = URL(string: ApiProvider.profileBaseUrl + path)
            
            self.imageView.kf.setImage(with: url,
                                       placeholder: placeholder,
                                       completionHandler: { [weak self] (image, _, _, _) in
                                        guard let _self = self else { return }
                                        
                                        if image != nil {
                                            _self.imageView.contentMode = .scaleAspectFill
                                        }
            })
        }
        
        if let title = self.title {
            titleLabel.text = title
        }
        
        if let subTitle = self.subTitle {
            subTileLabel.text = subTitle
        }
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        subTileLabel.text = ""
        self.imageView.kf.cancelDownloadTask()
    }
}
