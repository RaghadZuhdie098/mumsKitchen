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
///
/// without kingfisher
///
///
//class ImageDownloader {
//
//   static var images = NSCache<NSString,NSData>()
//   static func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Error> {
//        guard let url = URL(string: urlString ) else {
//            return Fail(error: URLPathError.canNotGetURLpath("canNotGetURLpath")).eraseToAnyPublisher()
//        }
//       // perform the request will apply URLSession.shared.dataTaskPublisher ->  .tryMap ->  .mapError ->            .eraseToAnyPublisher() , but the closure inside .trymap and .mapError will be called after perform URLSession.shared.dataTaskPublisher(for: url) for all image tha shown.
//        return URLSession.shared.dataTaskPublisher(for: url)
//           .tryMap { (data, response) -> UIImage? in
//            //  guard let c = c
//               //httpResponse = response as? HTTPURLResponse,
////                     httpResponse.statusCode == 200
////               else {
////                  print("throw URLError(.badServerResponse)")
////                  throw URLError(.badServerResponse) // will execute .catch and mapError closure
////               }
//               do {
//                   return UIImage(data: data)
//
//               }
//           }
//           .catch { error -> AnyPublisher<UIImage?, Error> in
//               // Handle the error
//               print("Error loading image:::::::: \(error.localizedDescription)")
//               return Fail(error: error).eraseToAnyPublisher()
//           }
//           .mapError { error -> Error in
//               error
//           }
//           .eraseToAnyPublisher()
//
//
//    }



//    func fetchImages(imagesNames: [String]) -> AnyPublisher<[UIImage?], Error> {
//        let imagePublishers = imagesNames.map { name in
//            ImageDownloader.loadImage(from:name)
//                .replaceError(with: nil)
//                .eraseToAnyPublisher()
//        }
//
//        return Publishers.MergeMany(imagePublishers)
//            .collect()
//            .eraseToAnyPublisher()
//    }
//}

//
//ImageDownloader.loadImage(from: url)
//    .receive(on: RunLoop.main)
//    .sink { image in
//        self.imageView.image = image
//        if let image = image, let imageData = image.pngData() {
//            ImageDownloader.images.setObject(imageData as NSData, forKey: url as NSString)
//            print("cache Image")
//        }
//    }.store(in: &cancellable)
