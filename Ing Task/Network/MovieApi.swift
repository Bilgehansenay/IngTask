//
//  MovieApi.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 6.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {

    case getMovie(pageNumber: Int)
}

extension MovieApi: TargetType {
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getMovie:
            return ""
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovie:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getMovie(let pageNumber):
            return ["api_key": "fd2b04342048fa2d5f728561866ad52a", "page": pageNumber, "language": "en-US"]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .getMovie:
            return .requestCompositeData(bodyData: sampleData, urlParameters: parameters!)
        }
    }
}
