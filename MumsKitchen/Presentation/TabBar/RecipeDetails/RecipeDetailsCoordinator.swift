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

    var recipe: Recipe

    init(navigationController: UINavigationController, recipe: Recipe) {
        self.navigationController = navigationController
        self.recipe = recipe
    }

    func start() {
        let recipeDetailsVC = RecipeDetailsViewController(viewModel: RecipeDetailsViewModel(recipe: recipe))// -> RecipeDetailsViewController()
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
