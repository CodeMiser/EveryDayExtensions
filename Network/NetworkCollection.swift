//
//  NetworkCollection.swift
//  NovelEditor
//
//  Created by Mark on 11/4/24.
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

class NetworkCollection<Item: Decodable>: NetworkResponse {

    var items: [Item]
    var lastPage: Int
    var perPage: Int
    var page: Int
    var total: Int

    init(perPage: Int) {
        self.items = []
        self.lastPage = 0
        self.perPage = perPage
        self.page = 0
        self.total = 0
    }

    func append(collection: NetworkCollection<Item>) {
        self.items.append(contentsOf: collection.items)
        if self.page == 0 {
            self.lastPage = collection.lastPage
            self.page = collection.page
            self.total = collection.total
        } else {
            self.page = collection.page
        }
    }
}
