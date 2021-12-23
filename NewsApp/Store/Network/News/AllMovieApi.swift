//
//  NewsApi.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import RxSwift
import Alamofire


protocol AllMovieApiProtocol{
    //    func discover(apiKey:String,q:String)->Observable<[Article]>
    func discoverMovies( page:Int)->Observable<MovieResult>
    
}


class AllMovieApi:BaseApi<AllMovieNetworking>,AllMovieApiProtocol{
    
    static let shared = AllMovieApi()
    func discoverMovies(page: Int) -> Observable<MovieResult> {
        self.fetchData(target: .discover(page: 1), responceClass: MovieResult.self)
        
    }
    

    //        self.fetchData(target: .discover(page: 1), responceClass: MovieResult.self)
}



