//
// 
// SimilarRecipes.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

struct SimilarRecipes : Decodable {
    let id: Int?
    let title, imageType: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    
}
