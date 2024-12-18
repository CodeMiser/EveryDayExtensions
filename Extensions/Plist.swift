//
//  Plist.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 2/22/19.
//
// The MIT License (MIT)
//
// Copyright (c) 2019 FTLapps LLC
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

class Plist: NSObject {

    // https://stackoverflow.com/questions/24045570/how-do-i-get-a-plist-as-a-dictionary-in-swift
    static func dictionary(_ filename: String) -> [String : AnyObject] {
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {
            if let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] {
                return dictionary
            }
        }
        return [:]
    }

    static func array(from filename: String) -> [AnyObject] {
        let key = filename.lowercased()
        let dictionary = Plist.dictionary(filename)
        return dictionary[key]  as! [AnyObject]
    }

    static func strings(from filename: String) -> [String] {
        return Plist.array(from: filename)  as! [String]
    }
}
