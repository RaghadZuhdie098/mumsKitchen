//
// 
// RecipeDetailsCoordinator.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import UIKit

class RecipeDetailsCoordinator: Coordinator {

    var parentCoordinator: Coordinator?

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let recipeDetailsVC = RecipeDetailsViewController()// -> RecipeDetailsViewController()
        recipeDetailsVC.delegate = self
        navigationController.pushViewController(recipeDetailsVC, animated: true)
    }

    deinit {
        print("Deinit RecipeDetailsCoordinator")
    }
}

extension RecipeDetailsCoordinator: RecipeDetailsNavigation {

    func navigateBackToRecipes() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }

    func navigateToThirdPage() {
        print("")
    }


}
