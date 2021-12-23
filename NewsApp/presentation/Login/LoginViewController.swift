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
//    let useCase:LoginUseCaseProtocol = LoginUseCase()
    
  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        AF.request("https://newsapi.org/v2/everything?q=tesla&from=2021-11-22&sortBy=publishedAt&apiKey=\(apiKey)")
//            .responseJSON { res  in
//                print(res)
//            }
        
        
        let param = ["email":"test@test.com","password":"123123"]
        
        
//        useCase.getUserData(storeType: .network, data: param).asObservable().subscribe { model in
//            print(model)
//        } onError: { error in
//            print(error.localizedDescription)
//        } onCompleted: {
//            print("completed")
//        } .disposed(by: dispose)

        
//        NewsApi.shared.getEverething(apiKey: apiKey, q: "sports").subscribe { model in
//            print(model)
//        } onError: { error in
//            print(error.localizedDescription)
//        } onCompleted: {
//            print("completed")
//        }.disposed(by: dispose)

       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

