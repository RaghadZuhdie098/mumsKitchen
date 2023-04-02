//
// 
// RandomRecipesRequest.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation

class RandomRecipesRequest: RequestParam {

    var number: Int
    init(number: Int) {
        self.number = number
    }

    override var parameters: [String : String] {
        return [ "number" : number.ToStringValue,
                 "apiKey" : Constants.apiKey ]
    }

    

}


class RequestParam {
    var parameters : [String: String] {
        return [:]
    }
}
