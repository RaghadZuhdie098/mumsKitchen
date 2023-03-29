//
// 
// MumKitchenResult.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

typealias CompletionHandler<T> = (MumKitchenResult<T,Error>) -> Void

enum MumKitchenResult<T, E> where E : Error {
    case data(T)
    case error(E)
}
