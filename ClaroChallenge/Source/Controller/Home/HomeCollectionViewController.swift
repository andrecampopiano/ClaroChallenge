//
//  HomeCollectionViewController.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, Identifiable {
    
    // MARK: - Properties
    
    private var movieType: MovieType = .upcoming
    
    private var movies: [Movie]? {
        get {
            switch movieType {
            case .upcoming: return upcomingMovies
            case .popular: return popularMovies
            }
        }
        set {
            switch movieType {
            case .upcoming: upcomingMovies = newValue
            case .popular: popularMovies = newValue
            }
        }
    }
    
    private var upcomingMovies: [Movie]? {
        didSet {
            if upcomingMovies != nil {
                collectionView?.reloadData()
            }
        }
    }
    
    private var popularMovies: [Movie]? {
        didSet {
            if popularMovies != nil {
                collectionView?.reloadData()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(HomeCollectionViewController.refresh),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private lazy var manager = {
        return HomeManager()
    }()
    
    private var selectedMovieId: Int?
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.refreshControl = refreshControl
        loadMovies()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Methods
    
    fileprivate func loadMovies(refresh: Bool = false) {
        switch movieType {
        case .upcoming: loadUpcoming(refresh: refresh)
        case .popular: loadPopular(refresh: refresh)
        }
    }
    
    private func loadUpcoming(refresh: Bool) {
        manager.upcomingMovies(refresh: refresh) { [weak self] (result) in
            guard let _self = self else { return }
            
            do {
                guard let movieList = try result() else {
                    throw BusinessError.invalidValue
                }
                _self.upcomingMovies = movieList.results
            } catch {
                HandleError.handle(error: error)
            }
            _self.refreshControl.endRefreshing()
        }
    }
    
    private func loadPopular(refresh: Bool) {
        manager.popularMovies(refresh: refresh) { [weak self] (result) in
            guard let _self = self else { return }
            
            do {
                guard let movieList = try result() else {
                    throw BusinessError.invalidValue
                }
                _self.popularMovies = movieList.results
                _self.refreshControl.endRefreshing()
            } catch {
                HandleError.handle(error: error)
            }
            _self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        loadMovies(refresh: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailsViewController.segueIdentifier {
            guard let detailsViewController = segue.destination as? DetailsViewController else { return }
            detailsViewController.movieId = self.selectedMovieId
        }
    }
    
    // MARK: - Actions
    
    @IBAction func movieTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            movieType = .upcoming
            title = LocalizableStrings.upcomingMovies.localize()
        } else {
            movieType = .popular
            title = LocalizableStrings.popularMovies.localize()
        }
        collectionView?.reloadData()
        
        if movies?.count ?? 0 > 0 {
            collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                         at: .top,
                                         animated: false)
        } else {
            loadMovies(refresh: true)
        }
    }
}

// MARK: - UICollectionViewDataSource && UICollectionViewDelegate
extension HomeCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let movie = movies?[indexPath.row] else { return cell }
        cell.setup(title: movie.title!, url: movie.posterPath, release: movie.releaseDate)
        
        if indexPath.row >= (movies?.count ?? 0)-1 {
            loadMovies()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else { return }
        movieCell.posterImage.kf.cancelDownloadTask()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.row] else { return }
        selectedMovieId = movie.identifier
        performSegue(withIdentifier: DetailsViewController.segueIdentifier,
                     sender: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin = 10
        
        var width = (UIScreen.main.bounds.width - CGFloat(2*margin))/3
        
        if UIDevice.current.orientation.isLandscape {
            width = (UIScreen.main.bounds.width - CGFloat(4*margin))/5
        }
        
        let size = CGSize(width: width,
                          height: (width*1.41) + 30)
        
        return size
    }
}
