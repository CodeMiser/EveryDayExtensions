//
//  String+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/2/19.
//
// The MIT License (MIT)
//
// Copyright (c) 2022 FTLapps LLC
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

class StringStyles {

    static var defaultNormal: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17)]
    static var defaultStyles: [Character: [NSAttributedString.Key : Any]] = [
        "*": [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: .bold)],
        "_": [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 17)],
        "=": [.foregroundColor: UIColor.defaultTintColor, .font: UIFont.systemFont(ofSize: 24)],
    ]

    static func setDefaultStyles(
        normal normalColor: UIColor, _ normalFont: UIFont,
        bold boldColor: UIColor, _ boldFont: UIFont,
        highlight highlightColor: UIColor, _ highlightFont: UIFont,
        title titleColor: UIColor, _ titleFont: UIFont
        ) {
        self.defaultNormal = [.foregroundColor: normalColor, .font: normalFont]
        self.defaultStyles = [
            "*": [.foregroundColor: boldColor, .font: boldFont],
            "_": [.foregroundColor: highlightColor, .font: highlightFont],
            "=": [.foregroundColor: titleColor, .font: titleFont]
        ]
    }

    static func addDefaultStyle(for chracter: Character, with style: [NSAttributedString.Key : Any]) {
        self.defaultStyles[chracter] = style
    }

    var normal: [NSAttributedString.Key : Any]
    var styles: [Character: [NSAttributedString.Key : Any]]

    init() {
        self.normal = StringStyles.defaultNormal
        self.styles = StringStyles.defaultStyles
    }

    init(_ color: UIColor, _ font: UIFont) {
        self.normal = [.foregroundColor: color, .font: font]
        self.styles = [:]
    }
}

extension String {

    // https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    // https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
    subscript(_ range: CountableRange<Int>) -> String {
        let firstIndex = index(startIndex, offsetBy: max(0, range.lowerBound))
        let lastIndex = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[firstIndex..<lastIndex])
    }

    subscript(_ range: PartialRangeFrom<Int>) -> String {
        let firstIndex = index(startIndex, offsetBy: max(0, range.lowerBound))
        let lastIndex = index(startIndex, offsetBy: self.count)
        return String(self[firstIndex..<lastIndex])
    }

    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        let firstIndex = index(startIndex, offsetBy: 0)
        let lastIndex = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[firstIndex..<lastIndex])
    }

    func count(_ character: Character) -> Int {
        let count = self.reduce(0) { (result, char) -> Int in
            return result + (char == character ? 1 : 0)
        }
        return count
    }

    func attributed(_ color: UIColor, _ font: UIFont) -> NSAttributedString {
        let style = StringStyles(color, font)
        return self.attributed(with: style)
    }

    func attributed(with styles: StringStyles = StringStyles()) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self, attributes: styles.normal)
        for (character, attributes) in styles.styles {
            attributedString.enumeratePattern(character) {
                (range: NSRange) -> Void in
                attributedString.addAttributes(attributes, range: range)
            }
        }
        return attributedString
    }
}
