//
//  BaseApi.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 22/12/2021.
//


import Alamofire
import Foundation
import RxSwift



class BaseApi<T: TargetType> {
    typealias paramsReturnType = ([String: Any], ParameterEncoding)
    
    func fetchData<M: Decodable>(target: T, responceClass: M.Type)->Observable<M>
    //                                 completion: @escaping (Result<M?, ApiError>) ->Void) {
    {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        return Observable<M>.create { observer in
            
            print("insidee observer")
            
            AF.request(target.baseUrl + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers)
            //                .validate(statusCode: 200 ... 310)
                .responseData { responce in
                    
                    switch responce.result{
                    case .success:
                        
                        do{
                            print(responce.result)
//
                          
                            
                            
                            
                            guard let data = responce.data
//
                            else{
                                print("error in data")
                                return observer.onError(ApiError.noData)
                            }
//                                    responce.data else {return observer.onError(ApiError.noData)}
                            
                            
                            let decoder = JSONDecoder()
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let responceObject = try decoder.decode(M.self,from:data)
//                            print(responceObject)
                            return observer.onNext(responceObject)
                        }
                        catch{
                            print(error)
                            return observer.onError(error)
                            
                        }
                    case .failure(let error):
                        print("insidee error")
                        
                        return observer.onError(error)
                        
                        
                    }
                }
            print("insidee disposee")
            return Disposables.create()
        }
        
    }
    
    fileprivate func buildParams(task: Task) -> paramsReturnType {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case let .request(parameters, encoding):
            return (parameters, encoding)
        case .requstQuareyParametares(parameters: let parameters, encoding: let encoding):
            return  (parameters,encoding)

        }
    }
}
