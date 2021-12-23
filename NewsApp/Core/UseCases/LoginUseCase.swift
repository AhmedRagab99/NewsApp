//
//  LoginUseCase.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import RxSwift
import Alamofire


enum storeType:String{
    case network = "Network"
    case cache = "Cache"
}

protocol LoginUseCaseProtocol{
    func getUserData(storeType:storeType,userData:[String:Any])->Observable<UserModel>
}

class LoginUseCase:LoginUseCaseProtocol{
    
    var userRepo:LogInUserRepo
    
    init(userRepo:LogInUserRepo = LogInUserRepo()) {
        self.userRepo = userRepo
    }
    func getUserData(storeType: storeType,userData:[String:Any]) -> Observable<UserModel> {
        switch storeType{
        case .network:
            return (self.userRepo.getUserLogedInDatafromNetwork(data: userData))
        case .cache:
            return (self.userRepo.getUserLogedInDatafromNetwork(data: userData))

            
        }
    }
    
    
}
