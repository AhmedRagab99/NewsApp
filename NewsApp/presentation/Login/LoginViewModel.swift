//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//
import Foundation
import RxSwift


class LoginViewModel{
    //MARK: PROPERTIES

    var loginUseCase:LoginUseCaseProtocol
    let disposeBag = DisposeBag()
    
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
    
    
    
    init(loginUseCase:LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        

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
    
    func getData(){
//        self.loginUseCase.observerOnUserData(userData: ["email":getlastEmailText(),"password":getlastPasswordText()] )
        self.loginUseCase.observeOnUserDataFromCache()
        
//        observeOnUserDataFromCache
//        self.loginUseCase.
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
                
                self.getData()
                
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
