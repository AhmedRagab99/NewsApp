//
//  loginRepo.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import RxSwift

protocol LogInUserRepoProtocol{
    func getUserLogedInDatafromNetwork(
        //        email:String,password:String
        data:[String:Any]
    )
    ->Observable<UserModel>
    //    func getUserDataFromCache()->Observable<UserModel>
}


class LogInUserRepo:LogInUserRepoProtocol{
    func getUserLogedInDatafromNetwork(data: [String : Any]) -> Observable<UserModel> {
        return UserApi.shared.login(email:data["email"] as! String , password: data["password"] as! String)
        
    }
    
    
    //    func getUserLogedInDatafromNetwork(data:[String:Any]) -> Observable<UserModel> {
    //        return UserApi.shared.login(email:data["email"] as! String , password: data["password"] as! String)
    //    }
    //
    //    func getUserDataFromCachee() -> Observable<UserModel> {
    //        return
    //    }
    //
    
}
