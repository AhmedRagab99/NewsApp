//
//  UserNetworking.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import Alamofire


let localBaseUrl:String = "http://localhost:5000/api/v1/auth/"
enum UserNetworking{
    case logIn(email:String,password:String)
    case register(name:String,email:String,password:String)
}



extension UserNetworking:TargetType{
    var baseUrl: String {
        return localBaseUrl
    }
    
    var path: String {
        switch self {
        case .logIn:
            return "login"
        case .register:
            return "register"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .logIn,.register:
            return .post
        }
    }
    
    var task: Task {
        switch self{
        case .logIn(let email,let  password):
            return .request(parameters: ["email":email,"password":password], encoding: JSONEncoding.default)
        case .register(let name,let  email, let password):
            return .request(parameters: ["name":name,"email":email,"password":password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .logIn,.register:
            return ["content-type":"application/json;charset=utf-8"]

        }
    }
    
    
}
