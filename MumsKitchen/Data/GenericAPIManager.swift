//
// 
// GenericAPIManager.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

protocol GenericAPIManagerProtocol {
    func getData<T: Codable>(endPoint: String, parameters: RequestParam) -> AnyPublisher<T, Error>
}

class GenericAPIManager: GenericAPIManagerProtocol {

    func getData<T: Codable>(endPoint: String, parameters: RequestParam) -> AnyPublisher<T, Error> {
/*
 flatMap in Combine is when you want to pass elements emitted by one publisher to a method that itself returns a publisher, and ultimately subscribe to the elements emitted by that second publisher.
If an error occurs in the getFinalURL function, it will return a Fail publisher with the error, which has a type of AnyPublisher<URL, Error>. In this case, the flatMap function will not be executed, and the returned publisher will simply emit the error value from getFinalURL directly. Therefore, the type of syncResult will be Error, and the flatMap closure will not be executed.
 */
        let decoder = JSONDecoder()
        return  getFinalURL(endPoint: endPoint, parameters: parameters).flatMap { syncResult -> AnyPublisher<T, Error> in
            // Use the result of the sync request to modify the async request
            return URLSession.shared.dataTaskPublisher(for: syncResult)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: T.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        }.eraseToAnyPublisher()
    }

    func getFinalURL(endPoint: String,parameters: RequestParam) -> AnyPublisher<URL, Error> {

        let RecipesUrl = Constants.baseURL
        let URL = URL(string: RecipesUrl)!
        let fullURL = URL.appendingPathComponent(endPoint)

        guard var urlComponents = URLComponents(string: fullURL.absoluteString) else {
            return Fail(error: URLPathError.canNotGetURLComponents("canNotGetURLComponents"))
                .eraseToAnyPublisher()
        }

        if !parameters.parameters.isEmpty {
            urlComponents.percentEncodedQueryItems = parameters.parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        urlComponents.percentEncodedQueryItems?.append(URLQueryItem(name: "apiKey", value: KeychainManager.retrieveApiKey()))

        guard let url = urlComponents.url else {
            return Fail(error: URLPathError.canNotGetURLpath("canNotGetURLpath"))
                .eraseToAnyPublisher()
        }

        return Just(url).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
