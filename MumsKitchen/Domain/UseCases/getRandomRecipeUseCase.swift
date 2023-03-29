//
// 
// getRandomRecipeUseCase.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

protocol GetRandomRecipeUseCase {
    func execute() ->  AnyPublisher<RecipeData,Error>
}

class GetRandomRecipeUseCaseImp: GetRandomRecipeUseCase {

    private let repository: RecipeRepoInterface
    init(repository: RecipeRepoInterface) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<RecipeData,Error> {
        repository.fetchRandomRecipes()
    }


}
