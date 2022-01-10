//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 01/01/2022.
//


import UIKit
import RxSwift

protocol AppCoordinatorProtocol : AnyObject {
    var childCoordinators : [AppCoordinatorProtocol] { get set }
    func start()
}


extension AppCoordinatorProtocol{
    func store(coordinator:AppCoordinatorProtocol){
        childCoordinators.append(coordinator)
    }

    func freeCoordinaotor(coordinator: AppCoordinatorProtocol){
        childCoordinators = childCoordinators.filter{$0 !== coordinator}
    }
}


class AppCoordinator:AppCoordinatorProtocol{
    private var window:UIWindow
    private var navigationController:UINavigationController?
//    var useCase:LoginUseCaseProtocol = LoginUseCase(userRepo: LogInUserRepo())
    
    var childCoordinators: [AppCoordinatorProtocol] = []
    
    init(window:UIWindow,navigationController:UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    

    func start() {

        launchHomeVC()
    }
    
    private func launchHomeVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
