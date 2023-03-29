//
// 
// RecipeDetails.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//

import Foundation

// MARK: - RecipeDetails
struct RecipeDetails: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
    let servings, readyInMinutes: Int?
    let license, sourceName: String?
    let sourceURL: String?
    let spoonacularSourceURL: String?
    let aggregateLikes: Int?
    let healthScore, spoonacularScore, pricePerServing: Double?
    //let analyzedInstructions: [Any?]
    let cheap: Bool?
    let creditsText: String?
    //let cuisines: [Any?]
    let dairyFree: Bool?
    //let diets: [Any?]
    let gaps: String?
    let glutenFree: Bool?
    let instructions: String?
    let ketogenic, lowFodmap: Bool?
    //let occasions: [Any?]
    let sustainable, vegan, vegetarian, veryHealthy: Bool?
    let veryPopular, whole30: Bool?
    let weightWatcherSmartPoints: Int?
    let dishTypes: [String]?
    let extendedIngredients: [ExtendedIngredient]?
    let summary: String?
    let winePairing: WinePairing?
}

enum Consitency {
    case liquid
    case solid
}

// MARK: - WinePairing
struct WinePairing: Decodable {
    let pairedWines: [String]?
    let pairingText: String?
    let productMatches: [ProductMatch]?
}

// MARK: - ProductMatch
struct ProductMatch: Decodable {
    let id: Int?
    let title, productMatchDescription, price: String?
    let imageURL: String?
    let averageRating, ratingCount, score: Double?
    let link: String?
}
