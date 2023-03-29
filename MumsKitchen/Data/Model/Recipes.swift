//
// 
// Recipes.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//

import Foundation

// MARK: - RecipeData
struct RecipeData: Decodable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Decodable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    let creditsText, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let imageType, summary: String?
    let cuisines, dishTypes: [String]?
    //let diets: [Any?]
    let occasions: [String]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    //let originalID: NSNull
    let spoonacularSourceURL: String?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Decodable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Decodable {
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Decodable {
    let id: Int?
    let name, localizedName, image: String?
}

// MARK: - Length
struct Length: Decodable {
    let number: Int?
    let unit: String?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Decodable {
    let id: Int?
    let aisle, image, consistency, name: String?
    let nameClean, original, originalName: String?
    let amount: Double?
    let unit: String?
    let meta: [String]?
    let measures: Measures?
}

// MARK: - Measures
struct Measures: Decodable {
    let us, metric: Metric?
}

// MARK: - Metric
struct Metric: Decodable {
    let amount: Double?
    let unitShort, unitLong: String?
}
