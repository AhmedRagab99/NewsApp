//
//  HomeNewsVC.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import UIKit
import RxSwift
class HomeNewsVC: UIViewController {

    
    var newsModel:PublishSubject<NewsModel> = PublishSubject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

