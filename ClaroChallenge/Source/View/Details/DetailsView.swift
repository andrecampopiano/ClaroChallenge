//
//  DetailsView.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// fill Screen with movie
    ///
    /// - Parameter movie: movie object
    func fillScreen(movie: Movie) {
        loadBanner(url: movie.backdropPath)
        loadPoster(url: movie.posterPath)
        loadDate(movie.releaseDate)
        loadGenres(movie.genres, runtime: movie.runtime)
        
        if let title = movie.title {
            titleLabel.text = title
        }
        
        if let description = movie.overview {
            descriptionLabel.text = description
            if description.isEmpty {
               descriptionLabel.text = LocalizableStrings.notSupportLanguage.localize()
            }
            descriptionLabel.sizeToFit()
        }
        
        showLoading(false)
    }
    
    /// Show loading view
    ///
    /// - Parameter show: show or hide
    func showLoading(_ show: Bool) {
        if show {
            loadingView.isHidden = false
            activityIndicator.startAnimating()
        } else {
            loadingView.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func loadPoster(url: String?) {
        let placeholder = UIImage(named: "claquete")
        
        self.posterImage.image = placeholder
        self.posterImage.contentMode = .center
        
        if let posterPath = url {
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
    }
    
    private func loadBanner(url: String?) {
        let placeholder = UIImage(named: "claquete")
        
        self.bannerImage.image = placeholder
        self.bannerImage.contentMode = .center
        
        if let bannerPath = url {
            let url = URL(string: ApiProvider.bannerBaseUrl + bannerPath)
            
            self.bannerImage.kf.setImage(with: url,
                                         placeholder: placeholder,
                                         completionHandler: { [weak self] (image, _, _, _) in
                                            guard let _self = self else { return }
                                            
                                            if image != nil {
                                                _self.bannerImage.contentMode = .scaleAspectFill
                                            }
            })
        }
    }
    
    private func loadDate(_ date: String?) {
        if let release = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: release) {
                dateFormatter.dateFormat = "yyyy"
                let formatedRelease = dateFormatter.string(from: date)
                dateLabel.text = formatedRelease
            }
        }
    }
    
    private func loadGenres(_ genres: [Genre]?, runtime: Int?) {
        var genresString = ""
        var runtimeString = ""
        
        if let genres = genres {
            genresString = genres.flatMap({ (gnr) -> String? in
                gnr.name
            }).joined(separator: ", ")
        }
        
        if let runtime = runtime {
            runtimeString = String(describing: runtime)
            if runtimeString.count > 0 && genresString.count > 0 {
                runtimeString = "\(runtimeString)m | "
            } else if runtimeString.count > 0 {
                runtimeString = "\(runtimeString)m"
            }
        }
        
        self.genreLabel.text = "\(runtimeString)\(genresString)"
    }
}
