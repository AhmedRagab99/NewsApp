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



class ViewController: UIViewController {
    var apiKey = ProcessInfo.processInfo.environment["NEWSAPI"]!
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        AF.request("https://newsapi.org/v2/everything?q=tesla&from=2021-11-22&sortBy=publishedAt&apiKey=\(apiKey)")
//            .responseJSON { res  in
//                print(res)
//            }
//        AllMovieApi.shared.discoverMovies(page: 1)
//            .subscribe { model in
//            print(model.results?.first?.title)
//        } onError: { error in
//            print(error.localizedDescription)
//        } onCompleted: {
//            print("completed")
//        }.disposed(by: dispose)
        UserApi.shared
            .register(name: "ahmedd", email: "teest@test65365.com", password: "123123")
//            .login(email: "test@test.com", password: "123123")
            .subscribe { User in
                print(User)
            } onError: { error in
               print(error.localizedDescription)

            } onCompleted: {
                    print("completed")

            }.disposed(by: dispose)

    }
}

