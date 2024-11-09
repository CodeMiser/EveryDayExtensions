//
//  NetworkSession.swift
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

class NetworkSession {

    private let baseUrl: String
    private var headers: [String: String]

    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.headers = [:]
    }

    func setHeader(field: String, value: String) {
        self.headers[field] = value
    }

    func perform(request: NetworkRequest, completion: @escaping (Data?, NetworkError?) -> Void) {
        guard let urlRequest = request.asURLRequest(baseURL: self.baseUrl, headers: self.headers) else {
            completion(nil, .invalidURL)
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error {
                completion(nil, .unknown(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, .serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1))
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
