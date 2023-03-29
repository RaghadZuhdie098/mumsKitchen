//
// 
// RecipesRepoImp.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine
class RecipesRepoImp: RecipeRepoInterface {


    private var anyCancellable = Set<AnyCancellable>()

    let randomRecipesLocalDataSource: RandomRecipesLocalDataSourceInterface
    let randomRecipesRemoteDataSource: RandomRecipesRemoteDataSourceInterface

    public init(randomRecipesLocalDataSource: RandomRecipesLocalDataSourceInterface,
                  randomRecipesRemoteDataSource: RandomRecipesRemoteDataSourceInterface) {
        self.randomRecipesLocalDataSource = randomRecipesLocalDataSource
        self.randomRecipesRemoteDataSource = randomRecipesRemoteDataSource
    }

    func  fetchRandomRecipes() -> AnyPublisher<RecipeData, Error> {
       return randomRecipesRemoteDataSource.fetchRandomRecipes()
        }


    func fetchRecipeDetails(id: Int, includeNutrition: Bool, completion: (MumKitchenResult<RecipeDetails, Error>) -> Void) {

    }

    func fetchSimilarRecipe(id: Int, completion: (MumKitchenResult<SimilarRecipes, Error>) -> Void) {

    }

    func serchByIngrediant(ingrediant: String, completion: (MumKitchenResult<RecipesBySearch, Error>) -> Void) {

    }

    func getReciptByCategory(category: String) {

    }


}
