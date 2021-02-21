//
//  FavoriteMoviesManager.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 19.02.2021.
//

import Foundation

struct FavoriteMoviesManager {
    private let key = "fav_movie_id_list"
    static let shared = FavoriteMoviesManager()
    
    private var favoriteMovieIds: [Int] {
        get {
            return UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    

    mutating func addMovieToFavorites(movieId : Int){
        favoriteMovieIds.append(movieId)
    }
    
    mutating func deleteMovieFromFavorites(movieId: Int) {
        favoriteMovieIds = favoriteMovieIds.filter{$0 != movieId}
    }
    
    
    func isMovieFavorite(movieId: Int) -> Bool {
        return favoriteMovieIds.contains(movieId)
    }
    
    mutating func flipFavoriteStatusForMovie(movieId: Int){
        if isMovieFavorite(movieId: movieId) {
            deleteMovieFromFavorites(movieId: movieId)
        } else {
            addMovieToFavorites(movieId: movieId)
        }
    }
    
    mutating func dropAllFavorites(){
        favoriteMovieIds.removeAll() 
    }
    
    
}
