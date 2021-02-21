//
//  ViewController.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 17.02.2021.
//

import UIKit

class MoviesListViewController: UIViewController, UITextFieldDelegate {
    
    private var isFirstLaunch = true
    private var isGrid = true
    private var currentPage = 1
    private var footerView: UICollectionReusableView?
    private var fetchedMovies: [MoviePreview]?

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
   
      
    ///- Warning: Modifying the content of this array will automatically updates the ui
    private var currentlyDisplayingMovies: [MoviePreview]?{
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setupCollectionView()
        enableKeyboardDismissingWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayMoviesAtAppearence()
    }
    
    /// Fetches movies in initial presentation of the view controller using isFirstLaunch variable. isFirstLaunch variable will be setted to false after the code runs, thus preventing undesired behaivour when dismissing any view controller presented by this view controller
    private func displayMoviesAtAppearence(){
        
        if isFirstLaunch {
            fetchMoviesInCurrentPage()
        } else {
            displayAllFetchedMovies()
        }
        
        isFirstLaunch = false
    }
    
    private func fetchMoviesInCurrentPage(){
        MoviesApiManager.shared.getPopularMovies(page: currentPage) {  response in
            
            switch response {
                case .success(let searchResult):
                    self.fetchedMovies = searchResult.results
                    self.displayAllFetchedMovies()
                case .failure(let error):
                    NSLog(error.localizedDescription)
            
            }
            
        }

    }
    
    private func fetchMoviesInNextPageAndAppend(){
        currentPage += 1
        MoviesApiManager.shared.getPopularMovies(page: currentPage) { response in
            switch response {
            
                case .success(let searchResult):
                    
                    if let newMovies = searchResult.results {
                        self.fetchedMovies?.append(contentsOf: newMovies)
                        self.displayAllFetchedMovies()
                    }
                    
                case .failure(let error):
                    NSLog(error.localizedDescription)
            }
            
        }
    }
   
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text == "" {
            displayAllFetchedMovies()
            footerView?.isHidden = false
            return
        }
        
        guard let currentText = searchTextField.text else { return }
        searchMoviesWith(givenString: currentText)
    }
    
    
    private func displayAllFetchedMovies(){
        currentlyDisplayingMovies = fetchedMovies
        DispatchQueue.main.async {
            self.searchTextField.text = ""
        }
        
    }
    
    private func searchMoviesWith(givenString: String){
        footerView?.isHidden = true
        currentlyDisplayingMovies?.removeAll()
        guard let fetchedMovies = fetchedMovies else { return }
     
        var matchedMovies = [MoviePreview]()
        for movie in fetchedMovies {
            let titleRange = movie.title?.lowercased().range(of: givenString)
            if titleRange != nil {
                matchedMovies.append(movie)
            }
        }
        
        currentlyDisplayingMovies = matchedMovies
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
    }
    

    @IBAction func changeLayout(_ sender: Any) {
        self.isGrid = !self.isGrid
        self.collectionView.reloadData()
    }
    
    @IBAction func loadMoreAction(_ sender: Any) {
        fetchMoviesInNextPageAndAppend()
    }
    

    
}


//MARK: CollectionView Functions
extension MoviesListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGrid {
            let halfCellWidth = collectionView.frame.size.width / 2 - 10
            return CGSize(width: halfCellWidth , height: 300 )
        } else {
            return CGSize(width: collectionView.frame.size.width - 10 , height: collectionView.frame.size.height / 2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        guard  let movie = currentlyDisplayingMovies?[indexPath.row] else {
            return cell
        }
        
        cell.movie = movie

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovieId = currentlyDisplayingMovies?[indexPath.row].id else { return }
        guard let detailVc = UIViewController.instantiateViewControllerFromStoryboard(storyboardName: "Main", storyboardId: "MovieDetailVc") as? MovieDetailViewController else { return }
        detailVc.displayingMovieId = "\(selectedMovieId)"
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentlyDisplayingMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewFooter", for: indexPath)
        
        return footerView!
    }
    
}


