//
// 
// RandomRecipesRemoteDataSourceInterface.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

protocol RecipesRemoteDataSourceInterface {
    func  fetchRandomRecipes() -> AnyPublisher<RecipeData, Error>
    func fetchRecipeDetails(id: Int) -> AnyPublisher<Recipe, Error>

}
