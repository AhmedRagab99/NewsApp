//
//  LoginUseCaseMock.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 02/01/2022.
//

import RxSwift
@testable import NewsApp



class LoginUseCaseMock:LoginUseCaseProtocol{
    
    
    func getUserData(storeType: storeType, userData: [String : Any]) -> Observable<UserModel> {
        return Observable.of(StubGenerator.stubUsers())
    }
    
    func observerOnUserData(userData: [String : Any]) -> UserModel? {
        return StubGenerator.stubUsers()
    }
    
    func observeOnUserDataFromCache() -> UserModel? {
        return StubGenerator.stubUsers()
    }
    
    func convretUserCacheModel(user: UserCache) -> UserModel {
        return StubGenerator.stubUsers()
    }
    
    
}
