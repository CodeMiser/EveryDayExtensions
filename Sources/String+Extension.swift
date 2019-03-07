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

    func attributed(_ color: UIColor, _ font: UIFont) -> NSAttributedString {
        let style = StringStyles(color, font)
        return self.attributed(with: style)
    }

    func attributed(with style: StringStyles = StringStyles()) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: self, attributes: style.normal)
        
        attributedString.enumeratePattern("*") {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.bold, range: range)
        }
        attributedString.enumeratePattern("_") {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.highlight, range: range)
        }
        attributedString.enumeratePattern("=") {
            (range: NSRange) -> Void in
            attributedString.addAttributes(style.title, range: range)
        }
        return attributedString
    }
}
