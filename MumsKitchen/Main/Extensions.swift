//
// 
// Extensions.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation


extension Bool {
    var ToStringValue: String {
        return self ? "true" : "false"
    }
}

extension Int {
    var ToStringValue: String {
        return ("\(self)")
    }
}
