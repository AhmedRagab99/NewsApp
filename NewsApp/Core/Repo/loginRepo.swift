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
    func getUserDataFromCache()->Observable<[UserCache]>
    
}


class LogInUserRepo:LogInUserRepoProtocol{
    func getUserLogedInDatafromNetwork(data: [String : Any]) -> Observable<UserModel> {
        return UserApi.shared.login(email:data["email"] as! String , password: data["password"] as! String)
    }
    
    func getUserDataFromCache() -> Observable<[UserCache]> {
//        let res = CoreDataStorage.shared.fetch(for: UserCache.self)
        let res = CoreDataManager.shared.fetchUsers()
        print(res)
        return Observable.of(res!)
    }
    
//
//     func saveUserToCache(for:String,data:UserModel){
//         data.addUserToCacheStore(data: data)
////         print(res)
//
//         let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//        print(paths[0])
//
//    }
    
   
    
    
    //    func getUserLogedInDatafromNetwork(data:[String:Any]) -> Observable<UserModel> {
    //        return UserApi.shared.login(email:data["email"] as! String , password: data["password"] as! String)
    //    }
    //
    //    func getUserDataFromCachee() -> Observable<UserModel> {
    //        return
    //    }
    //
    
}
