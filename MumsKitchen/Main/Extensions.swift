//
// 
// Extensions.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import UIKit

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

extension String {

    func getHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let attributedText = NSAttributedString(string: self, attributes: attributes)
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textHeight = attributedText.boundingRect(
            with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            .height.rounded(.up)
        return textHeight
    }
}
