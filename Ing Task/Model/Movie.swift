//
//  Movie.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 6.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Foundation
import Mapper

struct Movie: Mappable {
    let page, totalResults, totalPages: Int
    var results: [Result] = []

    init(map: Mapper) throws {
        page = try map.from("page")
        totalResults = try map.from("total_results")
        totalPages = try map.from("total_pages")
        results = map.optionalFrom("results") ?? []
    }

}

struct Result: Mappable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String
    var isAddedFavouriteList: Bool = false
    
    init(map: Mapper) throws {
        popularity = try map.from("popularity")
        voteCount = try map.from("vote_count")
        video = try map.from("video")
        posterPath = try map.from("poster_path")
        id = try map.from("id")
        adult = try map.from("adult")
        backdropPath = try map.from("backdrop_path")
        originalTitle = try map.from("original_title")
        genreIDS = try map.from("genre_ids")
        title = try map.from("title")
        voteAverage = try map.from("vote_average")
        overview = try map.from("overview")
        releaseDate = try map.from("release_date")
        
        isAddedFavouriteList = ((favoriteMovieDBItems.first{$0.movieID == id}) != nil)
    }

}
