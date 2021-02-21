//
//  URLBuildTests.swift
//  MoviesDemoAppTests
//
//  Created by OBSS_Mutluhan Boz  on 20.02.2021.
//

import XCTest
@testable import MoviesDemoApp


class URLBuildTests: XCTestCase {

    func test_BuildsCorrectUrlForDetails(){
        let dummyId = 123
        let detailRouter = MovieRouter.getMovieDetails(movieId: "\(dummyId)")
        let constructedUrl = URL.prepareUrlFromRouter(router: detailRouter)!.absoluteString
        let correctUrl = "https://api.themoviedb.org/3/movie/\(dummyId)?api_key=fd2b04342048fa2d5f728561866ad52a"
        
        XCTAssert(constructedUrl == correctUrl)
        
    }
    
    func test_BuildsCorrectUrlForPopularMovies(){
        let getMoviesRouter = MovieRouter.getPopularMovies(page: "1")
        let constructedUrl = URL.prepareUrlFromRouter(router: getMoviesRouter)!.absoluteString
        let correctUrl =  "https://api.themoviedb.org/3/movie/popular?api_key=fd2b04342048fa2d5f728561866ad52a&page=1"
        
        XCTAssert(constructedUrl == correctUrl)
        
    }
    
    func test_BuildsCorrectUrlFromPosterPath(){
        let width = 200
        let posterPath = "/bmemsraCG1kIthY74NjDnnLRT2Q.jpg"
        let constructedUrl = URL.getPosterUrlFromPath(posterPath: posterPath, width: width)
        let correctUrl = "https://image.tmdb.org/t/p/w\(width)\(posterPath)"
        XCTAssert(constructedUrl!.absoluteString == correctUrl)
    }


}
