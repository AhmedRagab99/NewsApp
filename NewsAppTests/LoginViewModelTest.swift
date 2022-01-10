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
        
        res.subscribe {[weak self] value in
            XCTAssertTrue(value)
        } onError: { [weak self]error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
        
    }
    
    func test_EmailText_is_not_valid(){
      
        sut.emailText.onNext("testtest.com")
        sut.emailText.onNext("")
        sut.emailText.onNext("123")
        
        let res =  sut.validateEmail()
        
        res.subscribe { [weak self]value in
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
        
        res.subscribe { [weak self] value in
            XCTAssertTrue(value)
            
          print(value)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }onCompleted: {
            print("completed")
        }.disposed(by: disposeBag)
        
    
    }
    
    
    func test_password_text_is_not_valid(){
        
        sut.passwordText.onNext("12123")
        sut.passwordConfirmationText.onNext("123123")
        let res = sut.validatePassword()
        
        res.subscribe { [weak self] value in
            XCTAssertFalse(value)
            
          print(value)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }onCompleted: {
            print("completed")
        }.disposed(by: disposeBag)
        

    }
    
    
    func test_all_fileds_is_valid(){
     
        
        
        sut.emailText.onNext("test@test.com")
        sut.passwordText.onNext("123123")
        sut.passwordConfirmationText.onNext("123123")
        
        let res = sut.isValid
        
        res.subscribe { [weak self] value in
            XCTAssertEqual(value, true)
        } onError: { error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)
      
        
    }
    
    func test_validate_inputs(){
        
        sut.emailText.onNext("test@test.com")
        sut.passwordText.onNext("123123")
        sut.passwordConfirmationText.onNext("123123")
        let res  =  sut.ValidInputs()
        res.subscribe { [weak self] value in
            XCTAssertTrue(value)
        } onError: { [weak self] error in
            XCTFail("error in email validation with \(error.localizedDescription)")
        }.disposed(by: disposeBag)

    }
    
    
    func test_get_last_email(){
 
        sut.emailText.onNext("test@test.com")
        sut.emailText.onNext("test@last.com")

        let res  = sut.getlastEmailText()
        
   
        XCTAssertEqual(res, "test@last.com")
    }
    
    
    func test_get_last_password(){
       
        sut.passwordText.onNext("123123")
        sut.passwordText.onNext("111111")
        let res = sut.getlastPasswordText()
//        sut.passwordText.onNext("111111")
        XCTAssertEqual(res, "111111")
    }

}
