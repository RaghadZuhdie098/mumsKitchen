//
// 
// HomeCoordinator.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import UIKit

class RecipesCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let recipesVC = RecipesViewController(viewModel: RecipesViewModel(getRandomRecipesUseCase: getRandomRecipesUseCase))// -> HomeViewController()
        recipesVC.delegate = self
        //self.navigationController.viewControllers = [recipesVC]
        navigationController.pushViewController(recipesVC, animated: true)
    }
}


extension RecipesCoordinator: RecipesNavigation {
    func navigateToRecipeDetails(recipe: Recipe) {
        print("next page")
        let recipeDetailsCoordinator = RecipeDetailsCoordinator(navigationController: navigationController, recipe: recipe)
        recipeDetailsCoordinator.parentCoordinator = self
        //recipeDetailsCoordinator.delegate = self
        childCoordinators.append(recipeDetailsCoordinator)
        recipeDetailsCoordinator.start()

    }


}
