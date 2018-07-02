//
//  TrailerCollectionViewController.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 28/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit

class TrailerCollectionViewController: UICollectionViewController, Identifiable {
    
    var movieId: Int?
    
    private var trailers: [Trailer]? {
        didSet {
            if trailers != nil {
                collectionView?.reloadData()
            }
        }
    }
    
    private lazy var manager = {
        return DetailsManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrailes()
        
    }
    
    private func fetchTrailes() {
        guard let identifier = movieId else { return }
        manager.fetchTrailers(identifier: identifier) { [weak self] (result) in
            guard let _self = self else { return }
            do {
                guard let trailers = try result() else {
                    throw BusinessError.invalidValue
                }
                _self.trailers = trailers.results
            } catch {
                HandleError.handle(error: error)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension TrailerCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailers?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TrailerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let trailer = trailers?[indexPath.row] {
            cell.setup(trailer: trailer)
        }
        return cell
    }
}
