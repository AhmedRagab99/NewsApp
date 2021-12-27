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
        let headers = HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        return Observable<M>.create { observer in
            
            print("insidee observer")
            
            
            self.fireApiRequest(target: target, responceClass: responceClass, params: params, headers: headers) { completion in
                switch completion{
                case .failure(let error):
                    return observer.onError(error)
                case .success(let model):
                    return  observer.onNext(model!)
                }
            }
            
            
            print("insidee disposee")
            return Disposables.create()
        }
        
    }
    
    
    
    fileprivate func fireApiRequest<M:Decodable>(target:T,responceClass:M.Type,params:([String: Any], ParameterEncoding),headers:HTTPHeaders,completion:@escaping(Result<M?,ApiError>)->Void){
        
        AF.request(target.baseUrl + target.path, method: Alamofire.HTTPMethod(rawValue:target.method.rawValue), parameters:params.0, encoding: params.1, headers: headers)
            .responseData { responce in
                switch responce.result{
                case .success:
                    
                    do{
                        guard let data = responce.data
                        else{
                            print("error in data")
                            return   completion(.failure(.noData))
                        }
                        
                        let decoder = JSONDecoder()
                        let responceObject = try decoder.decode(M.self,from:data)
                        completion(.success(responceObject))
                    }
                    catch{
                        print(error)
                        
                        completion(.failure(.apiError))
                        
                    }
                case .failure:
                    print("inside error")
                    completion(.failure(.invalidResponse))
                    
                    
                }
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
