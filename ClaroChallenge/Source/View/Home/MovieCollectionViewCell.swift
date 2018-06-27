//
//  MovieCollectionViewCell.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var releaseView: UIView!
    
    var title: String?
    var poster: String?
    var release: String?
    
    /// Setup Cell
    ///
    /// - Parameters:
    ///   - title: movie title
    ///   - url: poster URL
    ///   - release: release date
    func setup(title: String?, url: String?, release: String?) {
        self.title = title
        self.poster = url
        self.release = release
        
        setup()
    }
    
    private func setup() {
        let placeholder = UIImage(named: "claquete")
        
        self.posterImage.image = placeholder
        self.posterImage.contentMode = .center
        
        if let posterPath = poster {
            let url = URL(string: ApiProvider.posterBaseUrl + posterPath)
            
            self.posterImage.kf.setImage(with: url,
                                         placeholder: placeholder,
                                         completionHandler: { [weak self] (image, _, _, _) in
                                            guard let _self = self else { return }
                                            
                                            if image != nil {
                                                _self.posterImage.contentMode = .scaleAspectFill
                                            }
            })
        }
        
        if let title = self.title {
            titleLabel.text = title
        }
        
        if let release = self.release {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: release) {
                dateFormatter.dateFormat = "dd/MM/yy"
                let formatedRelease = dateFormatter.string(from: date)
                releaseLabel.text = formatedRelease
                releaseView.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        releaseLabel.text = ""
        releaseView.isHidden = true
        self.posterImage.kf.cancelDownloadTask()
    }
}
