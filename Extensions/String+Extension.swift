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

class StringStyles {

    static let bold: Character = "*"
    static let highlight: Character = "_"
    static let title: Character = "="

    var normal: [NSAttributedString.Key : Any]
    var bold: [NSAttributedString.Key : Any]
    var highlight: [NSAttributedString.Key : Any]
    var title: [NSAttributedString.Key : Any]

    init(_ normalColor: UIColor = .black, _ normalFont: UIFont = .sanFrancisco(24, .thin),
         bold boldColor: UIColor = .black, _ boldFont: UIFont = .sanFrancisco(24, .bold),
         highlight highlightColor: UIColor = .red, _ highlightFont: UIFont = .sanFrancisco(24, .thin),
         title titleColor: UIColor = .defaultTintColor, _ titleFont: UIFont = .sanFrancisco(36, .thin)) {
        self.normal = [.foregroundColor: normalColor, .font: normalFont]
        self.bold = [.foregroundColor: boldColor, .font: boldFont]
        self.highlight = [.foregroundColor: highlightColor, .font: highlightFont]
        self.title = [.foregroundColor: titleColor, .font: titleFont]
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

    //TODO: this will be replaced in Swift 5: https://www.hackingwithswift.com/articles/126/whats-new-in-swift-5-0
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

    func attributed(with style: StringStyles = StringStyles()) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: self, attributes: style.normal)
        
        attributedString.enumeratePattern(StringStyles.bold) {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.bold, range: range)
        }
        attributedString.enumeratePattern(StringStyles.highlight) {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.highlight, range: range)
        }
        attributedString.enumeratePattern(StringStyles.title) {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.title, range: range)
        }
        return attributedString
    }
}
