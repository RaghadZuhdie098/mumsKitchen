//
// 
// AppCoordinator.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    

    static var isAuthinticated = false

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if AppCoordinator.isAuthinticated {
            navigationController.viewControllers.removeAll() // to start new navigation without logInViewController
           // childCoordinators.removeAll()
            let coordinator = MainTabBarCoordinator.init(navigationController: navigationController)
            //You can see that I don’t assign the HomeTabbarCoordinator as the child’s parent. Why? so when a child wants to access the AppCoordinator, it can directly access it without any extra code inside HomeTabbarCoordinator.

            //childCoordinators.append(coordinator)
            coordinator.start()
        } else {
            let coordinator = LogInCoordinator.init(navigationController: navigationController)
            coordinator.parentCoordinator = self
           // coordinator.delegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
        }
    }
}

//extension AppCoordinator: CoordinatorDelegate {
////    func removeChildCoordinator(coordinator: Coordinator) {
////        childDidFinish(coordinator)
////    }
//
//
//    func coordinatorDidLogin(coordinator: LogInCoordinator) {
//        removeCoordinator(coordinator:coordinator) //
//        AppCoordinator.isAuthinticated = true
//        start()
//    }
//
//    func removeCoordinator(coordinator:Coordinator) {
//        childDidFinish(coordinator)
//    }
//
//
//}
