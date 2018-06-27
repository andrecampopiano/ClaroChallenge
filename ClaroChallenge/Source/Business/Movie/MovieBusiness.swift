//
//  MovieBusiness.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 26/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import Foundation
import Reachability

typealias MovieListUICallback = (@escaping () throws -> MovieList?) -> Void
typealias MovieUICallback = (@escaping () throws -> Movie?) -> Void
typealias CreditsUICallback = (@escaping () throws -> Credits?) -> Void

class MovieBusiness {
    
    private var provider: MovieApiProtocol
    private var upcomingList: MovieList?
    private var popularList: MovieList?
    
    init(withProvider
        aProvider: MovieApiProtocol = (Environment.current() == .mock ? MovieMockProvider() : MovieApiProvider()) ) {
        
        self.provider = aProvider
    }
    
    /// Upcoming Movies List business rules
    ///
    /// - Parameters:
    ///   - refresh: needs to refresh the list
    ///   - completion: MovieListCallback
    func upcomingMovies(refresh: Bool = false,
                        _ completion: @escaping MovieListUICallback) {
        
        guard Reachability.isConnected else {
            completion { throw BusinessError.offlineMode }
            return
        }
        
        if refresh {
            self.upcomingList = nil
        }
        
        do {
            var upcomingRequest = MovieListRequest()
            if let currentUpcomingList = self.upcomingList {
                let currentPage: Int = currentUpcomingList.page ?? 0
                let lastPage: Int = currentUpcomingList.totalPages ?? Int.max
                if currentPage >= lastPage {
                    completion { currentUpcomingList }
                    return
                }
                upcomingRequest.page = currentPage + 1
            }
            
            let request = try JSONEncoder().encode(upcomingRequest)
            let parameters: NetworkParameters = (nil, request)
            provider.upcomingMovies(withParameters: parameters, { [weak self] ( result ) in
                do {
                    guard let _self = self else { return }
                    
                    guard let upcomingResult = try result() else {
                        throw BusinessError.parse("Could not parse response Data: MovieBusiness.upcomingMovies")
                    }
                    
                    guard let upcomingList = try? JSONDecoder().decode(MovieList.self, from: upcomingResult) else {
                        throw BusinessError.parse("""
                            Could not parse response Json into Object: MovieBusiness.upcomingMovies")
                        """)
                    }
                    
                    if upcomingList.results == nil {
                        throw BusinessError.parse("Could not parse results: MovieBusiness.upcomingMovies")
                    }
                    
                    if _self.upcomingList == nil {
                        _self.upcomingList = upcomingList
                    } else {
                        _self.append(movieList: upcomingList, to: &_self.upcomingList)
                    }
                    
                    completion { _self.upcomingList }
                    
                } catch let error {
                    completion { throw error }
                }
            })
        } catch {
            completion {
                throw BusinessError.parse("Error parsing request parameters: MovieBusiness.upcomingMovies")
            }
        }
    }
    
    /// popular Movies List business ruless
    ///
    /// - Parameters:
    ///   - refresh: needs to refresh the list
    ///   - completion: completion callback
    func popularMovies(refresh: Bool = false,
                       _ completion: @escaping MovieListUICallback) {
        
        guard Reachability.isConnected else {
            completion { throw BusinessError.offlineMode }
            return
        }
        
        if refresh {
            self.popularList = nil
        }
        
        do {
            var popularRequest = MovieListRequest()
            if let currentPopularList = self.popularList {
                let currentPage: Int = currentPopularList.page ?? 0
                let lastPage: Int = currentPopularList.totalPages ?? Int.max
                if currentPage >= lastPage {
                    completion { currentPopularList }
                    return
                }
                popularRequest.page = currentPage + 1
            }
            
            let request = try JSONEncoder().encode(popularRequest)
            let parameters: NetworkParameters = (nil, request)
            provider.popularMovies(withParameters: parameters, { [weak self] ( result ) in
                do {
                    guard let _self = self else { return }
                    
                    guard let popularResult = try result() else {
                        throw BusinessError.parse("Could not parse response Data: MovieBusiness.popular")
                    }
                    
                    guard let popularList = try? JSONDecoder().decode(MovieList.self, from: popularResult) else {
                        throw BusinessError.parse("""
                            Could not parse response Json into Object: MovieBusiness.popularMovies
                        """)
                    }
                    
                    if popularList.results == nil {
                        throw BusinessError.parse("Could not parse results: MovieBusiness.popularMovies")
                    }
                    
                    if _self.popularList == nil {
                        _self.popularList = popularList
                    } else {
                        _self.append(movieList: popularList, to: &_self.popularList)
                    }
                    
                    completion { _self.popularList }
                    
                } catch let error {
                    completion { throw error }
                }
            })
        } catch {
            completion {
                throw BusinessError.parse("Error parsing request parameters: MovieBusiness.popularMovies")
            }
        }
    }
    
