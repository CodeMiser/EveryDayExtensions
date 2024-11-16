//
//  Date+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 2/17/19.
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

extension Date {

    func priorToToday() -> Bool {
        let now = Date()
        return self.day != now.day && self.timeIntervalSince(now) < 0
    }

    init(_ hhmm: String) {
        self = Date.hhmmDateFormatter.date(from: hhmm)!
    }

    var hhmmString: String {
        return Date.hhmmDateFormatter.string(from: self)
    }

    private static var hhmmDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }

    var iso8601String: String {
        return ISO8601DateFormatter.string(from: self, timeZone: .current, formatOptions: .withInternetDateTime)
    }

    var day: Int { return self.component(.day) }

    var hour: Int { return self.component(.hour) }

    var minute: Int { return self.component(.minute) }

    var second: Int { return self.component(.second) }

    private func component(_ component: Calendar.Component) -> Int {
        // https://stackoverflow.com/questions/32649039/formatting-time-of-the-day-swift-morning-afternoon-evening-any-time
        return Calendar.current.component(component, from: self)
    }
}
