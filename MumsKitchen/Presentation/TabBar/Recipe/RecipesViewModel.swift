//
// 
// RecipesViewModel.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine
import UIKit

class RecipesViewModel {

    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isLoading : Bool = true
    @Published private(set) var getRandomRecipesError: Bool = false
    @Published private(set) var change: Change = .defaultt

    enum Change {
        case failed(error: Error?)
        case loading
        case defaultt
    }
    
    private var subscribers = Set<AnyCancellable> ()

    let getRandomRecipesUseCase: GetRandomRecipeUseCase

    init(getRandomRecipesUseCase: GetRandomRecipeUseCase) {
        self.getRandomRecipesUseCase = getRandomRecipesUseCase
    }


    func getRandomRecipes() {
        isLoading = true
        getRandomRecipesUseCase.execute().receive(on: DispatchQueue.main).mapError({ error -> Error in
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
                    self.getRandomRecipesError = true
                }
                //Use sink(receiveCompletion:receiveValue:) to observe values received by the publisher and process them using a closure you specify.
                print(finish)
            } receiveValue: {  [unowned self]  recipes in
                var a = recipes.recipes.filter{$0.title != nil}.filter{$0.image != nil}
                self.recipes = a

            }.store(in: &subscribers)
    }
    
}