    /// Movie Details Business rules
    ///
    /// - Parameters:
    ///   - identifier: movie identifier
    ///   - completion: completion callback
    func movie(identifier: Int,
               _ completion: @escaping MovieUICallback) {
        
        guard Reachability.isConnected else {
            completion { throw BusinessError.offlineMode }
            return
        }
        
        do {
            let movieRequest = MovieRequest()
            let request = try JSONEncoder().encode(movieRequest)
            let parameters: NetworkParameters = (nil, request)
            
            provider.movie(withParameters: parameters,
                           movieId: String(identifier), { (result) in
                            do {
                                guard let movieResult = try result() else {
                                    throw BusinessError.parse("Could not parse response Data: MovieBusiness.movie")
                                }
                                
                                guard let movie = try? JSONDecoder().decode(Movie.self, from: movieResult) else {
                                    throw BusinessError.parse("Could not parse response Json into Object: MovieBusiness.movie")
                                }
                                
                                if movie.identifier == nil {
                                    throw BusinessError.parse("Could not parse results: MovieBusiness.movie")
                                }
                                
                                completion { movie }
                                
                            } catch {
                                completion { throw error }
                            }
            })
        } catch {
            completion {
                throw BusinessError.parse("Error parsing request parameters: MovieBusiness.movie")
            }
        }
    }
    
    /// Movie Credits Business rules
    ///
    /// - Parameters:
    ///   - identifier: movie identifier
    ///   - completion: completion callback
    func credits(identifier: Int,
                 _ completion: @escaping CreditsUICallback) {
        
        guard Reachability.isConnected else {
            completion { throw BusinessError.offlineMode }
            return
        }
        
        do {
            let movieRequest = MovieRequest()
            let request = try JSONEncoder().encode(movieRequest)
            let parameters: NetworkParameters = (nil, request)
            
            provider.credits(withParameters: parameters,
                             movieId: String(identifier), { (result) in
                                do {
                                    guard let creditsResult = try result() else {
                                        throw BusinessError.parse("Could not parse response Data: MovieBusiness.credits")
                                    }
                                    
                                    guard let credits = try? JSONDecoder().decode(Credits.self, from: creditsResult) else {
                                        throw BusinessError.parse("Could not parse response Json into Object: MovieBusiness.credits")
                                    }
                                    
                                    if credits.castList == nil || credits.crewList == nil {
                                        throw BusinessError.parse("Could not parse results: MovieBusiness.credits")
                                    }
                                    
                                    completion { credits }
                                    
                                } catch {
                                    completion { throw error }
                                }
            })
        } catch {
            completion {
                throw BusinessError.parse("Error parsing request parameters: MovieBusiness.credits")
            }
        }
    }
}

// MARK: - Private Methods
extension MovieBusiness {
    
    fileprivate func append(movieList newList: MovieList, to oldList: inout MovieList?) {
        guard var list = oldList else { return }
        
        list.page = newList.page
        if let results = newList.results {
            list.results?.append(contentsOf: results)
        }
        
        oldList = list
    }
    
    fileprivate func currentDateString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: Date())
        
        return stringDate
    }
}
