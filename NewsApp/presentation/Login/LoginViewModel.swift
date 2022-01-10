//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//
import Foundation
import RxSwift
import UIKit
import RxCocoa


class LoginViewModel{
    //MARK: PROPERTIES
    
    private var loginUseCase:LoginUseCaseProtocol
    private let disposeBag = DisposeBag()
    //    private var loginCoordinator:LoginCoordinagtorProtocol
    
    // MARK: viewsObservabels
    var emailText: BehaviorSubject<String> = BehaviorSubject(value:"")
    var lastEmailText:BehaviorRelay<String> = BehaviorRelay(value:"")
    var lastPasswordText:BehaviorRelay<String> = BehaviorRelay(value:"")
    var passwordText: BehaviorSubject<String> = BehaviorSubject(value:"")
    var passwordConfirmationText: BehaviorSubject<String> = BehaviorSubject(value: "")
    var submitButtonTaped: PublishSubject<Void> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    var errorSubject: PublishSubject<String> = PublishSubject()
    
    
    
    var isValid:Observable<Bool>{
        ValidInputs()
    }
    
    
    
    init(loginUseCase:LoginUseCaseProtocol
         //         loginCoordinator:LoginCoordinagtorProtocol
    ){
        //         ,loginCoordinator:LoginCoordinagtorProtocol = LoginCoordinator()) {
        self.loginUseCase = loginUseCase
        //        self.loginCoordinator = loginCoordinator
        
        
    }
    
    //    func getUserData(){
    //        loading.onNext(true)
    //        print(getlastEmailText())
    //
    //        loginUseCase.getUserData(storeType: .network, userData: ["email":getlastEmailText(),"password":getlastPasswordText()]
    //        ).subscribe {[weak self] user in
    //            print(user)
    //            self?.loading.onNext(false)
    //
    //        } onError: { [weak self] error in
    //            self?.loading.onNext(false)
    //            self?.errorSubject.onNext(error.localizedDescription)
    //        } onCompleted: {
    //            self.loading.onNext(false)
    //            print("completed")
    //        }.disposed(by: disposeBag)
    //    }
    
    func getDataFromCache(){
        self.loginUseCase.observeOnUserDataFromCache()
    }
    
    func getDataFromNetwork(){
        let res = self.loginUseCase.observerOnUserData(userData: ["email":getlastEmailText(),"password":getlastPasswordText()] )
        //        self.loginCoordinator.toHome()
        
        if res?.user?.email != "" {
            print("user is not empty")
            //            self.loginCoordinator.toHome()
            
        }
        
    }
    
    
    func getlastEmailText()->String{
        //        var res = ""
        emailText
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] observer in
                
                self?.lastEmailText.accept(observer.element ?? "")
                //                res = observer.element ?? "test"
                //                observer.event.onCompleted()
                //                print(res)
            }.disposed(by: disposeBag)
        return lastEmailText.value
    }
    
    
    
    func getlastPasswordText()->String{
        var res = ""
        passwordText
            .observe(on: MainScheduler.instance)
        //            .map{[weak self] value in  self?.lastPasswordText.accept(value)}
        
        
        //
            .subscribe{ [weak self] observer in
                //            res = observer.element ?? "pass"
                self?.lastPasswordText.accept(observer.element ?? "")
                print(res)
            }.disposed(by: disposeBag)
        return lastPasswordText.value
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
        return emailText
            .map{
                $0.count > 3 && !$0.isEmpty && $0.contains("@")
                
            }
    }
    
    func validatePassword()->Observable<Bool>{
        return Observable.combineLatest(passwordText.asObservable(), passwordConfirmationText.asObservable())
            .map{[weak self] password,confirmPassword in
                print(password + " " )
                print(confirmPassword)
                guard password == confirmPassword , password.count >= 4 , password.isEmpty == false , confirmPassword.isEmpty == false else {return false}
                
                return true
            }
    }
    
    func ValidInputs()->Observable<Bool>{
        return Observable.combineLatest(validateEmail(), validatePassword()).map{ [weak self] email,password in
            return email && password
        }
    }
    
}
