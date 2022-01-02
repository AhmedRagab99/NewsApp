//
//  LoginUseCaseTest.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import XCTest
import RxSwift
@testable import NewsApp

class LoginUseCaseTest: XCTestCase {

    
    var sut:LoginUseCase!
    var loginRepoMock:LogInUserRepoProtocol!
    var disposeBag = DisposeBag()
    var tokenTest = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWMzMWIyMGMwNjRlM2IzYjU5NjY0NWEiLCJpYXQiOjE2NDAyNDk2MDF9.LvXJ2qz7AsDMN9yO1zpkVyyfQtBf9xzUzVUXhatZbFU"
    
    
    override  func setUp() {
        
        loginRepoMock = LoginRepoMock()
        sut = LoginUseCase(userRepo: loginRepoMock)
        super.setUp()
    }
    
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
    
    func test_getUser_from_network_return_userModel_observable(){
        
        let res = sut.userRepo.getUserLogedInDatafromNetwork(data: [String:Any]())
        res.subscribe(onNext: { user in
            
            XCTAssertEqual(user.user?.email, "test@test.com")
            XCTAssertNotNil(user.user)
            XCTAssertEqual(user.token, self.tokenTest)
            
        }, onError: { error in
            XCTFail("Failed with error \(error.localizedDescription) ")
        }).disposed(by: disposeBag)
    }
    
    func test_getUser_from_Cache_return_userModel_observable(){
        let res = sut.userRepo.getUserDataFromCache()
        res.subscribe(onNext: { user in
            XCTAssertNotNil(user)
            XCTAssertEqual(user!.email, "test@test.com")
            XCTAssertEqual(user!.name, "testUser")
            XCTAssertEqual(user!.token, "testtoken")
           
        }, onError: { error in
            XCTFail("Failed with error \(error.localizedDescription) ")
        }).disposed(by: disposeBag)
        
    }
    
    func test_getData_call_whenType_is_network(){
        let res = sut.getUserData(storeType: .network, userData: [String : Any]())
        
        res.subscribe(onNext: { user in
            
            XCTAssertEqual(user.user?.email, "test@test.com")
            XCTAssertNotNil(user.user)
            XCTAssertEqual(user.token, self.tokenTest)
            
        }, onError: { error in
            XCTFail("Failed with error \(error.localizedDescription) ")
        }).disposed(by: disposeBag)
    }
    
    
    
    
    func test_getData_call_whenType_is_Cache(){
        let res = sut.getUserData(storeType: .cache, userData: [String : Any]())
        
        res.subscribe(onNext: { user in

            XCTAssertEqual(user.user?.email, "test@test.com")
            XCTAssertEqual(user.user?.name, "testUser")
            
        }, onError: { error in
            XCTFail("Failed with error \(error.localizedDescription) ")
        }).disposed(by: disposeBag)
    }
    
    
    
    func test_observer_user_data_from_network(){
        
        let userModel = sut.observerOnUserData(userData: [String : Any]())
        XCTAssertEqual(userModel?.token, tokenTest)
        XCTAssertEqual(userModel?.user?.email, "test@test.com")
 
    }
    
    
    
    func test_observer_user_data_from_cache(){
        
        let userModel = sut.observeOnUserDataFromCache()
        XCTAssertEqual(userModel?.user?.name, "testUser")
        XCTAssertEqual(userModel?.user?.email, "test@test.com")
 
    }
    
//    func test_convret_User_CacheModel_to_userModel(){
//
//        let res = sut.convretUserCacheModel(user:)
//    }

}
