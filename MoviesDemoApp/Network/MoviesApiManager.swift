//
//  NetworkManager.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation


struct MoviesApiManager {
    
    static let shared = MoviesApiManager()
    static let sharedNetworkHandler = NetworkHandler.shared
    
    func getPopularMovies(page: Int, completion: @escaping (Result<SearchResponse,Error>) -> ()){

        MoviesApiManager.sharedNetworkHandler.request(router: MovieRouter.getPopularMovies(page: String(page)), completion: completion)
    }
    
    func getMovieDetail(movieId: String, completion: @escaping (Result<MovieDetail,Error>) -> ()){
        MoviesApiManager.sharedNetworkHandler.request(router: MovieRouter.getMovieDetails(movieId: movieId), completion: completion)
    }

}

