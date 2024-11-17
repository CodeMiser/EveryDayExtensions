//
//  NetworkPagingCollection.swift
//  EveryDayExtensions
//
//  Created by Mark & 4o on 11/16/24.
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

import Foundation

class NetworkPagingCollection<Item: Decodable> {

    private var collection: NetworkCollection<Item>
    private var currentPage: Int
    private let pageSize: Int
    private var isFetching: Set<Int>

    init(pageSize: Int) {
        self.collection = NetworkCollection<Item>()
        self.currentPage = 0
        self.pageSize = pageSize
        self.isFetching = []
    }

    // MARK: - UITableView Helper Methods

    func needsFetch(for indexPaths: [IndexPath], margin: Int = 5) -> Bool {
        let threshold = self.collection.items.count - margin
        return indexPaths.contains(where: { $0.row >= threshold })
    }

    var newIndexPaths: [IndexPath] {
        let startIndex = self.collection.items.count - self.pageSize
        let endIndex = collection.items.count - 1
        return (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
    }

    // MARK: - UIViewController Helper Methods

    var count: Int {
        return self.collection.items.count
    }

    subscript(index: Int) -> Item {
        return self.collection.items[index]
    }

    // MARK: - NetworkRequest Helper Methods

    var shouldFetchPage: Bool {
        return !self.isFetching.contains(self.currentPage + 1) && self.collection.hasMore
    }

    func fetchingNextPage() {
        self.isFetching.insert(self.currentPage + 1)
    }

    var pagingParameters: [String: Any] {
        return [
            "page": self.currentPage + 1,
            "pagesize": self.pageSize,
        ]
    }

    func fetchFailed() {
        self.isFetching.remove(self.currentPage + 1)
    }

    func append(newCollection: NetworkCollection<Item>) {
        self.isFetching.remove(self.currentPage + 1)

        self.collection.items.append(contentsOf: newCollection.items)
        self.collection.hasMore = newCollection.hasMore
        self.currentPage += 1
    }
}
