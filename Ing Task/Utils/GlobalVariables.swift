//
//  GlobalVariables.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Foundation
import UIKit

let screenWidth:CGFloat = {return UIScreen.main.bounds.width}()
let screenHeight:CGFloat = {return UIScreen.main.bounds.height}()
let screenRawWidth:CGFloat = {return UIScreen.main.bounds.width}()

var favoriteMovieDBItem: FavoriteMovieDBItem! = FavoriteMovieDBItem()
var favoriteMovieDBItems: [FavoriteMovieDBItem] = []

struct GlobalVariables {
    
    static func fetchFavoriteMovieDBItems(){
        favoriteMovieDBItems = favoriteMovieDBItem.readAll()
    }
}
