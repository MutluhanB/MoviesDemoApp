//
//  StorageTests.swift
//  MoviesDemoAppTests
//
//  Created by OBSS_Mutluhan Boz  on 20.02.2021.
//

import XCTest
@testable import MoviesDemoApp

class StorageTests: XCTestCase {
    var favoriteMovieManager = FavoriteMoviesManager()
    
    override func setUp() {
        favoriteMovieManager.dropAllFavorites()
    }
    
  
    
    func test_ModifyFavoritesBackToBack(){
        let favMovieIds = [1 , -1, 0, 999999999999]
        
        
        
        for favMovieId in favMovieIds {
            favoriteMovieManager.addMovieToFavorites(movieId: favMovieId)
           
            if !favoriteMovieManager.isMovieFavorite(movieId: favMovieId) {
                XCTFail("Found an inconsistency in favorite adding operation")
            }
        
        }
        
        for favMovieId in favMovieIds {
            favoriteMovieManager.deleteMovieFromFavorites(movieId: favMovieId)
            if favoriteMovieManager.isMovieFavorite(movieId: favMovieId) {
                XCTFail("Found an inconsistency in favorite deleting operation")
            }
        }
    }
    
    
    func test_FlipFavoriteStatus(){
        let favId = 12345
        XCTAssertFalse(favoriteMovieManager.isMovieFavorite(movieId: favId))
        favoriteMovieManager.flipFavoriteStatusForMovie(movieId: favId)
        XCTAssert(favoriteMovieManager.isMovieFavorite(movieId: favId))
        favoriteMovieManager.flipFavoriteStatusForMovie(movieId: favId)
        XCTAssertFalse(favoriteMovieManager.isMovieFavorite(movieId: favId))
        favoriteMovieManager.flipFavoriteStatusForMovie(movieId: favId)
    
        
    }

}
