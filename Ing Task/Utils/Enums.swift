//
//  Enums.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 6.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Foundation

enum NotificationCenterKeys: String {
    case MOVIE_FAVOURITE_SITUATION_CHANGED = "MOVIE_FAVOURITE_SITUATION_CHANGED"    
}

enum OriginalLanguage: String, Decodable {
    case English = "en"
    case Japon = "ja"
    case Korean = "ko"
}
