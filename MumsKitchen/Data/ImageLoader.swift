//
// 
// ImageLoader.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Combine
import UIKit

class ImageDownloader {

   static var images = NSCache<NSString,NSData>()

   static func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ -> UIImage? in
                UIImage(data: data) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

