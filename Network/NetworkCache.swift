//
//  NetworkCache.swift
//  NovelEditor
//
//  Created by Mark & 4o on 11/5/24.
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

enum CacheType {
    case memory
    case disk
}

class NetworkCache {

    private var cache: [String: Data] = [:]
    
    func save(_ data: Data, forKey key: String, cacheType: CacheType) {
        switch cacheType {
        case .memory:
            cache[key] = data
        case .disk:
            cache[key] = data
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load(forKey key: String, cacheType: CacheType) -> Data? {
        if let data = cache[key] {
            return data
        }
        if cacheType == .disk, let data = UserDefaults.standard.data(forKey: key) {
            cache[key] = data
            return data
        }
        return nil
    }

    func purge() {
        self.cache.removeAll()
    }
}
