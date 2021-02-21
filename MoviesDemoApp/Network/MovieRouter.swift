//
//  MoviesRouter.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation


enum MovieRouter : RouterProtocol {
    
    case getPopularMovies(page: String)
    case getMovieDetails(movieId: String)
    
    
    var baseUrl: String {
        switch self {
        case .getPopularMovies, .getMovieDetails:
            return NetworkConstants.moviesApiBaseUrl
        }
    }
    
    var path: String {
        switch self {
        
            case .getPopularMovies:
                return "/3/movie/popular"
            
            case .getMovieDetails(let movieId):
                return "/3/movie/\(movieId)"
        }
        
    }
    
    var parameters: [URLQueryItem] {
        let token = NetworkConstants.apiToken
        
        switch self {
            case .getPopularMovies(let page):
                return [
                        URLQueryItem(name: "api_key", value: token),
                        URLQueryItem(name: "page", value: page)
                        ]
            case .getMovieDetails:
                return [URLQueryItem(name: "api_key", value: token)]
        }
    }
    
    var method : String {
        switch self {
        case .getPopularMovies, .getMovieDetails:
            return "GET"
  
        }
        
    }

}
