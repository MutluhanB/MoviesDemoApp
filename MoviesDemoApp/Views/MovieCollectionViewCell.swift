//
//  MovieCollectionViewCell.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: MoviePreview?{
        didSet{
            setupCellWithMovie()
        }
    }
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    override class func awakeFromNib() {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImage.image = nil
    }
    
    private func setupCellWithMovie(){
        
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.title
        setPosterImage()
        decideFavoriteStatus()
        styleCell()
       

    }
    
    private func setPosterImage(){
        guard let movie = movie else { return }
        guard let movieId = movie.id else { return }
        guard let url = URL.getPosterUrlFromPath(posterPath: movie.poster_path, width: 300) else { return }
        
        let cacheManager = PosterImageCacheManager.shared
        let cacheKey = "\(movieId)" as NSString
        
        if cacheManager.isImageExistInCache(key: cacheKey) {
            posterImage.image = cacheManager.getCachedImage(key: cacheKey)
        } else {
            posterImage.loadRemoteImage(from: url) {
                
                cacheManager.addImageToCache(key: cacheKey, image: self.posterImage.image!)

            }
            
        }
        
    }
    
    private func decideFavoriteStatus(){
        guard let movieId = movie?.id else { return }
        
        if FavoriteMoviesManager.shared.isMovieFavorite(movieId: movieId) {
            favoriteIcon.image = UIImage(named: "filledStar")
        } else {
            favoriteIcon.image = UIImage(named: "emptyStar")
        }
    }


    private func styleCell(){
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
    }
}
