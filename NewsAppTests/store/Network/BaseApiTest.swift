//
//  BaseApiTest.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import XCTest
import Alamofire
import RxSwift
@testable import NewsApp




class targetTypeMock:TargetType{
    
    var baseUrl: String = ""
    
    var path: String = ""
    
    var method:HTTPMethodDefault = .get
    
    var task: Task = .requestPlain
    
    var headers: [String : String]?
    
}


class BaseApiTest: XCTestCase {
    
    var sut:BaseApi<targetTypeMock>!
    
    override func setUp() {
        super.setUp()
        self.sut  = BaseApi()
    }
    
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testBaseApi_FireRequestfunction_success(){
        let promise = expectation(description: "test fire api request function")
        
        var responceError:ApiError?
        var responceClass:UserModel?
        
        guard let path = Bundle.main.path(forResource: "stup", ofType: "json") else{
            XCTFail("EError: cannot find the resource file")
            return
        }
        let paramRes = sut.buildParams(task: Task.requestPlain)
        
        
        sut.fireApiRequest(path: URL(fileURLWithPath: path).description,
                           method: HTTPMethod.get.rawValue,
                           responceClass: UserModel.self, params:paramRes,headers: [])
        { completion in
            switch completion{
                
            case .success(let data):
                responceClass = data
                promise.fulfill()
            case .failure(let error):
                responceError = error
                promise.fulfill()
            }
        }
        
        print(responceClass?.user?.email)
        wait(for: [promise], timeout: 1)
        XCTAssertNil(responceError)
        XCTAssertNotNil(responceClass)
    }
    
    
    
    func testBaseApi_FireRequestfunction_fail(){
        
        let promise = expectation(description: "test fire api request function to fail")
        
        var responceError:ApiError?
        var responceClass:UserModel?
        guard let path = Bundle.main.path(forResource: "stup", ofType: "json") else{
            XCTFail("EError: cannot find the resource file")
            return
        }
        let paramRes = sut.buildParams(task: Task.requestPlain)
        
        
        sut.fireApiRequest(path: URL(fileURLWithPath: path).description + "test",
                           method: HTTPMethod.get.rawValue,
                           responceClass: UserModel.self, params:paramRes,headers: [])
        {
            completion in
            switch completion{
                
            case .success(let data):
                responceClass = data
                promise.fulfill()
            case .failure(let error):
                responceError = error
                promise.fulfill()
            }
        }
        
        print(responceClass?.user?.email)
        wait(for: [promise], timeout: 1)
        XCTAssertNotNil(responceError)
        XCTAssertNil(responceClass)
    }
    
    
    func test_build_params_function_return_buildParamsType_when_pass_params(){
        
        let res = sut.buildParams(task: .request(parameters: ["name":"ahmed","email":"test@test.com"], encoding: JSONEncoding.prettyPrinted))
        XCTAssertEqual(res.0["name"] as! String, "ahmed")
        XCTAssertEqual(res.0["email"] as! String, "test@test.com")
        
    }
    
}
