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
  
    
    init(navigationController:UINavigationController = UINavigationController()){
        self.navigationController = navigationController
    }
    
    func toHome() {
        print("here")
//        let vc = HomeNewsVC()
//        vc.view.backgroundColor = .green
//        navigationController?.pushViewController(vc, animated: true)
        launchHomeVC()
    }
    
    
    private func launchHomeVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "home") as! HomeNewsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
