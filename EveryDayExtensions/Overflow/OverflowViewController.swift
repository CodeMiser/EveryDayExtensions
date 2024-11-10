//
//  OverflowViewController.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/10/24.
//  Copyright © 2024 FTLapps, inc. All rights reserved.
//

import UIKit

class OverflowViewController: UIViewController, Storyboardable {

    static var storyboardName: String { "Overflow" }

    @IBOutlet private var tableView: UITableView!

    private var overflowUsers: [OverflowUser] = []

//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchOverflowUsers()
    }

    private func fetchOverflowUsers() {
        api.fetchUsers { (overflowUsers: OverflowUsers?) in
            self.overflowUsers = overflowUsers?.items ?? []
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension OverflowViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.overflowUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.overflowUsers[indexPath.row]
        let cell = OverflowUserCell.cell(from: tableView, for: indexPath) as! OverflowUserCell
        cell.configure(user: user)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension OverflowViewController: UITableViewDelegate {
    // Placeholder for UITableViewDelegate methods if needed
}

// MARK: - OverflowUserCell

class OverflowUserCell: UITableViewCell {

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var userIdLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var reputationLabel: UILabel!

    func configure(user: OverflowUser) {
        self.nameLabel.text = user.displayName
        self.userIdLabel.text = "User ID: \(user.userId)"
        self.locationLabel.text = "\(user.location ?? "")"
        self.reputationLabel.text = "Reputation: \(user.reputation)"
        if let imageUrl = user.profileImage {
            self.profileImageView.setImage(urlString: imageUrl, placeholderString: "")
        }
    }
}
