//
//  DetailsViewController.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import ElasticTransition

class DetailsViewController: ElasticModalViewController, Identifiable, ViewCustomizable {
    
    // MARK: - Properties
    
    typealias CustomView = DetailsView
    
    private lazy var manager = {
        return DetailsManager()
    }()
    
    /// id used to load Movie
    var movieId: Int?
    private var movie: Movie?
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovie()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private methods
    
    private func loadMovie() {
        guard let movieId = self.movieId else {
            return
        }
        customView.showLoading(true)
        manager.fetchMovie(identifier: movieId) { [weak self] (result) in
            guard let _self = self else { return }
            
            do {
                guard let movie = try result() else {
                    throw BusinessError.invalidValue
                }
                _self.movie = movie
                _self.fillScreen()
            } catch {
                HandleError.handle(error: error)
            }
        }
    }
    
    private func fillScreen() {
        guard let movie = self.movie else { return }
        self.customView.fillScreen(movie: movie)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CreditsCollectionViewController.segueIdentifier {
            guard let creditsViewController = segue.destination as? CreditsCollectionViewController else { return }
            creditsViewController.movieId = self.movieId
        }
    }
    
}
