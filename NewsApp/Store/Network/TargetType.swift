//
//  TargetType.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 22/12/2021.
//

import Foundation
import Alamofire


enum HTTPMethodDefault: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case request(parameters: [String: Any], encoding: ParameterEncoding)
    case requstQuareyParametares(parameters:[String:Any],encoding:URLEncoding)

}

protocol TargetType {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethodDefault { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

enum ApiError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case AuthError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "cheack the Fields again"
        case .noData: return "please try agian later"
        case .AuthError: return "forbidden! please log in"
        }
    }
    
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
