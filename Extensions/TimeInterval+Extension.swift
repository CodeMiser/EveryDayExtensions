//
//  TimeInterval+Extension.swift
//  EveryDay
//
//  Created by Mark Poesch on 5/26/19.
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

extension Int {

    var seconds: TimeInterval {
        return TimeInterval(self)
    }

    var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }

    var hours: TimeInterval {
        return TimeInterval(self * 60 * 60)
    }

    var days: TimeInterval {
        return TimeInterval(self * 60 * 60 * 24)
    }

    var weeks: TimeInterval {
        return TimeInterval(self * 60 * 60 * 24 * 7)
    }
}

extension TimeInterval {

    init(date: Date) {
        self = date.hour.hours + date.minute.minutes + date.second.seconds
    }

    init(hours: Int, minutes: Int, seconds: Int) {
        self = hours.hours + minutes.minutes + seconds.seconds
    }

    var secondsComponent: Int {
        return Int(self) % 60
    }

    var minutesComponent: Int {
        return (Int(self) / 60) % 60
    }

    // MARK: -

    var seconds: Int {
        return Int(self)
    }

    var minutes: Int {
        return Int(self) / 60
    }

    var hours: Int {
        return Int(self) / (60 * 60)
    }

    var days: Int {
        return Int(self) / (60 * 60 * 24)
    }

    // MARK: -

    var mssString: String {
        return String(format: "%d:%02d", self.minutes, self.secondsComponent)
    }
}
