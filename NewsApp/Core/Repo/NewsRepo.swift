//
//  NewsRepo.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 07/01/2022.
//

import RxSwift
import Foundation





protocol NewsRepoProtocol{
    func getNews(with q:String)->Observable<NewsModel>
}



class NewsRepo:NewsRepoProtocol{
    private let newesApiKey = ProcessInfo.processInfo.environment["NEWSAPI"]  ?? ""
    
    func getNews(with q: String) -> Observable<NewsModel> {
        return NewsApi.shared.getEverething(apiKey: newesApiKey, q: q)
    }
}
