//
//  OverflowUserViewController.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/12/24.
//
// The MIT License (MIT)
//
// Copyright (c) 2024 FTLapps LLC
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

class OverflowUserViewController: UIViewController, Storyboardable {

    var user: OverflowUser!

    static var storyboardName: String { "Overflow" }

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var reputationLabel: UILabel!
    @IBOutlet private var displayNameLabel: UILabel!
    @IBOutlet private var userIdLabel: UILabel!
    @IBOutlet private var acceptRateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var badgeCountsGoldLabel: UILabel!
    @IBOutlet private var badgeCountsSilverLabel: UILabel!
    @IBOutlet private var badgeCountsBronzeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImageView.setImage(urlString: self.user.profileImage, placeholderString: "defaultAvatar")

        self.reputationLabel.text = "Reputation: \(self.user.reputation)"

        self.displayNameLabel.text = self.user.displayName

        self.userIdLabel.text = "User ID: \(self.user.userId)"

        if let acceptRate = self.user.acceptRate {
            self.acceptRateLabel.text = "Accept Rate: \(acceptRate)%"
        } else {
            self.acceptRateLabel.text = "Accept Rate: Not Available"
        }

        if let location = self.user.location {
            self.locationLabel.text = location
        } else {
            self.locationLabel.text = "Location: Not Available"
        }

        self.badgeCountsGoldLabel.text = "Gold: \(self.user.badgeCounts.gold)"
        self.badgeCountsSilverLabel.text = "Silver: \(self.user.badgeCounts.silver)"
        self.badgeCountsBronzeLabel.text = "Bronze: \(self.user.badgeCounts.bronze)"
    }
}
