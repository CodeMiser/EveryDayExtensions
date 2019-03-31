//
//  Character+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/10/19.
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

// https://stackoverflow.com/questions/29835242/whats-the-simplest-way-to-convert-from-a-single-character-string-to-an-ascii-va
extension Character {

    //TODO: remove shim for Swift 5
    var isASCII: Bool {
        return unicodeScalars.allSatisfy { $0.isASCII }
    }
    
    //TODO: remove shim for Swift 5 (return UInt32? instead of UInt8?)
    var asciiValue: UInt32? {
        return isASCII ? unicodeScalars.first?.value : nil
    }

    //TODO: remove shim for Swift 5
    var hexDigitValue: Int? {
        switch self {
        case "0"..."9":
            return Int(self.asciiValue! - Character("0").asciiValue!)
        case "A"..."F":
            return Int(self.asciiValue! - Character("A").asciiValue! + 10)
        case "a"..."f":
            return Int(self.asciiValue! - Character("a").asciiValue! + 10)
        default:
            return nil
        }
    }
}
