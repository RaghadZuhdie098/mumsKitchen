//
// 
// UseCases.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

let getRandomRecipesUseCase = GetRandomRecipeUseCaseImp(repository: RecipesRepoImp(randomRecipesLocalDataSource: RandomRecipesLocalDataSourceImp(), randomRecipesRemoteDataSource: RandomRecipesRemoteDataSourceImp()))
