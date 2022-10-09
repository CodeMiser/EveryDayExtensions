//
//  UIColor+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 2/24/19.
//
// The MIT License (MIT)
//
// Copyright (c) 2019 FTLapps, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

extension UIColor {

    static let defaultTintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)

    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: 1.0)
    }

    // constructs .black if hex contains non-hex characters other than # or 0x prefix
    convenience init(hex: String) {
        var color = hex
        if color.hasPrefix("#") {
            color = String(hex.dropFirst())
        } else if color.hasPrefix("0x") {
            color = String(hex.dropFirst(2))
        }
        switch color.count {
        case 1:
            self.init(white: CGFloat(color.hexToDecimal) / CGFloat(16.0), alpha: 1.0)
        case 2:
            self.init(white: CGFloat(color.hexToDecimal) / CGFloat(255.0), alpha: 1.0)
        case 6:
            let r = color[0..<2].hexToDecimal
            let g = color[2..<4].hexToDecimal
            let b = color[4..<6].hexToDecimal
            self.init(r: r, g: g, b: b)
        default:
            self.init()
        }
    }

    convenience init(hex: Int) {
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = hex & 0xFF
        self.init(r: r, g: g, b: b)
    }
}

extension String {

    // returns 0 if self contains non-hex characters
    var hexToDecimal: Int {
        var decimal = 0
        for digit in self {
            decimal *= 16
            guard let digitValue = digit.hexDigitValue else { return 0 }
            decimal += digitValue
        }
        return decimal
    }
}
