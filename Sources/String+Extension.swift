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

extension String {

    func attributed(
        _ color: UIColor = .black, _ font: UIFont = .sanFrancisco(36, .thin),
        bold boldColor: UIColor = .black, _ boldFont: UIFont = .sanFrancisco(36, .bold),
        highlight highlightColor: UIColor = .red, _ highlightFont: UIFont = .sanFrancisco(36, .thin),
        title titleColor: UIColor = .blue, _ titleFont: UIFont = .sanFrancisco(48, .thin)
        ) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: self, attributes: [.foregroundColor : color, .font : font])
        
        attributedString.enumeratePattern("*") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor : boldColor, .font : boldFont], range: range)
        }
        attributedString.enumeratePattern("_") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor : highlightColor, .font : highlightFont], range: range)
        }
        attributedString.enumeratePattern("=") {
            (range: NSRange) -> Void in
            attributedString.addAttributes([.foregroundColor : titleColor, .font : titleFont], range: range)
        }
        return attributedString
    }
}
