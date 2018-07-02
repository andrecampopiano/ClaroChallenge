//
//  TrailerCollectionViewCell.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import Kingfisher

class TrailerCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var webView: UIWebView?
    @IBOutlet weak var imageView: UIImageView?
    
    func setup(trailer: Trailer) {
        let placeHolder =  UIImage(named: "claquete")
        imageView?.image = placeHolder
        
        if let path = trailer.key {
            guard let imageUrl = URL(string: String(format: ApiProvider.trailerImageBaseUrl, path)) else { return }
            imageView?.kf.setImage(with: imageUrl,
                                   placeholder: placeHolder,
                                   completionHandler: { [weak self] (image, _, _, _) in
                guard let _self = self else { return }
                if image != nil {
                    _self.imageView?.contentMode = .scaleAspectFill
                }
            })
            
            guard let trailerUrl = URL(string: ApiProvider.trailerVideoBaseUrl + path) else { return }
            webView?.isOpaque = false
            webView?.backgroundColor = UIColor.clear
            webView?.loadRequest(URLRequest(url: trailerUrl))
        }
    }
    
    override func prepareForReuse() {
    
    }
}
