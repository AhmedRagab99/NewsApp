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
}

class LoginUseCase:LoginUseCaseProtocol{
    
    var userRepo:LogInUserRepo
    let disposeBag:DisposeBag
    
    
    init(userRepo:LogInUserRepo = LogInUserRepo()) {
        self.userRepo = userRepo
        self.disposeBag = DisposeBag()
    }
    
    
    func observerOnUserData(userData:[String:Any])->UserModel?{
        var tempUser:UserModel?
        self.getUserData(storeType: .network, userData: userData)
            .subscribe { user  in
//                self.userRepo.saveUserToCache(for: "UserCache", data: user)
                print(user.user?.name)
                tempUser = user
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("Completed  reequest here")
            }.disposed(by: disposeBag)
        
        return tempUser
    }
    
    func getUserData(storeType: storeType,userData:[String:Any]) -> Observable<UserModel> {
        switch storeType{
        case .network:
            
            
            return self.userRepo.getUserLogedInDatafromNetwork(data: userData)
            
        case .cache:
            return self.userRepo.getUserDataFromCache().map{ user in self.convretUserCacheModel(user: user[0])}
//            returnz (self.userRepo.getUserLogedInDatafromNetwork(data: userData))
        }
    }
    
    
    func convretUserCacheModel(user:UserCache)->UserModel{
        return UserModel(user: User(id: user.id, name:user.name,email: user.email,createdAt: user.createdAt), token: user.token)
    }
    
    
    
    
    
}
