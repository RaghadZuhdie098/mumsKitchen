//
// 
// UseCases.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

let getRandomRecipesUseCase = GetRandomRecipeUseCaseImp(repository: RecipesRepoImp(randomRecipesLocalDataSource: RandomRecipesLocalDataSourceImp(), recipesRemoteDataSource: RandomRecipesRemoteDataSourceImp(apiManager: GenericAPIManager())))

let getRecipeInformationUseCase = GetRecipeInformationUseCaseImp(repository: RecipesRepoImp(randomRecipesLocalDataSource: RandomRecipesLocalDataSourceImp(), recipesRemoteDataSource: RandomRecipesRemoteDataSourceImp(apiManager: GenericAPIManager())))
