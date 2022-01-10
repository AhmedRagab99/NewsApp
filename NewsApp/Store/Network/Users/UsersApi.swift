//
//  UsersApi.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import Alamofire
import RxSwift







//typealias returnType = User | ApiError
protocol UserApiProtocol{
    func login(email:String,password:String)->Observable<UserModel>
    func register(name:String,email:String,password:String)->Observable<User>
}

class UserApi:BaseApi<UserNetworking>,UserApiProtocol{
    static let shared = UserApi()
    
    func login(email: String, password: String) -> Observable<UserModel> {
        let result = self.fetchData(target: .logIn(email: email, password: password), responceClass:UserModel.self)
        print(result.asObservable().subscribe(onNext: {[weak self] user in
            print(user)
        },onError: { [weak self] error in
            print(error)
        }).disposed(by: DisposeBag()))
        return result

    }
    
    
    func register(name: String, email: String, password: String) -> Observable<User> {
        self.fetchData(target: .register(name: name, email: email, password: password), responceClass: User.self)
    }
}


