//
//  News Networking.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
import Alamofire

let NewsBaseApiURL =  "https://newsapi.org/v2/"

enum NewsNetworking {
    case everything(apiKey:String,q:String)
}


extension NewsNetworking:TargetType{
    var baseUrl: String {
        return NewsBaseApiURL
    }
    
    var path: String {
        switch self{
        case .everything(let apiKey , let q):
            return "everything?q=\(q)&apiKey=\(apiKey)"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .everything:
            return .get
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
            
        case .everything:
            return .requestPlain
        default:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .everything:
            return ["content-type":"application/json;charset=utf-8"]

        default:
            return ["content-type":"application/json;charset=utf-8"]

        }
    }
    
    
}
