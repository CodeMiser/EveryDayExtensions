//
//  NetworkResponse.swift
//  NovelEditor
//
//  Created by Mark on 11/2/24.
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

protocol NetworkResponse: Decodable {
    init?(response: Result<[AnyHashable: Any], NetworkError>)
    init?(dictionary: [AnyHashable: Any])
    init?(json: String)
    init?(data: Data)
}

extension NetworkResponse {

    init?(response: Result<[AnyHashable: Any], NetworkError>) {
        switch response {
        case .success(let dictionary):
            self.init(dictionary: dictionary)
        case .failure:
            return nil
        }
    }

    init?(dictionary: [AnyHashable: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary)
            self.init(data: data)
        } catch {
            print("Failed to serialize dictionary: \(error)")
            return nil
        }
        return
    }

    init?(json: String) {
        let data = Data(json.utf8)
        self.init(data: data)
    }

    init?(data: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        do {
            self = try decoder.decode(Self.self, from: data) as Self
        } catch {
            print("Failed to decode data: \(error)")
            return nil
        }
    }
}

enum NetworkError: Error {
    case decodingFailed
    case invalidURL
    case noResponse
    case serverError(statusCode: Int)
    case unknown(Error)
}
