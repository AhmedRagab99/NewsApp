//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//
import Foundation
import RxSwift
import UIKit


class LoginViewModel{
    //MARK: PROPERTIES
    
    private var loginUseCase:LoginUseCaseProtocol
   private let disposeBag = DisposeBag()
//    private var loginCoordinator:LoginCoordinagtorProtocol
    
    // MARK: viewsObservabels
    var emailText:BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var passwordText:BehaviorSubject<String> = BehaviorSubject(value: "")
    var passwordConfirmationText:PublishSubject<String> = PublishSubject()
    var submitButtonTaped:PublishSubject<Void> = PublishSubject()
    var loading:PublishSubject<Bool> = PublishSubject()
    var errorSubject:PublishSubject<String> = PublishSubject()
    
    var isValid:Observable<Bool>{
        ValidInputs()
    }
    
    
    
    init(loginUseCase:LoginUseCaseProtocol = LoginUseCase()
    ){
//         ,loginCoordinator:LoginCoordinagtorProtocol = LoginCoordinator()) {
        self.loginUseCase = loginUseCase
//        self.loginCoordinator = loginCoordinator
        
        
    }
    
    func getUserData(){
        loading.onNext(true)
        print(getlastEmailText())
        
        loginUseCase.getUserData(storeType: .network, userData: ["email":getlastEmailText(),"password":getlastPasswordText()]
        ).subscribe {[weak self] user in
            print(user)
            self?.loading.onNext(false)
            
        } onError: { [weak self] error in
            self?.loading.onNext(false)
            self?.errorSubject.onNext(error.localizedDescription)
        } onCompleted: {
            self.loading.onNext(false)
            print("completed")
        }.disposed(by: disposeBag)
    }
    
        func getDataFromCache(){
            self.loginUseCase.observeOnUserDataFromCache()
        }
    
    func getDataFromNetwork(){
         let res = self.loginUseCase.observerOnUserData(userData: ["email":getlastEmailText(),"password":getlastPasswordText()] )
//        self.loginCoordinator.toHome()

//        if res?.user?.email != "" {
//            print("user is not empty")
//            self.loginCoordinator.toHome()
//
//        }
        
        
    }
    
    
    func getlastEmailText()->String{
        var res = ""
        emailText.subscribe{observer in
            res = observer.element ?? "test"
            print(res)
        }.disposed(by: disposeBag)
        return res
    }
    
    
    
    func getlastPasswordText()->String{
        var res = ""
        passwordText.subscribe{observer in
            res = observer.element ?? "pass"
            print(res)
        }.disposed(by: disposeBag)
        return res
    }
    
    func TapOnSubmitButton() {
        
        submitButtonTaped
            .asDriver(onErrorJustReturn: ())
            .debounce(.milliseconds(500))
            .map{ _ in
                self.isValid.asObservable().map{return $0 == true}
            }
            .drive{[weak self ] _ in
                guard let self = self else { return }
                
                self.getDataFromNetwork()
                
            }
    }
    
    func validateEmail()->Observable<Bool>{
        return emailText.map{return $0.count > 3 && !$0.isEmpty}
    }
    
    func validatePassword()->Observable<Bool>{
        return Observable.combineLatest(passwordText.asObservable(), passwordConfirmationText.asObservable()).map{ password,confirmPassword in
            guard password == confirmPassword , password.count >= 4 else {return false}
            guard password.isEmpty == false , confirmPassword.isEmpty == false else {return false}
            return true
        }
    }
    
    func ValidInputs()->Observable<Bool>{
        return Observable.combineLatest(validateEmail(), validatePassword()).map{email,password in
            return email && password
        }
    }
    
}
