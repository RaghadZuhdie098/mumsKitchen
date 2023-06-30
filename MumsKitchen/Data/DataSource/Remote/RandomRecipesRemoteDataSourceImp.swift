//
// 
// RandomRecipesRemoteDataSourceImp.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

class RandomRecipesRemoteDataSourceImp: RecipesRemoteDataSourceInterface {

    let apiManager: GenericAPIManagerProtocol

    init(apiManager: GenericAPIManagerProtocol) {
        self.apiManager = apiManager
    }

    func fetchRandomRecipes() -> AnyPublisher<RecipeData, Error> {
        let randomRecipesRequest = RandomRecipesRequest(number: 100)
        return apiManager.getData(endPoint: Constants.endpoint.randomRecipes.url, parameters: randomRecipesRequest).eraseToAnyPublisher()
    }
    
    func fetchRecipeDetails(id: Int) -> AnyPublisher<Recipe, Error> {
        let parameters = RequestParam()
        return apiManager.getData(endPoint: Constants.endpoint.recipeDetails(id: "\(id)").url , parameters: parameters).eraseToAnyPublisher()
    }
    
}


  //  return Just(url).setFailureType(to: Error.self).eraseToAnyPublisher()



    //let decoder = JSONDecoder()
    //        let publisher = URLSession.shared.dataTaskPublisher(for: url) //URLSession.DataTaskPublisher
    //
    //        return  publisher
    //        //.map{ $0.data }
    //            .tryMap() { element -> Data in
    //                guard let httpResponse = element.response as? HTTPURLResponse,
    //                      httpResponse.statusCode == 200 else {
    //                    throw URLError(.badServerResponse)
    //                }
    //                return element.data
    //            }
    //        //                .mapError { error  in
    //        //                            switch error {
    //        //                            case is DecodingError: print ("ServiceError.decode")
    //        //                            case is URLError: print ("ServiceError.url(error as? URLError)")
    //        //                            default: print ("ServiceError.unknown(error)")
    //        //                            }
    //        //                }
    //        //                .mapError({ error -> Error in
    //        //                    if let error = error as? APIError {
    //        //                        return error
    //        //                    } else if error is DecodingError {
    //        //                        return ParseError.parserError(reason: error.localizedDescription)
    //        //                    } else {
    //        //                        return APIError.unknown
    //        //                    }
    //        //                })
    //        //              .map{$0.data}
    //            .decode(type: RecipeData.self, decoder: decoder)
    //            .receive(on: DispatchQueue.main)
    //            .eraseToAnyPublisher()
    //
    //        //                .sink { finished in
    //        //                    print ("Received completion: \(finished).")
    //        //                } receiveValue: { data in
    //        //                  print ("Received user: \(data).")
    //
    //    }
    //
