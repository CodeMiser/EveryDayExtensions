//
//  UITextField+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/3/19.
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

extension UITextField {

    static let placeholderAlpha = CGFloat(0.5) // 0.23 is the empirical default for black on white, but 0.5 works better generally

    var placeholderTextColor: UIColor {
        set {
            if let placeholder = self.placeholder {
                self.attributedPlaceholder = placeholder.attributed(newValue.withAlphaComponent(UITextField.placeholderAlpha), self.font!)
            }
        }
        get {
            return textColor!.withAlphaComponent(UITextField.placeholderAlpha)
        }
    }

    var borderColor: UIColor {
        set {
            self.layer.borderWidth = 1.0
            self.layer.borderColor = newValue.cgColor
            self.layer.cornerRadius = 4.0
        }
        get {
            if let borderColor = self.layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return .clear
        }
    }
}
