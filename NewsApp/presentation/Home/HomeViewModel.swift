//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 07/01/2022.
//

import Foundation
import RxSwift


class HomeViewModel{
    
    
    var homeNewsUseCase:HomeNewsUseCaseProtocol
    var searchTermSubject:BehaviorSubject<String> = BehaviorSubject(value: "")
    var NewsModelSubject:PublishSubject<NewsModel>  = PublishSubject()
    
    init(homeNewsUseCase:HomeNewsUseCaseProtocol) {
        self.homeNewsUseCase = homeNewsUseCase
    }
    

    func populateNews(searchTerm:String = "sports"){
        self.homeNewsUseCase.getNews(type: .network, searchTerm: searchTerm)
            .map { [weak self] model in
                return self?.NewsModelSubject.asObserver().onNext(model)
            }
            
    }
    
    
    
    
    
    
    
    
    
    
}
