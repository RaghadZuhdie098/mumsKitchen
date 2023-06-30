//
// 
// RecipeDetailsViewModel.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine
import UIKit

class RecipeDetailsViewModel {

    let id: Int
    let getRecipeDetailsUseCase: GetRecipeInformationUseCase
    @Published private(set) var recipe: Recipe?
    private var subscribers = Set<AnyCancellable> ()

    @Published private(set) var isLoading : Bool = true

    init(id: Int, getRecipeDetailsUseCase: GetRecipeInformationUseCase) {
        self.id = id
        self.getRecipeDetailsUseCase = getRecipeDetailsUseCase
    }

    func getRecipeInformation() {
            isLoading = true
        getRecipeDetailsUseCase.execute(id: id).receive(on: DispatchQueue.main).mapError({ error -> Error in
                    if let error = error as? URLPathError {
                        return error
                        } else {
                            print(error.localizedDescription)

                        return error
                    }
                })
                .sink { finish in
                    self.isLoading = false
                    switch finish {
                    case .finished:
                        print("Finish request")
                    case .failure(let error):
                        print(error.localizedDescription)
                     //   self.getRandomRecipesError = true
                    }
                    //Use sink(receiveCompletion:receiveValue:) to observe values received by the publisher and process them using a closure you specify.
                    print(finish)
                } receiveValue: {  [unowned self]  recipe in
                    self.recipe = recipe
                }.store(in: &subscribers)
        }
    }



