//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 22/12/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Kingfisher



class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTeextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Propereties
    
    var apiKey = ProcessInfo.processInfo.environment["NEWSAPI"]!
    let dispose = DisposeBag()
    let useCase:LoginUseCaseProtocol = LoginUseCase()
    var loginViewModel:LoginViewModel!
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.loginViewModel =  LoginViewModel()
        bindViews()
        activateSubmitButton()

        self.loginViewModel.getData()
    
        self.submitButton.rx.tap.subscribe{_ in self.loginViewModel.TapOnSubmitButton()}.disposed(by: disposeBag)
    
    }
    
    
    func activateSubmitButton(){
        loginViewModel.isValid.asObservable().subscribe { [weak self]value in
            
            self?.submitButton.setTitle(value.element! ? "Enabeld":"Not Enabeld" , for: .normal)
            self?.submitButton.tintColor = value.element! ? .green:.red
        }.disposed(by: disposeBag)
    }
    
  
    func bindViews(){
        
        emailTextField.rx.text.map{$0 ?? ""}.bind(to:loginViewModel.emailText).disposed(by: disposeBag)
        
        passwordTextField.rx.text.map{$0 ?? ""}
        .bind(to: loginViewModel.passwordText).disposed(by: disposeBag)
        
        confirmPasswordTeextField.rx.text.map{$0 ?? ""}
        .bind(to:loginViewModel.passwordConfirmationText).disposed(by: disposeBag)
        
        submitButton.rx.tap.bind(to:loginViewModel.submitButtonTaped).disposed(by: disposeBag)
        
        
        loginViewModel.isValid.bind(to:submitButton.rx.isEnabled).disposed(by: disposeBag)
        
        
    }
    
    
}


