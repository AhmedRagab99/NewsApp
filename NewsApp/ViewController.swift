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
        NewsApi.shared.getEverething(apiKey: apiKey, q: "sports").subscribe { model in
            print(model)
        } onError: { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("completed")
        }.disposed(by: dispose)

       
    }
}

