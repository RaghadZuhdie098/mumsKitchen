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

    let recipesLocalDataSource: RecipesLocalDataSourceInterface
    let recipesRemoteDataSource: RecipesRemoteDataSourceInterface

    public init(randomRecipesLocalDataSource: RecipesLocalDataSourceInterface,
                recipesRemoteDataSource: RecipesRemoteDataSourceInterface) {
        self.recipesLocalDataSource = randomRecipesLocalDataSource
        self.recipesRemoteDataSource = recipesRemoteDataSource
    }

    func  fetchRandomRecipes() -> AnyPublisher<RecipeData, Error> {
       return recipesRemoteDataSource.fetchRandomRecipes()
        }


    func fetchRecipeInformation(id: Int) -> AnyPublisher<Recipe, Error> {
        return recipesRemoteDataSource.fetchRecipeDetails(id: id)
    }

    func fetchSimilarRecipe(id: Int, completion: (MumKitchenResult<SimilarRecipes, Error>) -> Void) {

    }

    func serchByIngrediant(ingrediant: String, completion: (MumKitchenResult<RecipesBySearch, Error>) -> Void) {

    }

    func getReciptByCategory(category: String) {

    }


}
