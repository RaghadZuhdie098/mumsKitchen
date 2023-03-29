//
// 
// LogInCoordinator.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import UIKit

class LogInCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let logInViewController = LogInViewController()
        logInViewController.delegate = self
        AppCoordinator.isAuthinticated = true
        navigationController.pushViewController(logInViewController, animated: true)
    }

    deinit {
        print("Deinit LogInCoordinator")
    }
}



extension LogInCoordinator: LogInViewNavigation {
    func navigateToRecipesList() {
        parentCoordinator?.start()
        parentCoordinator?.childDidFinish(self)
    }
}
