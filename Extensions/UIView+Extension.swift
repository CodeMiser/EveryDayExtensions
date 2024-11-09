//
//  UIView+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 2/16/19.
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

let animationDuration = 0.25

extension UIView {

    @IBInspectable var rounded: Bool {
        get {
            return layer.cornerRadius > 0
        }
        set {
            layer.cornerRadius = newValue ? min(layer.frame.width, layer.frame.height) / 2 : 0
            layer.masksToBounds = newValue
        }
    }

    // https://stackoverflow.com/questions/1509547/giving-uiview-rounded-corners
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    func setIsHidden(_ hidden: Bool, animated: Bool) {
        if self.isHidden && !hidden {
            self.alpha = 0.0
            self.isHidden = false
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = hidden ? 0.0 : 1.0
        }) { (complete) in
            self.isHidden = hidden
        }
    }

    func fadeIn(duration: TimeInterval = 0.25) {
        self.isHidden = false
        self.alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }

    func setAlpha(_ alpha: CGFloat, animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = alpha
        }
    }
}
