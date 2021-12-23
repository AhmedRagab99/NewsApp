//
//  UsersApi.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import Alamofire
import RxSwift





protocol UserApiProtocol{
    func login(email:String,password:String)->Observable<UserModel>
    func register(name:String,email:String,password:String)->Observable<User>
}

class UserApi:BaseApi<UserNetworking>,UserApiProtocol{
    static let shared = UserApi()
    func login(email: String, password: String) -> Observable<UserModel> {
        self.fetchData(target: .logIn(email: email, password: password), responceClass: UserModel.self)
    }
    func register(name: String, email: String, password: String) -> Observable<User> {
        self.fetchData(target: .register(name: name, email: email, password: password), responceClass: User.self)
    }
    
    
}


