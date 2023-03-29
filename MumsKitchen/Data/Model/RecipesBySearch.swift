//
// 
// RecipesBySearch.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

struct RecipesBySearch: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: ImageType?
    let usedIngredientCount, missedIngredientCount: Int?
    let missedIngredients, usedIngredients: [SedIngredient]?
    //let unusedIngredients: [Any?]
    let likes: Int?
}

enum ImageType: Decodable {
    case jpg
}

// MARK: - SedIngredient
struct SedIngredient: Decodable {
    let id: Int?
    let amount: Double?
    let unit, unitLong, unitShort, aisle: String?
    let name, original, originalName: String?
    let meta: [String]?
    let image: String?
    let extendedName: String?
}
