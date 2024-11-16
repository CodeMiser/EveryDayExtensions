//
//  OverflowUserViewController.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/12/24.
//  Copyright © 2024 FTLapps, inc. All rights reserved.
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
