//
//  UIColor+Custom.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

extension UIColor {
    static let customLightBrown = UIColor(hex: "#D9A76A")
    static let customBrown = UIColor(hex: "#BF8450")
    static let customDarkBrown = UIColor(hex: "#8C5B3F")
    static let customDarkerBrown = UIColor(hex: "#593932")
    static let customBlack = UIColor(hex: "#0D0D0D")

    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
