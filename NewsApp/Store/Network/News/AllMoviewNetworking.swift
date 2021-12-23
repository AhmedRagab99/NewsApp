//
//  News Networking.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import Alamofire


 let BASEURL = "https://api.themoviedb.org/3"
 let TMDBAPIKEY = "abda05f587ed82af48bc6c95b70de00c"
enum AllMovieNetworking{
    case discover(page:Int = 1)
    case getUpcomingMovies(page:Int = 1)
    case getTopRatedMovies(page:Int = 1)
    case getPopularMovies(page:Int = 1)
    case getTrendingMovies(page:Int = 1)
}


extension AllMovieNetworking:TargetType{

    
    var method: HTTPMethod {
        switch self{
        case .discover,.getUpcomingMovies,.getTopRatedMovies,.getPopularMovies,.getTrendingMovies:
            return .get
        }
    }
    
    var baseUrl: String {
        return BASEURL
    }
    
    var path: String {
        switch self{
        case .discover:
            return "/discover/movie"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getPopularMovies:
            return "/movie/popular"
        case .getTrendingMovies:
            return "/trending/movie/week"
        }
    }
    
    
    var task: Task {
        switch self{
        case .discover(let page),.getUpcomingMovies(let page),.getTopRatedMovies(let page),.getPopularMovies(let page),.getTrendingMovies(let page):
            return .requstQuareyParametares(parameters: ["api_key":"\(TMDBAPIKEY)","page":"\(page)"], encoding: .queryString)
     
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .discover,.getUpcomingMovies,.getTopRatedMovies,.getPopularMovies,.getTrendingMovies:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    
}
