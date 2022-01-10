//
//  LoginUseCase.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import RxSwift
import Alamofire
import Foundation


enum storeType:String{
    case network = "Network"
    case cache = "Cache"
}

protocol LoginUseCaseProtocol{
    func getUserData(storeType:storeType,userData:[String:Any])->Observable<UserModel>
    
    func observerOnUserData(userData:[String:Any])->UserModel?
    
    func observeOnUserDataFromCache()->UserModel?
    
    
    func convretUserCacheModel(user:UserCache)->UserModel
    
}

class LoginUseCase:LoginUseCaseProtocol{
    
    var userRepo:LogInUserRepoProtocol
    let disposeBag:DisposeBag = DisposeBag()
    
    
    init(userRepo:LogInUserRepoProtocol) {
        
        self.userRepo = userRepo
        
        
        
    }
    
    
    
    
    func observerOnUserData(userData:[String:Any])->UserModel?{
        var tempUser:UserModel?
        self.getUserData(storeType: .network, userData: userData)
            .subscribe {  [weak self ] user  in
                if user.user?.name != ""{
                    
                    
                    let res = UserCoreDataStorage.shared.CreateUser(user: user)
                    print("From Core Data with name \(res?.name)")
                    print(user.user)
                }
                
                tempUser = user
            } onError: { [weak self] error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed  reequest here")
            }.disposed(by: disposeBag)
        
        return tempUser
    }
    
    
    
    
    func observeOnUserDataFromCache()->UserModel?{
        var tempUser:UserModel?
        self.getUserData(storeType: .cache, userData: ["":""])
            .subscribe { [weak self] user in
                print("User fetched from core data \(user)")
                tempUser = user
            } onError: { [weak self] error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed")
            }.disposed(by: disposeBag)
        return tempUser
    }
    
    
    
    
    
    func getUserData(storeType: storeType,userData:[String:Any]) -> Observable<UserModel> {
        switch storeType{
        case .network:
            return self.userRepo.getUserLogedInDatafromNetwork(data: userData)
        case .cache:
            return self.userRepo.getUserDataFromCache().map{ user in
                
                if let lastUser = user{
                    return  self.convretUserCacheModel(user:lastUser)
                }
                else
                {
                    print("")
                    return UserModel(user: User(id:"",name:"",email:"",createdAt:""),token:"")
                }
            }
        }
    }
    
    
    func convretUserCacheModel(user:UserCache)->UserModel{
        return UserModel(user: User(id: user.id, name:user.name,email: user.email,createdAt: user.createdAt), token: user.token)
    }
    
    
}
