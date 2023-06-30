//
//  getRecipeSpecificInformationUseCase.swift
//  MumsKitchen
//
//  Created by raghad zuhdie on 24/06/2023.
//

import Foundation
import Combine

protocol GetRecipeInformationUseCase {
    func execute(id: Int) ->  AnyPublisher<Recipe,Error>
}

class GetRecipeInformationUseCaseImp: GetRecipeInformationUseCase {
    
    private let repository: RecipeRepoInterface

    init(repository: RecipeRepoInterface) {
        self.repository = repository
    }
    
    func execute(id: Int) -> AnyPublisher<Recipe, Error> {
        repository.fetchRecipeInformation(id: id)
    }
  
}
