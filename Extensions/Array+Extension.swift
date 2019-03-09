//
//  Array+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 1/12/19.
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

extension Array {

    func index(of object: Any) -> Int? {
        return (self as NSArray).index(of: object)
    }

    mutating func remove(object: Any) {

        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }

    //TODO: shim for Swift 5
    // https://stackoverflow.com/questions/25398608/count-number-of-items-in-an-array-with-a-specific-property-value
    func count(where closure: (_ element: Element) -> Bool) -> Int {
        var count = 0
        for element in self {
            count += closure(element) ? 1 : 0
        }
        return count
    }

    mutating func move(from: Int, to: Int) {
        // https://stackoverflow.com/questions/36541764/how-to-rearrange-item-of-an-array-to-new-position-in-swift
        self.insert(self.remove(at: from), at: to)
    }
}
