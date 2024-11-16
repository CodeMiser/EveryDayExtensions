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

    private var overflowUsers =  OverflowUsers()
    private var currentPage = 1
    private let pageSize = 20
    private var totalPages = Int.max // will be adjusted based on `hasMore` or `total`
    private var isFetching: Set<Int> = [] // track pages currently being fetched

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchOverflowUsers(page: self.currentPage)
    }

    private func fetchOverflowUsers(page: Int) {
        guard !isFetching.contains(page), page < self.totalPages else { return }

        api.fetchUsers(page: page, pageSize: self.pageSize) { (overflowUsers: OverflowUsers?) in
            self.isFetching.remove(page)

            if let overflowUsers {
                self.totalPages = overflowUsers.hasNoMorePages ? page : Int.max
                self.overflowUsers.append(collection: overflowUsers)
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension OverflowViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.overflowUsers.items[indexPath.row]
        let vc = OverflowUserViewController.makeFromStoryboard()
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension OverflowViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let threshold = self.overflowUsers.items.count - 5
        if indexPaths.contains(where: { $0.row >= threshold }) {
            self.fetchOverflowUsers(page: self.currentPage + 1)
            self.currentPage += 1
        }
    }
}

// MARK: - UITableViewDataSource

extension OverflowViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.overflowUsers.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.overflowUsers.items[indexPath.row]
        let cell = OverflowUserCell.cell(from: tableView, for: indexPath) as! OverflowUserCell
        cell.configure(user: user)
        return cell
    }
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
