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

    //TODO: shim for Swift 5
    var isASCII: Bool {
        return unicodeScalars.allSatisfy { $0.isASCII }
    }
    
    //TODO: shim for Swift 5
    var asciiValue: UInt32? {
        return isASCII ? unicodeScalars.first?.value : nil
    }
}
