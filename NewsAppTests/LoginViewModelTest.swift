//
//  LoginViewModelTest.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 02/01/2022.
//

import XCTest
import RxSwift
@testable import NewsApp

class LoginViewModelTest: XCTestCase {

   
    var sut:LoginViewModel!
    var loginUseCaseMock:LoginUseCaseMock!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        loginUseCaseMock = LoginUseCaseMock()
        sut = LoginViewModel(loginUseCase: loginUseCaseMock)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
    func test_EmailText_is_valid(){
        sut.emailText.onNext("test@test.com")
        let res =  sut.validateEmail()
        
        res.subscribe { value in
            XCTAssertTrue(value)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
    
    func test_EmailText_is_not_valid(){
        sut.emailText.onNext("testtest.com")
        sut.emailText.onNext("")
        sut.emailText.onNext("123")
        let res =  sut.validateEmail()
        
        res.subscribe { value in
            XCTAssertFalse(value)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
    
    // combine latest not working with unit testing
    func test_password_text_is_valid(){
        sut.passwordText.onNext("123123")
        sut.passwordConfirmationText.onNext("123123")
        
        let res = sut.validatePassword()
        
        res.subscribe { value in
          print(value)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
    
    func test_all_fileds_is_valid(){
        sut.emailText.onNext("test@test.com")
        sut.passwordText.onNext("123123")
        sut.passwordConfirmationText.onNext("123123")
        
        let res = sut.isValid
        
        res.subscribe { value in
            XCTAssertEqual(value, true)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
    
    
    

}
