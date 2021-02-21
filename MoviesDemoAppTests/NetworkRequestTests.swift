//
//  MoviesDemoAppTests.swift
//  MoviesDemoAppTests
//
//  Created by OBSS_Mutluhan Boz  on 17.02.2021.
//

import XCTest
@testable import MoviesDemoApp

final class NetworkRequestTests: XCTestCase {
    var expectation: XCTestExpectation!
    let timeout: TimeInterval = 3
    
    override func setUp() {
         expectation = expectation(description: "Server responded correctly within reasonable time")
    }
    
    func test_serverRespondsWithMoviePreviews(){
        
   
        MoviesApiManager.shared.getPopularMovies(page: 1) { (response) in
            
            switch response{
            case .success(let movies):
                XCTAssertNotNil(movies.results)
                    self.expectation.fulfill()
                case .failure(_):
                    NSLog("Failed in popular movies test")
                }
 
            }
        
        waitForExpectations(timeout: timeout)
    }
    
    func test_serverRespondsWithMovieDetails(){
        let targetMovieId = 581389
        MoviesApiManager.shared.getMovieDetail(movieId: "\(targetMovieId)" ){ (response) in
      
            switch response{
                case .success(let movieDetail):
                    XCTAssertEqual(movieDetail.id, targetMovieId)
                    self.expectation.fulfill()
                   
                case .failure(_):
                    NSLog("Failed in movie detail test")
                }
 
            }
        
        waitForExpectations(timeout: timeout)
    }
    

      

}
