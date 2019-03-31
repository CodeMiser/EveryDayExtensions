//
//  Date+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 2/17/19.
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

extension Date {

    private static var hhmmDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }

    init(_ hhmm: String) {
//        let components = hhmm.components(separatedBy: ":")
//        assert(components.count == 2)
//        let hour = Int(components[0]) ?? 0
//        let minute = Int(components[1]) ?? 0
//        self = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        self = Date.hhmmDateFormatter.date(from: hhmm)!
    }

    var hhmm: String {
//        let hour = self.component(.hour)
//        let minute = self.component(.minute)
//        return String(format: "%d:%02d", hour, minute)
        return Date.hhmmDateFormatter.string(from: self)
    }
    var day: Int { return self.component(.day) }
    var hour: Int { return self.component(.hour) }

    func priorToToday() -> Bool {
        let now = Date()
        return self.day != now.day && self.timeIntervalSince(now) < 0
    }

    private func component(_ component: Calendar.Component) -> Int {
        // https://stackoverflow.com/questions/32649039/formatting-time-of-the-day-swift-morning-afternoon-evening-any-time
        return Calendar.current.component(component, from: self)
    }
}
