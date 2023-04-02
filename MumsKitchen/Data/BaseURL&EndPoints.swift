//
// 
// BaseURL&EndPoints.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine

public struct Constants {

    static let baseURL: String = "https://api.spoonacular.com/"
    static let apiKey: String = "418c2cef3851489fab16dbdfde8709ca"// key\chain

    enum endpoint {
        case randomRecipes
        case randomDetails(id: String)
        var url: String {
                switch self {
                case .randomRecipes:
                    return "recipes/random"
                case .randomDetails(let id): // Constants.endpoint.randomDetails(id: "212346").url
                    return "https://api.spoonacular.com/recipes/\(id)/information"
                }
        }
    }
}


//      let url = URL(string: "https://api.spoonacular.com/recipes/random?limitLicense=true&number=100&apiKey=74c68c2002b44ac880054132921a1481")!
// https://api.spoonacular.com/recipes/{id}/information


