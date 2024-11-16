//
//  OverflowViewController.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/10/24.
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

class OverflowViewController: UIViewController, Storyboardable {

    static var storyboardName: String { "Overflow" }

    @IBOutlet private var tableView: UITableView!

    private var overflowUsers = NetworkPagingCollection<OverflowUser>(pageSize: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchOverflowUsers()
    }

    private func fetchOverflowUsers() {
        api.fetchOverflowUsers(self.overflowUsers) { (collection: NetworkPagingCollection<OverflowUser>?) in
            if let collection {
                self.tableView.insertRows(at: collection.newIndexPaths, with: .fade)
            }
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension OverflowViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if self.overflowUsers.needsFetch(for: indexPaths) {
            self.fetchOverflowUsers()
        }
    }
}

// MARK: - UITableViewDelegate

extension OverflowViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let user = self.overflowUsers[indexPath.row]
        let vc = OverflowUserViewController.makeFromStoryboard()
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.reputationLabel.text = "\(user.reputation)"
        if let imageUrl = user.profileImage {
            self.profileImageView.setImage(urlString: imageUrl, placeholderString: "")
        }
    }
}
