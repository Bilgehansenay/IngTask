//
//  NetworkManager.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 6.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Moya
import Moya_ModelMapper

class NetworkManager: NSObject {
    
    
    static let movieProvider = MoyaProvider<MovieApi>()
    
    
    static func getMovieList(pageNumber: Int ,completion: @escaping (Movie?)->()){
        movieProvider.request(.getMovie(pageNumber: pageNumber)) { baseResult in
            switch baseResult {
            case let .success(response):
                do{
                    let results = try response.map(to: Movie.self)
                    completion(results)
                }catch _{
                    completion(nil)
                }
                break;
            case let .failure(error):
                print(error)
                completion(nil)
                break;
            }
        }
    }
    
}

