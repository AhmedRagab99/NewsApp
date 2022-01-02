//
//  LoginRepoMock.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import RxSwift
@testable import NewsApp

class LoginRepoMock:LogInUserRepoProtocol{
    
    private func getStup()->UserModel{
        return StubGenerator.stubUsers()
    }
    
    func getUserLogedInDatafromNetwork(data: [String : Any]) -> Observable<UserModel> {
        let userModel = getStup()
        return Observable.of(userModel)
    }
    
    func getUserDataFromCache() -> Observable<UserCache?> {
       
        let userCache = ModelsHelper.getUserCacheModel()
        return Observable.of(userCache)
    }
    
    
  
    
    
}


class ModelsHelper{
    
    static func getUserCacheModel()->UserCache{
        let user  = UserCache(context: CoreDataMangerStack.shared.mainContext)
        
        user.email = "test@test.com"
        user.id = "61c31b20c064e3b3b596645a"
        user.token = "testtoken"
        user.name = "testUser"
        user.createdAt = "12/12/2021"
        
        return user
    }
}
