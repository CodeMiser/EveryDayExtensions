//
//  NetworkRequest.swift
//  NovelEditor
//
//  Created by Mark on 11/3/24.
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

class NetworkRequest {

    enum Method: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
    private let method: Method
    private let path: String
    private var parameters: [String: Any]
    private var body: Data?

    init(_ method: Method, _ path: String, parameters: [String : Any]) {
        self.method = method
        self.path = path
        self.parameters = parameters
        if method != .GET {
            self.body = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
    }

    init(_ method: Method, _ path: String, model: Encodable) {
        assert(method != .GET, "GET requests must not have a body")
        self.method = method
        self.path = path
        self.parameters = [:]
        self.body = try? JSONEncoder().encode(model)
    }

    init(_ method: Method, _ path: String) { // for use with NetworkCollection
        self.method = method
        self.path = path
        self.parameters = [:]
        self.body = nil
    }
}

extension NetworkRequest {

    func execute(completion: @escaping (Bool) -> Void) {
        api.session.perform(request: self) { (_: Data?, error: NetworkError?) in
            completion(error == nil)
        }
    }

//    func executePaging<Item: Decodable>(collection: NetworkCollection<Item>, pageSize: Int, completion: @escaping (NetworkCollection<Item>?) -> Void) {
    func executePaging<Item: Decodable>(page: Int, pageSize: Int, completion: @escaping (NetworkCollection<Item>?) -> Void) {
//        if collection.hasNoMorePages {
//            completion(collection)
//            return
//        }
//        let page = collection.items.count / pageSize + 1
        self.parameters["page"] = page
        self.parameters["pagesize"] = pageSize
        if self.method != .GET {
            self.body = try? JSONSerialization.data(withJSONObject: parameters)
        }
        self.execute { (response: NetworkCollection<Item>?) in
            if let response {
//                collection.append(collection: response)
                completion(response)
            } else {
                completion(nil)
            }
        }
    }

    func execute<T: NetworkResponse>(completion: @escaping (T?) -> Void) {
        self.execute { (response: T?, _: NetworkError?) in
            completion(response)
        }
    }

    func execute<T: NetworkResponse>(cacheType: CacheType? = nil, completion: @escaping (T?, NetworkError?) -> Void) {
        let cacheKey = self.cacheKey()

        if let cacheType, let cachedData = api.cache.load(forKey: cacheKey, cacheType: cacheType) {
            if let cachedResponse = T(data: cachedData) {
                completion(cachedResponse, nil)
                return
            }
        }

        api.session.perform(request: self) { (data: Data?, error: NetworkError?) in
            if let error {
                completion(nil, error)
                return
            }
            guard let data else {
                completion(nil, .noResponse)
                return
            }

            guard let response = T(data: data) else {
                //print("Response: \(String(data: data, encoding: .utf8) ?? "<Empty>")")
                completion(nil, .decodingFailed)
                return
            }

            if let cacheType {
                api.cache.save(data, forKey: cacheKey, cacheType: cacheType)
            }

            completion(response, nil)
        }
    }

    // MARK: - executeCached helper

    private func cacheKey() -> String {
        return "\(method.rawValue):\(path)"
    }

    // MARK: - NetworkSession helper

    func asURLRequest(baseURL: String, headers: [String: String]) -> URLRequest? {
        guard let url = (
            method == .GET
            ? self.constructURL(baseURL: baseURL, path: self.path, parameters: self.parameters)
            : URL(string: baseURL + self.path)
        )
        else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.httpBody = self.body
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }

    private func constructURL(baseURL: String, path: String, parameters: [String: Any]) -> URL {
        assert(path.first == "/", "path must start with '/'")
        guard method == .GET, var urlComponents = URLComponents(string: baseURL + path) else {
            return URL(string: path)!
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: "\($0)", value: "\($1)") }
        return urlComponents.url ?? URL(string: path)!
    }
}
