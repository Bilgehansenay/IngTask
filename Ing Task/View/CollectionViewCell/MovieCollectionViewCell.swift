//
//  MovieCollectionViewCell.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    var cellMovie: Result!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setMovie(movie: Result){
        cellMovie = movie
        starImageView.isHidden = true
        
        movieTitleLabel.text = movie.title
        starImageView.isHidden = cellMovie.isAddedFavouriteList ? false : true
        
        DispatchQueue.main.async {
            let url = URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath)")
            self.movieImageView.kf.indicatorType = .activity
            self.movieImageView.kf.setImage(with: url)
        }
    }
    
}


