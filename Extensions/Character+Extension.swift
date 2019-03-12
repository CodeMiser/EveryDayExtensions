//
//  Character+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/10/19.
//  Copyright © 2019 FTLapps, inc. All rights reserved.
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
