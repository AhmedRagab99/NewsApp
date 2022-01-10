//
//  LoginCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import UIKit
import CoreMedia



protocol LoginCoordinagtorProtocol{
    var navigationController: UINavigationController? { get set }
    func toHome()
}

class LoginCoordinator: NSObject,LoginCoordinagtorProtocol{
    var navigationController: UINavigationController?
  
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func toHome() {
        print("Go To Home")
        let vc = HomeNewsVC()
        navigationController?.pushViewController(vc, animated: true)
//        let vc = HomeNewsVC()
//        vc.view.backgroundColor = .green
//        navigationController?.pushViewController(vc, animated: true)
//        launchHomeVC()
    }

    
  
}
