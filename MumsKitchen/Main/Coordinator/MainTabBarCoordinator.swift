//
// 
// MainTabBarController.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import UIKit

class MainTabBarCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        initializeHomeTabBar()
    }

    func initializeHomeTabBar(){
        let tabBarController = UITabBarController.init()
        let tabBarControllerAppearance = UITabBarAppearance()
        tabBarControllerAppearance.configureWithOpaqueBackground()
        tabBarControllerAppearance.backgroundColor = .blue.withAlphaComponent(0.4)


        tabBarControllerAppearance.stackedLayoutAppearance.normal.iconColor = .black
        tabBarControllerAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
     //   tabBarControllerAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = .blue

        tabBarControllerAppearance.stackedLayoutAppearance.selected.iconColor = .yellow
        tabBarControllerAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]

        tabBarController.tabBar.scrollEdgeAppearance = tabBarControllerAppearance
        tabBarController.tabBar.standardAppearance = tabBarControllerAppearance


        let homeNavigationController = UINavigationController()
        let navigationScrollEdgeAppearance = UINavigationBarAppearance()
        navigationScrollEdgeAppearance.configureWithOpaqueBackground()
        navigationScrollEdgeAppearance.backgroundColor = .blue.withAlphaComponent(0.4)
        homeNavigationController.navigationBar.standardAppearance = navigationScrollEdgeAppearance
        homeNavigationController.navigationBar.scrollEdgeAppearance = navigationScrollEdgeAppearance

        let homeCoordinator = RecipesCoordinator.init(navigationController: homeNavigationController)
        let homeItem = UITabBarItem()
        homeItem.title = "HOME"
        homeItem.image = UIImage.init(systemName: "house.fill")
        homeNavigationController.tabBarItem = homeItem

        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator.init(navigationController: searchNavigationController)
        let searchItem = UITabBarItem()
        searchItem.title = "Search"
        searchItem.image = UIImage.init(systemName: "pencil.and.outline")
        searchNavigationController.tabBarItem = searchItem


        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator.init(navigationController: profileNavigationController)
        let profileItem = UITabBarItem()
        profileItem.title = "PROFILE"
        profileItem.image = UIImage.init(systemName: "person.fill")
        profileNavigationController.tabBarItem = profileItem

        navigationController.pushViewController(tabBarController, animated: true)

        parentCoordinator?.childCoordinators.append(homeCoordinator)
        parentCoordinator?.childCoordinators.append(searchCoordinator)
        parentCoordinator?.childCoordinators.append(profileCoordinator)

        tabBarController.viewControllers = [homeNavigationController, searchNavigationController, profileNavigationController]
        homeCoordinator.start()
        searchCoordinator.start()
        profileCoordinator.start()
    }


}
