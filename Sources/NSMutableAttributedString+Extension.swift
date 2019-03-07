//
//  NSMutableAttributedString+Extension.swift
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

import Foundation

extension NSMutableAttributedString {

    func enumeratePattern(_ pattern: Character = "*", using block: (NSRange) -> Void) {
        var index = self.string.startIndex
        while index.encodedOffset < self.string.count {
            guard let first = self.string[index...].firstIndex(of: pattern) else { break }
            guard let second = self.string[self.string.index(after:first)...].firstIndex(of: pattern) else { break }
            self.removeCharacter(at: second)
            self.removeCharacter(at: first)
            let location = first.encodedOffset
            let length = second.encodedOffset - first.encodedOffset - 1
            let range = NSRange(location: location, length: length)
            block(range)
            index = self.string.index(self.string.startIndex, offsetBy: location + length)
        }
    }

    func removeCharacter(at index: String.Index) {
        let range = NSRange(location: index.encodedOffset, length: 1)
        self.replaceCharacters(in: range, with: "")
    }
}
