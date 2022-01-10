//
//  loginRepo.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import RxSwift

protocol LogInUserRepoProtocol{
    func getUserLogedInDatafromNetwork(data:[String:Any])->Observable<UserModel>
    func getUserDataFromCache()->Observable<UserCache?>
    
}


class LogInUserRepo:LogInUserRepoProtocol{
    func getUserLogedInDatafromNetwork(data: [String : Any]) -> Observable<UserModel> {
        print(data["email"])
        return UserApi.shared.login(email:data["email"] as! String , password: data["password"] as! String)
    }
    
    func getUserDataFromCache() -> Observable<UserCache?> {
//        let res = CoreDataStorage.shared.fetch(for: UserCache.self)
        let res = UserCoreDataStorage.shared.fetchUser()
        print(res)
        return Observable.of(res?.last)
    }
    
    
}
