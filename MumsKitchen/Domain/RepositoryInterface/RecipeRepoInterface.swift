//
// 
// RecipeRepository.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

protocol RecipeRepoInterface {
    func fetchRandomRecipes() -> AnyPublisher<RecipeData,Error>
    func fetchRecipeDetails(id: Int, includeNutrition: Bool, completion: CompletionHandler<RecipeDetails>)
    func fetchSimilarRecipe(id: Int, completion: CompletionHandler<SimilarRecipes>)
    func serchByIngrediant(ingrediant: String, completion: CompletionHandler<RecipesBySearch>)
    func getReciptByCategory(category: String)

}
