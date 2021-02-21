//
//  MovieDetailViewController.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 19.02.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var displayingMovieId: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    var movie: MovieDetail? {
        didSet {
            self.populateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMovieDetails()
    }


    private func fetchMovieDetails(){
        guard let movieId = displayingMovieId else { return }
        
        MoviesApiManager.shared.getMovieDetail(movieId: movieId) { (response) in
            switch response {
            case .success(let movieDetail):
                self.movie = movieDetail
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
           
        }
        
    }
    
    @IBAction func favButtonAction(_ sender: Any) {
        guard let movieId = movie?.id else { return }
        var favoriteManager = FavoriteMoviesManager()
        favoriteManager.flipFavoriteStatusForMovie(movieId: movieId)
        decideFavoriteStatus()
    }
    
    private func decideFavoriteStatus(){
        guard let movieId = movie?.id else { return }
        
        if FavoriteMoviesManager.shared.isMovieFavorite(movieId: movieId) {
            favButton.image = UIImage(named: "filledStar")
        } else {
            favButton.image = UIImage(named: "emptyStar")
        }
    }

    private func populateUI(){
        guard let movie = movie else { return }
        
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.descriptionLabel.text = movie.overview
            self.votesLabel.text = "Rating : \(movie.vote_average ?? 0) based on \(movie.vote_count ?? 0) votes"
            self.decideFavoriteStatus()
        }
        
        if let posterPath = movie.poster_path {
            guard let posterUrl = URL.getPosterUrlFromPath(posterPath: posterPath, width: 300) else { return }
            posterImageView.loadRemoteImage(from: posterUrl)
        
        }
    }


}
