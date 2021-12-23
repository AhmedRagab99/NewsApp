//
//  NewsApi.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import RxSwift
import Alamofire


protocol NewsApiProtocol{
    func getEverething(apiKey:String,q:String)->Observable<NewsModel>
}


class NewsApi:BaseApi<NewsNetworking>,NewsApiProtocol{
    
    
    
    static let shared = NewsApi()
    func getEverething(apiKey: String, q: String) -> Observable<NewsModel> {
        self.fetchData(target: .everything(apiKey: apiKey, q: q), responceClass: NewsModel.self)
    }
    
    
}
