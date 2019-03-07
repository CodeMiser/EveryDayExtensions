//
//  String+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/2/19.
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

struct StringStyles {
    
    var normalColor: UIColor
    var normalFont: UIFont
    var boldColor: UIColor
    var boldFont: UIFont
    var highlightColor: UIColor
    var highlightFont: UIFont
    var titleColor: UIColor
    var titleFont: UIFont

    static func defaultStyle() -> StringStyles {
        let defaultFontSize = 24
        let defaultTitleSize = 36
        let defaultFontWeight = UIFont.Weight.thin
        return StringStyles(
            normalColor: .black,
            normalFont: .sanFrancisco(defaultFontSize, defaultFontWeight),
            boldColor: .black,
            boldFont: .sanFrancisco(defaultFontSize, .bold),
            highlightColor: .red,
            highlightFont: .sanFrancisco(defaultFontSize, defaultFontWeight),
            titleColor: .blue,
            titleFont: .sanFrancisco(defaultTitleSize, defaultFontWeight)
        )
    }
}

extension String {

    func attributed(_ color: UIColor, _ font: UIFont) -> NSAttributedString {
        var style = StringStyles.defaultStyle()
        style.normalColor = color
        style.normalFont = font
        return self.attributed(with: style)
    }

    func attributed(with style: StringStyles = StringStyles.defaultStyle()) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: self, attributes: [.foregroundColor: style.normalColor, .font: style.normalFont])
        
        attributedString.enumeratePattern("*") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor: style.boldColor, .font: style.boldFont], range: range)
        }
        attributedString.enumeratePattern("_") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor: style.highlightColor, .font: style.highlightFont], range: range)
        }
        attributedString.enumeratePattern("=") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor: style.titleColor, .font: style.titleFont], range: range)
        }
        return attributedString
    }
}
