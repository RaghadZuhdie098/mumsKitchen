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

    var cancellable = Set<AnyCancellable>()

    var recipe: Recipe
    @Published private(set) var image: UIImage? = nil

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func loadImage() {
        ImageDownloader.loadImage(from: recipe.image ?? "")
            .receive(on: RunLoop.main)
            .sink { image in
                self.image = image
            }.store(in: &cancellable)

    }


}
