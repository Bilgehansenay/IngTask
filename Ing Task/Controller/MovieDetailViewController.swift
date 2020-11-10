//
//  MovieDetailViewController.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var selectedMovie: Result!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var starBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews(){
        guard let movie = selectedMovie else{return}
        
        starBarButton.image = movie.isAddedFavouriteList ? UIImage(named: "star") : UIImage(named: "star_unselected")
        
        let url = URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath)")
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: url)
        
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        ratingLabel.text = "\(movie.voteAverage)"
        voteCountLabel.text = "(\(movie.voteCount))"
    }
    
    
    @IBAction func starBarButtonTapped(_ sender: Any) {
                
        GlobalVariables.fetchFavoriteMovieDBItems()

        if(selectedMovie.isAddedFavouriteList){
            let willBeDeletedMovieIndex = favoriteMovieDBItems.firstIndex { ($0.movieID == selectedMovie.id)}
            if let movieIdInDB = willBeDeletedMovieIndex{
                favoriteMovieDBItem.delete(id: movieIdInDB)
            }
            selectedMovie.isAddedFavouriteList = false
        }else{
            let favoriteMovieDBTempItem = FavoriteMovieDBItem(movieID: selectedMovie.id)
            favoriteMovieDBTempItem.add()
            selectedMovie.isAddedFavouriteList = true
        }
        starBarButton.image = selectedMovie.isAddedFavouriteList ? UIImage(named: "star") : UIImage(named: "star_unselected")
        
        let userInfo = ["movieID": selectedMovie.id, "isAddedFavouriteList": selectedMovie.isAddedFavouriteList] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationCenterKeys.MOVIE_FAVOURITE_SITUATION_CHANGED.rawValue), object: nil, userInfo: userInfo as [AnyHashable : Any])
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
